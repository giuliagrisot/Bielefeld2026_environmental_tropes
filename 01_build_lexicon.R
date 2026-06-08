# 01_build_lexicon.R
# From interpretation to operational categories.

source("00_setup.R")

check_file(
  lexicon_file,
  paste(
    "Use the template at",
    lexicon_template_file,
    "and save the completed file as",
    lexicon_file
  )
)

lexicon <- readr::read_csv(
  lexicon_file,
  show_col_types = FALSE
) %>%
  mutate(
    term = normalise_term(term),
    type = normalise_term(type),
    role = normalise_term(role)
  ) %>%
  filter(!is.na(term), term != "")

expected_columns <- c("term", "type", "role")
missing_columns <- setdiff(expected_columns, names(lexicon))

if (length(missing_columns) > 0) {
  stop(
    "The lexicon is missing these columns: ",
    paste(missing_columns, collapse = ", ")
  )
}

valid_types <- c("entity", "process", "condition", "exclude")
valid_roles <- c("trigger", "descriptor", "exclude")

invalid_types <- lexicon %>%
  filter(!type %in% valid_types)

invalid_roles <- lexicon %>%
  filter(!role %in% valid_roles)

if (nrow(invalid_types) > 0) {
  print(invalid_types)
  stop("Some terms have an invalid type.")
}

if (nrow(invalid_roles) > 0) {
  print(invalid_roles)
  stop("Some terms have an invalid role.")
}

lexicon_clean <- lexicon %>%
  distinct(term, .keep_all = TRUE)

message("Lexicon loaded.")
message("Number of terms: ", nrow(lexicon_clean))

message("\nTerms by type:")
print(count(lexicon_clean, type, sort = TRUE))

message("\nTerms by role:")
print(count(lexicon_clean, role, sort = TRUE))

message("\nBorderline or excluded terms:")
print(
  lexicon_clean %>%
    filter(type == "exclude" | role == "exclude" | !is.na(notes) & notes != "") %>%
    select(term, type, role, notes)
)

readr::write_csv(
  lexicon_clean,
  file.path(output_dir, "01_lexicon_clean.csv")
)

message("\nSaved: output/01_lexicon_clean.csv")

