# Stage 0 — Pre-refactor regression baseline

This document records the calculation engine's behaviour before the
`DesignStandard` refactor. It is a regression reference, not a declaration
that every current behaviour is the final engineering rule.

## Fixed scenario input

The object geometry and loads are identical to `manual_check.py`:

- Evaluated positions: `6.65 m`, `1.65 m`, and `0.0 m`.
- Three poles with top elevations `8.15 m`, `6.65 m`, and `1.65 m`.
- One Direct Object at `8.15 m`.
- One Overhead Wire at `5.75 m`.
- Seismic `k_value = 0.5`.
- Pole overdesign factor `= 1.0`.
- Structure height `= 8.15 m`.
- Standards 1 and 6 use Area Density Code `2` and wind speed `60 m/s`.

The complete reusable scenario is defined in
`tests/regression_scenarios.py`. Automated reference assertions are defined
in `tests/test_regression_baseline.py`.

## Wind-pressure references

Values are in `N/m²` and are listed at pole top elevations `8.15 m`, `6.65 m`,
and `1.65 m` respectively.

| Design standard | 8.15 m | 6.65 m | 1.65 m |
|---:|---:|---:|---:|
| 1 | 4443.120 | 4443.120 | 4443.120 |
| 2 | 2214.000 | 2214.000 | 2214.000 |
| 3 | 2214.000 | 2214.000 | 2214.000 |
| 6 | 6309.230 | 5936.986 | 5451.175 |

## EvaluatedPosition references — design standard 1

| Position (m) | Pole | FixLoad (N) | Seismic load (N) | N wind load (N) | Combined wind moment (N·m) | Wind bending stress (N/mm²) | Status |
|---:|---|---:|---:|---:|---:|---:|---|
| 6.65 | Pole-1 | 172.008641 | 86.004321 | 667.578780 | 663.968745 | 40.046366 | O.K |
| 1.65 | Pole-2 | 814.981648 | 407.490824 | 3272.734434 | 15707.605659 | 176.787908 | O.K |
| 0.00 | Pole-3 | 1103.591358 | 551.795679 | 4214.974630 | 23402.128265 | 263.389176 | N.G |

## EvaluatedPosition references — design standard 2

| Position (m) | Pole | FixLoad (N) | Seismic load (N) | N wind load (N) | Combined wind moment (N·m) | Wind bending stress (N/mm²) | Status |
|---:|---|---:|---:|---:|---:|---:|---|
| 6.65 | Pole-1 | 172.008641 | 86.004321 | 282.838500 | 293.493375 | 17.701651 | O.K |
| 1.65 | Pole-2 | 814.981648 | 407.490824 | 1404.450900 | 7954.893928 | 89.531727 | O.K |
| 0.00 | Pole-3 | 1103.591358 | 551.795679 | 1826.895384 | 11657.393390 | 131.203077 | O.K |

## EvaluatedPosition references — design standard 3 manual check

| Position (m) | Pole | FixLoad (N) | Seismic load (N) | N wind load (N) | Combined wind moment (N·m) | Wind bending stress (N/mm²) | Status |
|---:|---|---:|---:|---:|---:|---:|---|
| 6.65 | Pole-1 | 172.008641 | 86.004321 | 282.838500 | 293.493375 | 17.701651 | O.K |
| 1.65 | Pole-2 | 814.981648 | 407.490824 | 1404.450900 | 7954.893928 | 89.531727 | O.K |
| 0.00 | Pole-3 | 1103.591358 | 551.795679 | 1826.895384 | 11657.393390 | 131.203077 | O.K |

The current standard-3 path still calculates seismic because the existing
calculator is supplied with a `SeismicCondition`. This is recorded only to
detect unintended changes during refactoring. The confirmed future standard-3
default is no seismic calculation.

## EvaluatedPosition references — design standard 6

| Position (m) | Pole | FixLoad (N) | Seismic load (N) | N wind load (N) | Combined wind moment (N·m) | Wind bending stress (N/mm²) | Status |
|---:|---|---:|---:|---:|---:|---:|---|
| 6.65 | Pole-1 | 172.008641 | 86.004321 | 947.961807 | 942.835558 | 56.865836 | O.K |
| 1.65 | Pole-2 | 814.981648 | 407.490824 | 4646.904107 | 22299.059586 | 250.974222 | N.G |
| 0.00 | Pole-3 | 1103.591358 | 551.795679 | 5984.197261 | 33222.737085 | 373.919382 | N.G |

## Baseline interpretation

- Standards 2 and 3 currently produce the same values for this scenario.
- Standards 1 and 6 correctly expose Area Density Code `2`, symbol `II`,
  `alpha = 0.15`, `zb = 5 m`, and `zg = 350 m`.
- Only direction N is frozen here because it is the existing omni-report
  result. Direction-policy behaviour will be specified and tested separately
  during the DesignStandard refactor.
- A deliberate engineering-rule correction may update this baseline, but an
  incidental calculation change must fail the regression test.
