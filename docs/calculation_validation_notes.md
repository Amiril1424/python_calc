# Calculation Validation Notes

Dokumen ini mencatat hasil perbandingan calculation engine Python dengan
referensi VBA/PDF. Catatan yang belum berstatus `confirmed` tidak boleh dipakai
untuk membuat atau mengubah logic engineering tanpa konfirmasi.

## d_st = 1 - Act Disaster Prevention

Reference case: `output/Check_dst-1.pdf`.

### Confirmed rounding rules

- `structure_height_m` adalah top elevation Pole tertinggi, bukan elevasi
  object tertinggi.
- Wind pressure dibulatkan 1 decimal.
- Calculated center height/center length untuk Pole, Direct Object, OHW, dan
  Arm dibulatkan ke 3 angka di belakang desimal sebelum dipakai dalam
  calculation berikutnya pada d_st 1, 2, 3, 4, 5, 6, dan 9. d_st 7 dikecualikan
  dan tetap mengikuti 3 significant figures VBA `Fkb_SF`.
- Gravitasi untuk d_st 1, 2, 3, 4, 5, 6, dan 9 adalah `9.80665 m/s2`.
- Straight Pole:
  1. hitung massa per meter;
  2. kalikan gravitasi;
  3. round 2 decimal untuk unit weight dalam N/m;
  4. kalikan active length dan Pole overdesign factor;
  5. round 1 decimal untuk FixLoad Pole.
- Taper Pole:
  1. hitung volume dikali density `7850 kg/m3`;
  2. round massa ke 1 decimal dalam kg;
  3. kalikan gravitasi dan Pole overdesign factor;
  4. round FixLoad ke 1 decimal.
- Semua hasil decimal pada d_st 1, 2, 3, 4, 5, 6, dan 9 memakai perilaku
  Excel `ROUND`: nilai tepat setengah dibulatkan menjauhi nol. Aturan ini
  berlaku untuk geometry/section property, area, load, moment, stress, dan
  safety factor sesuai jumlah decimal masing-masing kategori.
- Float hasil formula dinormalisasi ke batas 15 significant decimal digits
  Excel sebelum proses `ROUND`, sehingga misalnya `0.175 * 0.1` dibaca sebagai
  `0.0175` dan dibulatkan menjadi `0.018` pada 3 decimal places.
- d_st 7 memakai gravitasi `9.81 m/s2` dan significant-figure sequence dari
  VBA Class Module.

### Values matching the reference

| Evaluated position (m) | Total FixLoad PDF/Python (N) | Total seismic PDF/Python (N) | Seismic moment PDF/Python (N.m) |
|---:|---:|---:|---:|
| 9.69 | 1204.8 | 602.6 | 1501.5 |
| 4.00 | 2615.8 | 1303.5 | 6924.5 |
| 0.00 | 4033.1 | 2012.2 | 13555.9 |

Individual Pole results matching the reference:

| Pole | FixLoad (N) | Wind load (N) |
|---|---:|---:|
| Pole-1 | 900.7 | 1289.3 |
| Pole-2 | 1401.7 | 1446.6 |
| Pole-3 | 1417.3 | 946.5 |

Wind pressure matches the reference at `1683.4 N/m2`.

### Deferred difference - OHW

The remaining d_st 1 difference is isolated to the OHW contribution:

| Evaluated position (m) | PDF wind load (N) | Python wind load (N) | PDF wind moment (N.m) | Python wind moment (N.m) |
|---:|---:|---:|---:|---:|
| 4.00 | 3669.2 | 3668.8 | 20863.5 | 20952.8 |
| 0.00 | 4615.7 | 4615.3 | 37433.3 | 37704.6 |

Current finding: the PDF appears not to include the OHW wind-tension moment in
the d_st 1 resultant moment, while the current Python evaluated-position path
does. The exact OHW wind-load rounding also differs by `0.4 N`. This difference
is intentionally deferred and must not be silently corrected without a later
engineering confirmation.

## d_st = 3 - Old Lighting Pole

Status: next validation target. Input and VBA/PDF reference values will be
recorded here before changing calculation logic.
