# 03_find_descriptor_patterns.R
# Descriptor terms help us ask how the environment is represented.

source("02_extract_environmental_sentences.R")

descriptor_terms <- lexicon_clean %>%
  filter(role == "descriptor") %>%
  pull(term) %>%
  unique()

if (length(descriptor_terms) == 0) {
  stop("No descriptor terms found. Add terms with role = descriptor to the lexicon.")
}

tokens <- env_sentences %>%
  select(sentence_id, title, author, sentence) %>%
  tidytext::unnest_tokens(
    output = "word",
    input = "sentence",
    token = "words",
    to_lower = TRUE
  ) %>%
  group_by(sentence_id) %>%
  mutate(
    token_position = row_number(),
    prev_word = lag(word),
    next_word = lead(word)
  ) %>%
  ungroup()

# Lag-based pattern:
# If a trigger term is preceded by a descriptor, capture descriptor + trigger.
# Examples: dark forest, barren field, rocky path.
descriptor_trigger_pairs <- tokens %>%
  filter(word %in% trigger_terms, prev_word %in% descriptor_terms) %>%
  transmute(
    sentence_id,
    title,
    author,
    descriptor = prev_word,
    trigger = word,
    pair = paste(descriptor, trigger)
  )

pair_counts <- descriptor_trigger_pairs %>%
  count(pair, descriptor, trigger, sort = TRUE)

message("Descriptor-trigger pairs found: ", nrow(descriptor_trigger_pairs))
message("Unique pairs found: ", nrow(pair_counts))

message("\nMost frequent descriptor-trigger pairs:")
print(head(pair_counts, 25))

readr::write_csv(
  descriptor_trigger_pairs,
  file.path(output_dir, "03_descriptor_trigger_pairs_long.csv")
)

readr::write_csv(
  pair_counts,
  file.path(output_dir, "03_descriptor_trigger_pair_counts.csv")
)

message("\nSaved:")
message("output/03_descriptor_trigger_pairs_long.csv")
message("output/03_descriptor_trigger_pair_counts.csv")

message("\nDiscussion question: what kind of environmental experience does each pair create?")

