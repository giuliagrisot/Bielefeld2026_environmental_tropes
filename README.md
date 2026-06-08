# From Forests to Rivers: Identifying Environmental Tropes in Children's Literature

Repository for the Bielefeld 2026 workshop.

These scripts follow the framework from the accompanying paper:

1. Build an environmental lexicon.
2. Separate terms by analytical role: trigger or descriptor.
3. Use trigger terms to retrieve environmental sentences.
4. Use descriptor terms to inspect how environments are represented.
5. Interpret recurring patterns as environmental tropes.

The key idea is:

> The computer is not discovering environment. It is applying our definition of environment.

## Files

- `00_setup.R`: checks packages, paths, and input files.
- `01_build_lexicon.R`: loads and summarises the student lexicon.
- `02_extract_environmental_sentences.R`: retrieves sentences using trigger terms.
- `03_find_descriptor_patterns.R`: extracts descriptor-trigger combinations.
- `04_from_patterns_to_tropes.R`: helps students group patterns into tropes.

## Input Data

Place the corpus file here:

```text
data/children_lit_sentences.csv
```

It should contain at least these columns:

```text
sentence_id,title,author,sentence
```

Create the student lexicon from:

```text
data/student_lexicon_template.csv
```

Save the completed version as:

```text
data/student_lexicon.csv
```

The completed lexicon should contain:

```text
term,type,role,notes
```

Use:

- `type`: `entity`, `process`, `condition`, or `exclude`
- `role`: `trigger`, `descriptor`, or `exclude`

## Running the Workshop

Run the scripts in order:

```r
source("00_setup.R")
source("01_build_lexicon.R")
source("02_extract_environmental_sentences.R")
source("03_find_descriptor_patterns.R")
source("04_from_patterns_to_tropes.R")
```

Each script writes its results to the `output/` folder.
