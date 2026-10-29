# Panduan Integrasi Output d_st = 3

Dokumen ini menjelaskan prosedur penggunaan output component untuk
`d_st = 3` (Old Lighting Pole), alur kerjanya, class yang perlu diakses oleh
backend, struktur data yang dipakai frontend, serta adapter nomor `1-104`
untuk report legacy.

## 1. Tujuan dan batas tanggung jawab

Calculation engine menghitung nilai engineering. Output layer hanya membaca
hasil calculation dan menyusunnya menjadi DTO/JSON sesuai kebutuhan standard.
Output mapper tidak menjalankan ulang atau mengubah rumus engineering.

```text
Domain input
    -> DesignStandard + CalculationWorkflow
    -> CalculationService
    -> Standard34CalculationResult
    -> Standard3OutputSource
    -> Standard3OutputMapper
    -> Standard3Output
    -> JSON/API/Frontend/Report
```

Pemisahan ini penting agar:

- calculation engine tetap menggunakan unit internal yang konsisten;
- format report dapat berubah tanpa mengubah rumus;
- setiap design standard mempunyai mapping sendiri;
- backend tidak perlu membaca object calculation secara manual;
- frontend memperoleh key yang stabil dan tidak ambigu.

## 2. Lokasi komponen

| File | Komponen | Tanggung jawab |
|---|---|---|
| `application/output/mapper_factory.py` | `StandardOutputMapperFactory` | Memilih mapper berdasarkan `d_st` |
| `application/output/standard_3.py` | `Standard3OutputMapper` | Mapping lengkap khusus `d_st=3` |
| `application/output/models.py` | `Standard3OutputSource` | Membawa calculation result dan input context ke mapper |
| `application/output/models.py` | `Standard3Output` | DTO final `d_st=3` |
| `application/output/models.py` | `SkeletonStandardOutput` | Output kosong eksplisit untuk standard yang belum dibuat |
| `application/output/__init__.py` | Public imports | Import path stabil bagi caller |
| `application/calculation_service.py` | `CalculationService` | Menjalankan workflow pada evaluation height |
| `calculation/standard_34_workflow.py` | `Standard34CalculationWorkflow` | Calculation workflow `d_st=3/4` |
| `calculation/result.py` | `Standard34CalculationResult` | Raw immutable calculation result |
| `manual_check.py` | Helper manual | Contoh input, eksekusi, dan JSON output |

Caller dianjurkan menggunakan public import:

```python
from application.output import (
    Standard3OutputSource,
    StandardOutputMapperFactory,
)
```

Jangan bergantung langsung pada private method seperti `_arm_outputs()` atau
`_numbered_output()`.

## 3. Status output setiap standard

| d_st | Status output |
|---:|---|
| 1 | Skeleton `NOT_IMPLEMENTED` |
| 2 | Skeleton `NOT_IMPLEMENTED` |
| 3 | `READY`, schema `1.0` |
| 4 | Skeleton `NOT_IMPLEMENTED` |
| 5 | Skeleton `NOT_IMPLEMENTED` |
| 6 | Skeleton `NOT_IMPLEMENTED` |
| 7 | Skeleton `NOT_IMPLEMENTED` |
| 8 | Ditolak dengan `NotImplementedError` |
| 9 | Skeleton `NOT_IMPLEMENTED` |

Factory tidak pernah memakai mapper standard lain sebagai fallback.

## 4. Cara menjalankan contoh manual

Jalankan dari folder `python_calc`.

### 4.1 Calculation output di terminal

Atur selector dalam `manual_check.py` bila ingin memakai entry point utama:

```python
SELECTED_D_ST = 3
```

Kemudian:

```powershell
python manual_check.py
```

### 4.2 JSON output d_st 3

Tanpa mengubah selector:

```powershell
python -c "from manual_check import print_manual_output_json; print_manual_output_json(3)"
```

Mengakses DTO dari Python:

```python
from manual_check import build_manual_output

output = build_manual_output(3)
payload = output.to_dict()
```

`build_manual_output()` adalah helper validasi/presentasi. Backend production
sebaiknya mengikuti prosedur pada bagian berikutnya.

