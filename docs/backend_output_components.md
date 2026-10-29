# Backend Output Components

Calculation engine tetap mengembalikan object result dalam unit engineering
internal. Layer `application.output` mengubah result tersebut menjadi DTO
JSON-ready sesuai design standard tanpa menjalankan ulang rumus calculation.

## Pemilihan mapper

```python
from application.output import StandardOutputMapperFactory

mapper = StandardOutputMapperFactory.create(design_standard)
```

Status implementasi:

| d_st | Output profile |
|---:|---|
| 1 | Skeleton `NOT_IMPLEMENTED` |
| 2 | Skeleton `NOT_IMPLEMENTED` |
| 3 | Implemented, schema version `1.0` |
| 4 | Skeleton `NOT_IMPLEMENTED` |
| 5 | Skeleton `NOT_IMPLEMENTED` |
| 6 | Skeleton `NOT_IMPLEMENTED` |
| 7 | Skeleton `NOT_IMPLEMENTED` |
| 8 | Explicit `NotImplementedError` |
| 9 | Skeleton `NOT_IMPLEMENTED` |

Mapper tidak pernah menggunakan mapping standard lain sebagai fallback.

## Menjalankan output manual d_st 3

Dari folder `python_calc`:

```powershell
python -c "from manual_check import print_manual_output_json; print_manual_output_json(3)"
```

Pemakaian melalui Python:

```python
from manual_check import build_manual_output

output = build_manual_output(3)
payload = output.to_dict()
```

## Struktur d_st 3

Payload utama berisi:

- `conditions`: kondisi standard, wind speed, wind pressure, allowable, dan
  arah angin report;
- `overhead_wires`: list dinamis berdasarkan input OHW;
- `arms`: list dinamis Arm, Arm Object, specification, local moment, dan
  safety result;
- `evaluated_positions`: list dinamis hasil tiap evaluation height dengan
  load rows dinamis untuk Arm, Direct Object, OHW, dan Pole;
- `numbered_output`: adapter nomor 1 sampai 104 untuk template PDF lama.

Nama semantic key selalu mencantumkan unit, misalnya `_m`, `_mm`, `_m2`,
`_n`, `_nm`, `_n_mm2`, atau `_kg_m`. `status_code` memakai `OK`/`NG`, sedangkan
`status_display` mempertahankan `O.K`/`N.G` untuk tampilan legacy.

## Dynamic rows dan numbered legacy layout

List semantic adalah sumber data utama bagi backend dan mengikuti jumlah input.
Adapter `numbered_output` mengikuti empat slot baris pada contoh PDF Case 3.
Untuk input lebih besar dari kapasitas template, backend harus membuat row dari
`evaluated_positions[].load_rows`, bukan memotong data berdasarkan nomor PDF.

Nomor area dan Cf pada setiap baris agregat ArmPart bernilai `null` secara
resmi. Tabel Pole menampilkan total FixLoad dan total wind load satu ArmPart,
sedangkan projected area dan Cf dibiarkan blank. Nilai area dan Cf setiap Arm
Body/AO tetap tersedia pada `arms[].objects[]`. Aturan ini tetap berlaku jika
terdapat dua, tiga, atau lebih ArmPart.

## Unit policy

Output d_st 3 mempertahankan unit engine: panjang dalam meter dan moment dalam
N.m. Konversi unit khusus standard, misalnya mm dan N.mm untuk New JIL, akan
ditempatkan pada mapper d_st 7 dan tidak mengubah calculation result.
