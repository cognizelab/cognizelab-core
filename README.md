# cognizelab-core

Shared, project-agnostic code for the lab: Python, MATLAB, R, and shell
utilities used across multiple fMRI/cognition projects (preprocessing helpers,
common analysis/statistics routines, plotting, cluster job templates, etc.).

Project-specific code does **not** live here — it lives in each project's own
repo (see [`project-template`](../project-template) for the skeleton new
projects start from). Projects depend on `cognizelab-core` rather than duplicating
code.

## Layout

```
cognizelab-core/
├── python/         # pip-installable "cognizelabcore" package
│   ├── src/cognizelabcore/
│   │   ├── io/             # loading/saving data (BIDS paths, NIfTI I/O helpers, etc.)
│   │   ├── preprocessing/  # generic preprocessing helpers (wrappers around fMRIPrep/nipype steps)
│   │   ├── analysis/       # shared analysis routines (GLM helpers, ROI extraction, connectivity)
│   │   ├── stats/          # stats helpers (permutation tests, multiple-comparison correction, etc.)
│   │   └── viz/            # plotting helpers (brain maps, timeseries, publication-style figures)
│   └── tests/
├── matlab/
│   ├── +cognizelabcore/  # MATLAB "package" folder (call functions as cognizelabcore.myFunc(...))
│   ├── spm/         # SPM-specific helper scripts/batch templates
│   └── conn/        # CONN toolbox helper scripts/batch templates
├── r/               # lightweight R package (functions in R/, load with devtools::load_all())
├── shell/
│   ├── cluster/     # SLURM/SGE job script templates for HPC
│   └── pipelines/   # generic pipeline orchestration scripts
└── docs/            # extra documentation
```

## Using this in a project

**Python** — install in editable mode from a project's environment:
```bash
pip install -e /path/to/cognizelab-core/python
# or, once pushed to GitHub:
pip install git+https://github.com/cognizelab/cognizelab-core.git#subdirectory=python
```

**MATLAB** — add to path at the top of a project script:
```matlab
addpath(genpath('/path/to/cognizelab-core/matlab'))
```

**R** — load functions directly:
```r
devtools::load_all("/path/to/cognizelab-core/r")
```

**Shell** — source or copy templates from `shell/cluster` and `shell/pipelines`
into a project's own `code/00_setup/` folder as needed.

## Versioning

Bump `version` in `python/pyproject.toml` and `CITATION.cff` when you make a
release. Tag releases in git (`git tag v0.2.0 && git push --tags`) so project
repos can pin to a specific `cognizelab-core` version if needed.

## Contributing

This is a single-lab utility repo — no formal process, just: add a function,
add a docstring, add a minimal test if it's Python, commit with a clear
message.