## 5. Prosedur backend production

### 5.1 Jalankan calculation

Backend membentuk `DesignStandard`, domain input, dan
`Standard34CalculationWorkflow`, kemudian menjalankan:

```python
results = CalculationService(workflow).calculate(
    evaluated_positions_m
)
```

`results` bertipe:

```python
tuple[Standard34CalculationResult, ...]
```

Urutan result mengikuti urutan `evaluated_positions_m` yang diberikan caller.

### 5.2 Bentuk output source

```python
from application.output import Standard3OutputSource

source = Standard3OutputSource(
    calculation_results=results,
    poles=poles,
    direct_objects=direct_objects,
    overhead_wires=overhead_wires,
    arm_assembly=arm_assembly,
)
```

Input context tetap diberikan karena beberapa nilai report adalah input-only,
misalnya diameter wire, span, sag ratio, quantity, dan nama object. Mapper tidak
mencari nilai tersebut dari global state.

### 5.3 Pilih mapper

```python
from application.output import StandardOutputMapperFactory

mapper = StandardOutputMapperFactory.create(3)
```

### 5.4 Map dan serialize

```python
output = mapper.map(source)
payload = output.to_dict()
```

Contoh response framework:

```python
return JSONResponse(content=payload)
```

`to_dict()` mengubah key integer `numbered_output` menjadi string karena key
object JSON selalu berupa string.

## 6. Cara kerja Standard3OutputMapper

Method public:

```python
Standard3OutputMapper.map(source)
```

Urutan internalnya:

1. Memvalidasi bahwa source adalah `Standard3OutputSource`.
2. Memastikan result tidak kosong dan seluruh result berasal dari `d_st=3`.
3. Membaca wind speed, air density, dan wind pressure dari standard policy.
4. Membentuk list OHW melalui `_wire_outputs()`.
5. Membentuk list Arm/Arm Object melalui `_arm_outputs()`.
6. Membentuk hasil setiap evaluation height melalui
   `_evaluated_position_output()`.
7. Membentuk adapter report `1-104` melalui `_numbered_output()`.
8. Mengembalikan immutable `Standard3Output`.

Private methods hanya detail implementasi mapper dan bukan public API.

## 7. Struktur payload utama

```json
{
  "design_standard": 3,
  "design_standard_name": "Old Lighting Pole",
  "schema_version": "1.0",
  "status": "READY",
  "conditions": {},
  "overhead_wires": [],
  "arms": [],
  "evaluated_positions": [],
  "numbered_output": {}
}
```

### 7.1 Metadata

| Key | Arti |
|---|---|
| `design_standard` | Numeric design-standard code |
| `design_standard_name` | Nama stabil standard |
| `schema_version` | Versi kontrak payload; saat ini `1.0` |
| `status` | `READY` jika mapper sudah tersedia |

### 7.2 `conditions`

| Key | Unit/format | Arti |
|---|---|---|
| `standard_label` | string | Label report legacy (`JIL`) |
| `wind_speed_m_s` | m/s | Wind speed calculation |
| `air_density_kg_m3` | kg/m3 | Air density |
| `wind_pressure_n_m2` | N/m2 | Wind pressure |
| `pole_shape_factor` | dimensionless | Shape factor Pole |
| `arm_object_shape_factor` | dimensionless | Default report coefficient object Arm |
| `overhead_wire_shape_factor` | dimensionless | Shape factor OHW |
| `short_term_allowable_bending_stress_n_mm2` | N/mm2 | Allowable bending stress |
| `wind_case.code` | string | `STRAIGHT` |
| `wind_case.direction_deg` | degree | `90.0` untuk arah N |

### 7.3 `overhead_wires[]`

Satu entry dibuat untuk setiap OHW aktif pada input.

| Key | Unit | Arti |
|---|---|---|
| `name` | string | Identifier/nama wire |
| `diameter_mm` | mm | Diameter wire |
| `mass_per_length_kg_m` | kg/m | Massa per panjang |
| `elevation_m` | m | Fix height |
| `span_length_m` | m | Full span |
| `sag_ratio_percent` | % | Sag ratio |
| `wind_coefficient` | dimensionless | Cf wire |
| `fix_load_per_length_n_m` | N/m | Berat per panjang |
| `fixed_tension_n` | N | Tension akibat fix load |
| `combined_wind_line_load_n_m` | N/m | Resultant line load saat wind |
| `wind_tension_n` | N | Tension saat wind |

