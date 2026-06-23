# Environmental Tropes Workshop

You will use these Quarto notebooks to move from literary interpretation to a
small computational analysis.

The corpus has already been prepared for you. Your task begins with the
interpretive decision: which words should count as environmental language, and
what role should those words play in the analysis?

## Notebooks

Open the notebooks in this order:

1. `01_build_environmental_lexicon.qmd`
2. `02_analyse_environmental_sentences.qmd`
3. `03_interpret_environmental_tropes.qmd`

For the opening reading exercise, use:

- `reading_extracts.md`

## The Main Idea

The computer is not discovering environment by itself. It is applying the
definition of environment that you give it.

The workflow is:

```text
reading -> categories -> lexicon -> extraction -> patterns -> interpretation
```

## Key Terms

- `entity`: an environmental thing or place, such as forest, river, garden, sky.
- `process`: an environmental event or transformation, such as storm, rain, flood.
- `condition`: a quality or state, such as dark, green, barren, cloudless.
- `trigger`: a word used to retrieve likely environmental sentences.
- `descriptor`: a word used to analyse how an environment is described.
- `trope`: a larger interpretive pattern that you recognise in the results.

## Data

The prepared corpus is:

```text
data/children_lit_sentences.csv
```

The original Project Gutenberg text files are available in:

```text
source_texts/
```

Lexicon templates are available in:

```text
templates/lexicon_template.csv
templates/lexicon_template.xlsx
templates/term_list_template.csv
```

For the first exercise, the easiest route is usually to complete
`templates/lexicon_template.xlsx` and save the finished file as:

```text
data/student_lexicon.xlsx
```

Notebook 1 will save a CSV copy for the later notebooks.

It contains sentence-level extracts from:

- Frances Hodgson Burnett, *The Secret Garden*
- Kenneth Grahame, *The Wind in the Willows*
- Rudyard Kipling, *The Jungle Book*
- L. Frank Baum, *The Wonderful Wizard of Oz*

## Optional Future Adaptation: German Texts

The notebooks can also be adapted for German children's literature if you have a
German sentence-level corpus with the same columns as `data/children_lit_sentences.csv`.

For German texts, keep the category labels in English:

```text
entity, process, condition, exclude
trigger, descriptor, exclude
```

But use German terms in the `term` column, such as `wald`, `fluss`, `garten`,
`sturm`, `regen`, `dunkel`, `wild`, or `tief`.

German corpora may need more variants because of inflection and compounds:

- `wald`, `walde`, `waldes`, `waelder`
- `waldweg`, `flussufer`, `gartenmauer`
- `grün` / `gruen`, depending on how the text has been cleaned
