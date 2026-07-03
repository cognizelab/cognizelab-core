# pipelines/

Generic pipeline-orchestration scripts shared across projects — e.g. a
wrapper that loops over BIDS subjects and submits one SLURM job per subject,
or a script that chains fMRIPrep -> denoising -> first-level GLM. Keep the
subject-loop/orchestration logic here; keep project-specific parameters in
the calling project's own `code/00_setup/` scripts.
