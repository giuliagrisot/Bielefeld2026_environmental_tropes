# 02_extract_environmental_sentences.R
# Trigger terms retrieve passages that are likely to be environmental.

source("01_build_lexicon.R")

check_file(
  corpus_file,
  "Add the prepared sentence-level corpus to data/children_lit_sentences.csv"
)

books <- readr::read_csv(
  corpus_file,
  show_col_types = FALSE
)

expected_corpus_columns <- c("sentence_id", "title", "author", "sentence")
missing_corpus_columns <- setdiff(expected_corpus_columns, names(books))

if (length(missing_corpus_columns) > 0) {
  stop(
    "The corpus is missing these columns: ",
    paste(missing_corpus_columns, collapse = ", ")
  )
}

trigger_terms <- lexicon_clean %>%
  filter(role == "trigger") %>%
  pull(term) %>%
  unique()

if (length(trigger_terms) == 0) {
  stop("No trigger terms found. Add terms with role = trigger to the lexicon.")
}

trigger_pattern <- paste0(
  "\\b(",
  paste(regex_escape(trigger_terms), collapse = "|"),
  ")\\b"
)

env_sentences <- books %>%
  mutate(sentence_lower = normalise_term(sentence)) %>%
  filter(stringr::str_detect(sentence_lower, trigger_pattern)) %>%
  mutate(
    trigger_matches = stringr::str_extract_all(sentence_lower, trigger_pattern),
    trigger_matches = purrr::map_chr(trigger_matches, ~ paste(unique(.x), collapse = "; "))
  ) %>%
  select(sentence_id, title, author, sentence, trigger_matches)

message("Environmental sentences retrieved: ", nrow(env_sentences))
message("Total sentences in corpus: ", nrow(books))
message("Retrieval rate: ", round(nrow(env_sentences) / nrow(books) * 100, 2), "%")

message("\nSample retrieved sentences:")
set.seed(2026)
print(
  env_sentences %>%
    slice_sample(n = min(10, nrow(env_sentences))) %>%
    select(title, sentence, trigger_matches)
)

readr::write_csv(
  env_sentences,
  file.path(output_dir, "02_environmental_sentences.csv")
)

message("\nSaved: output/02_environmental_sentences.csv")
message("\nDiscussion question: are these passages good examples of environmental representation?")
message("What has the trigger lexicon missed?")

