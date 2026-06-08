# 04_from_patterns_to_tropes.R
# The computer extracts patterns. We interpret those patterns as tropes.

source("03_find_descriptor_patterns.R")

trope_file <- file.path(data_dir, "trope_annotations.csv")
trope_template_file <- file.path(data_dir, "trope_annotations_template.csv")

top_pairs_for_annotation <- pair_counts %>%
  arrange(desc(n), pair) %>%
  slice_head(n = 50) %>%
  mutate(
    proposed_trope = "",
    evidence_or_reason = ""
  )

readr::write_csv(
  top_pairs_for_annotation,
  trope_template_file
)

message("Saved annotation template: ", trope_template_file)
message("Open this file and add a proposed trope for each pattern.")
message("Examples: threatening wilderness, renewal, scarcity, climatic extremity.")

if (!file.exists(trope_file)) {
  message("\nWhen you have completed the annotation, save it as:")
  message(trope_file)
  message("\nThe script will then summarise trope frequencies.")
} else {
  trope_annotations <- readr::read_csv(
    trope_file,
    show_col_types = FALSE
  ) %>%
    mutate(
      proposed_trope = normalise_term(proposed_trope)
    ) %>%
    filter(!is.na(proposed_trope), proposed_trope != "")

  trope_summary <- trope_annotations %>%
    group_by(proposed_trope) %>%
    summarise(
      total_pair_tokens = sum(n),
      unique_pairs = n_distinct(pair),
      examples = paste(head(pair, 5), collapse = "; "),
      .groups = "drop"
    ) %>%
    arrange(desc(total_pair_tokens))

  message("\nTrope summary:")
  print(trope_summary)

  readr::write_csv(
    trope_summary,
    file.path(output_dir, "04_trope_summary.csv")
  )

  message("\nSaved: output/04_trope_summary.csv")
}

message("\nReflection questions:")
message("1. Where did interpretation enter the workflow?")
message("2. What did operationalisation make visible?")
message("3. What did the method miss or flatten?")