### 7.4 `arms[]`

Satu entry dibuat untuk setiap `ArmPart`, bukan satu entry untuk seluruh Arm
assembly.

Bagian utama:

- identitas dan ukuran Arm;
- `specification`;
- `objects[]`;
- `totals` dan safety result.

`objects[0]` selalu Arm Body. Object berikutnya adalah AO yang diurutkan dari
jarak horizontal terbesar ke jarak terkecil sesuai domain `ArmPart`.

Key penting `objects[]`:

| Key | Unit | Arti |
|---|---|---|
| `index` | integer | `0` untuk Arm Body |
| `quantity` | pcs | Quantity object |
| `fix_load_n` | N | FixLoad object |
| `projected_area_m2` | m2 | Directional projected area |
| `wind_coefficient` | dimensionless | Cf masing-masing object |
| `wind_load_n` | N | Wind load object |
| `horizontal_load_distance_m` | m | Jarak ke tumpuan Arm |
| `moment_due_to_fix_load_nm` | N.m | Local fix-load moment |
| `moment_due_to_wind_load_nm` | N.m | Local wind moment |

Key penting `totals`:

| Key | Unit/format | Arti |
|---|---|---|
| `fix_load_n` | N | Total FixLoad ArmPart |
| `wind_load_n` | N | Total wind load ArmPart |
| `moment_due_to_fix_load_nm` | N.m | Total local fix-load moment |
| `moment_due_to_wind_load_nm` | N.m | Total local wind moment |
| `combined_moment_nm` | N.m | Resultant moment Arm |
| `bending_stress_n_mm2` | N/mm2 | Arm bending stress |
| `allowable_stress_n_mm2` | N/mm2 | Allowable Arm |
| `utilization_ratio` | dimensionless | Stress/allowable |
| `limit_ratio` | dimensionless | Batas `1.0` |
| `status_code` | `OK`/`NG` | Machine-readable status |
| `status_display` | `O.K`/`N.G` | Legacy display status |

### 7.5 `evaluated_positions[]`

Satu entry dibuat untuk setiap evaluation height yang diminta.

Bagian utama:

- evaluated position dan Pole yang diperiksa;
- section properties pada titik tersebut;
- `load_rows[]` dinamis;
- `totals` dan final safety result.

`load_rows[]` dapat berisi:

```text
ARM
DIRECT_OBJECT
OVERHEAD_WIRE
POLE
```

Urutan report saat ini:

1. seluruh ArmPart;
2. seluruh Direct Object;
3. seluruh OHW;
4. seluruh active Pole dari atas ke bawah.

Jumlah row mengikuti input. Frontend wajib mengulang array ini dan tidak boleh
mengasumsikan selalu empat baris.

Untuk row `ARM`, `projected_area_m2` dan `wind_coefficient` memang tidak ada.
Tabel Pole menampilkan total satu ArmPart, sedangkan area/Cf tetap diperlihatkan
per komponen pada `arms[].objects[]`. Aturan blank ini berlaku bagi setiap Arm
jika terdapat dua, tiga, atau lebih ArmPart.

Key penting `totals`:

| Key | Unit/format | Arti |
|---|---|---|
| `vertical_fix_load_n` | N | Total vertical FixLoad |
| `ordinary_wind_load_n` | N | Total object wind load tanpa tension resultant |
| `wire_wind_tension_n` | N | OHW wind tension |
| `resultant_horizontal_load_n` | N | Resultant horizontal load |
| `moment_due_to_arm_fix_load_nm` | N.m | Total Arm fix-load moment |
| `ordinary_wind_moment_nm` | N.m | Ordinary wind bending moment |
| `wire_tension_moment_nm` | N.m | OHW tension moment |
| `combined_moment_nm` | N.m | Final resultant moment |
| `bending_stress_n_mm2` | N/mm2 | Pole bending stress |
| `allowable_stress_n_mm2` | N/mm2 | Pole allowable stress |
| `utilization_ratio` | dimensionless | Stress/allowable |
| `limit_ratio` | dimensionless | Batas `1.0` |
| `status_code` | `OK`/`NG` | Machine-readable status |
| `status_display` | `O.K`/`N.G` | Legacy display status |

