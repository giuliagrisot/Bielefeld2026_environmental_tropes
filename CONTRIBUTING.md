# Contributing

Thank you for helping improve these workshop materials.

This repository supports a workshop on environmental tropes and computational
text analysis. Changes should keep the materials usable for participants who are
new to R and who are moving between literary interpretation and structured data.

## Workflow

- Keep `main` as the stable workshop-ready version.
- Create a branch for each meaningful change, for example
  `lesson/lexicon-workflow`, `fix/source-text-cleaning`, or
  `docs/license-note`.
- Make small commits with clear messages.
- Open a pull request before merging into `main` when the change affects
  teaching flow, package requirements, source text handling, or prepared data.
- Before merging, run the edited notebook chunks where practical.

## What to Commit

Commit source materials:

- Quarto notebooks (`.qmd`)
- workshop reading extracts and templates
- small prepared data needed for the workshop
- README, citation, and license files

Avoid committing local or generated files:

- `.Rhistory`
- `.RData` session files
- `.Rproj.user/`
- `Rplots.pdf`
- cache folders
- participant-generated `data/student_lexicon.csv`
- participant-generated trope annotation files
- large regenerated data unless intentionally part of the workshop

## Workshop Material Principles

- Keep the interpretive decision visible: categories and lexicons are arguments,
  not neutral inputs.
- Prefer one clear workflow over several competing workflows.
- Add comments that explain what each chunk does for beginner students.
- Keep processing manageable in local RStudio and online environments.
- When adding computational summaries, include a way to return to sentences and
  close reading.

## Release Practice

Before teaching, create a GitHub release such as `v2026.0` so participants and
future users can access a stable version of the materials.