## 8. Numbered output 1-104

`numbered_output` adalah adapter untuk template PDF lama. Semantic output tetap
menjadi kontrak utama backend/frontend.

### 8.1 Design condition: 1-7

| Nomor | Nilai |
|---:|---|
| 1 | Wind speed (m/s) |
| 2 | Air density (kg/m3) |
| 3 | Wind pressure (N/m2) |
| 4 | Pole shape/wind coefficient |
| 5 | Arm Object coefficient pada legend report |
| 6 | OHW coefficient pada legend report |
| 7 | Short-term allowable bending stress (N/mm2) |

### 8.2 OHW condition dan tension: 8-16

| Nomor | Nilai |
|---:|---|
| 8 | OHW name |
| 9 | Diameter (mm) |
| 10 | Mass per length (kg/m) |
| 11 | Span length (m) |
| 12 | Sag ratio (%) |
| 13 | Span yang dicetak pada tension section (m) |
| 14 | Fixed-load tension (N) |
| 15 | Wind tension (N) |
| 16 | Combined wind line load (N/m) |

### 8.3 Arm specification dan local safety: 17-49

| Nomor | Nilai |
|---:|---|
| 17-20 | Diameter, thickness, material, section modulus Arm |
| 21-22 | Arm Body name dan mounted-object name |
| 23-24 | Unit FixLoad |
| 25-26 | FixLoad quantity |
| 27-28 | Total FixLoad per row |
| 29 | Total FixLoad ArmPart |
| 30-31 | Projected area per Arm component |
| 32-33 | Cf per Arm component |
| 34-35 | Unit wind load |
| 36-37 | Wind-load quantity |
| 38-39 | Total wind load per row |
| 40 | Total wind load ArmPart |
| 41 | Moment due to FixLoad |
| 42 | Moment due to wind load |
| 43 | Combined Arm moment |
| 44-45 | Calculated Arm bending stress |
| 46 | Arm allowable stress |
| 47 | Arm utilization |
| 48 | `"< 1.0"` untuk OK atau `"> 1.0"` untuk NG |
| 49 | `"・・・O.K"` atau `"・・・N.G"` |

Nomor 21-39 mengikuti dua row pada template contoh: Arm Body dan satu AO.
Jika satu Arm mempunyai lebih banyak AO, frontend harus menggunakan
`arms[].objects[]` untuk membuat row tambahan.

### 8.4 Pole section dan load table: 50-91

| Nomor | Nilai |
|---:|---|
| 50-53 | Diameter, thickness, material, section modulus pada evaluation point |
| 54-57 | Empat nama row template legacy |
| 58-61 | Unit FixLoad |
| 62-65 | FixLoad quantity |
| 66-69 | Total FixLoad per row |
| 70 | Total vertical FixLoad |
| 71-74 | Projected area per row |
| 75-78 | Cf per row |
| 79-82 | Unit wind load |
| 83-86 | Wind-load quantity |
| 87-90 | Total wind load per row |
| 91 | Total ordinary wind load |

Area dan Cf pada setiap row `ARM` harus blank/`null`. Untuk template yang
mempunyai lebih dari empat row, gunakan `evaluated_positions[].load_rows[]`.

### 8.5 Pole moment, stress, dan summary: 92-104

| Nomor | Nilai |
|---:|---|
| 92 | Moment due to Arm FixLoad (N.m) |
| 93 | Ordinary wind moment (N.m) |
| 94 | OHW tension moment (N.m) |
| 95 | Combined moment (N.m) |
| 96-97 | Calculated Pole bending stress (N/mm2) |
| 98 | Pole allowable stress (N/mm2) |
| 99 | Pole utilization |
| 100 | `"< 1.0"` untuk OK atau `"> 1.0"` untuk NG |
| 101 | `"・・・O.K"` atau `"・・・N.G"` |
| 102 | Summary vertical load (N) |
| 103 | Summary resultant horizontal load (N) |
| 104 | Summary combined moment (N.m) |

## 9. Semantic output vs numbered output

Gunakan semantic output untuk:

- API contract;
- database/document storage;
- UI dinamis;
- structures dengan jumlah object berubah;
- audit dan debugging;
- future report layout.

Gunakan `numbered_output` hanya untuk:

- mengisi template report lama;
- comparison dengan nomor merah PDF;
- transitional integration dengan report generator existing.

Frontend tidak boleh memakai nomor `54-90` sebagai model data utama karena
template tersebut hanya mempunyai empat slot row.

## 10. Unit policy

Output `d_st=3` mempertahankan unit calculation engine:

| Besaran | Unit |
|---|---|
| Panjang/elevasi/jarak | m |
| Diameter/thickness | mm |
| Area angin | m2 |
| Section area | cm2 |
| Section modulus | cm3 |
| Moment of inertia | cm4 |
| Load | N |
| Moment | N.m |
| Stress | N/mm2 |
| Utilization | dimensionless |

Jangan mengonversi moment menjadi N.mm pada mapper `d_st=3`. Konversi khusus
New JIL akan menjadi tanggung jawab mapper `d_st=7`.

## 11. Status dan comparison display

Backend logic menggunakan:

```json
{
  "limit_ratio": 1.0,
  "status_code": "OK",
  "status_display": "O.K"
}
```

Adapter report mengubahnya menjadi:

```json
{
  "48": "< 1.0",
  "49": "・・・O.K",
  "100": "< 1.0",
  "101": "・・・O.K"
}
```

Untuk NG, teks menjadi `"> 1.0"` dan `"・・・N.G"`. Frontend dianjurkan
memakai `status_code` untuk warna/logic dan `status_display` atau numbered text
hanya untuk tampilan.

## 12. Error handling

| Kondisi | Error/status |
|---|---|
| Source bukan `Standard3OutputSource` | `TypeError` |
| Calculation result kosong | `ValueError` |
| Result bukan dari d_st 3 | `ValueError` |
| Mapper d_st 8 diminta | `NotImplementedError` |
| Mapper standard lain belum tersedia | Skeleton `NOT_IMPLEMENTED` |

Backend harus memeriksa `status` sebelum mengirim output ke report generator.

## 13. Testing dan verifikasi

Menjalankan test output saja:

```powershell
python -m unittest tests.test_standard_output -v
```

Menjalankan seluruh test:

```powershell
python -m unittest discover -s tests -q
```

Test output saat ini memverifikasi:

- factory memilih mapper/skeleton yang benar;
- d_st 8 ditolak secara eksplisit;
- payload dapat diserialisasi menjadi JSON;
- collection mengikuti input manual;
- nomor 1-104 tersedia;
- nilai utama Case 3 tidak berubah;
- status legacy OK dan NG benar;
- semantic key memuat unit.

## 14. Aturan perubahan schema

Perubahan berikut dianggap breaking change dan harus menaikkan
`schema_version`:

- mengganti atau menghapus semantic key;
- mengubah unit tanpa mengganti suffix key;
- mengubah tipe data key;
- mengubah arti `status_code`;
- mengubah struktur array menjadi object atau sebaliknya.

Menambah optional key baru dapat dilakukan tanpa breaking change, tetapi tetap
harus disertai test dan dokumentasi.

## 15. Checklist handoff backend/frontend

- Gunakan `StandardOutputMapperFactory`, bukan instantiate mapper berdasarkan
  tebakan nama standard.
- Simpan `schema_version` bersama payload.
- Gunakan semantic arrays untuk row dinamis.
- Gunakan suffix unit pada key sebagai sumber kebenaran unit.
- Gunakan `status_code` untuk logic aplikasi.
- Gunakan `numbered_output` hanya untuk legacy report.
- Perlakukan area/Cf row Arm sebagai blank pada tabel Pole.
- Jangan menjalankan ulang rumus dari nilai report di frontend.
- Jangan melakukan rounding tambahan di frontend kecuali formatting display.
- Jalankan regression test sebelum mengubah mapper.
