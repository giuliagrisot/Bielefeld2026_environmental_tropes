# 00_setup.R
# Workshop setup: packages, file paths, and basic checks.

required_packages <- c(
  "tidyverse",
  "tidytext"
)

missing_packages <- required_packages[
  !required_packages %in% rownames(installed.packages())
]

if (length(missing_packages) > 0) {
  message("The following packages are missing:")
  message(paste(missing_packages, collapse = ", "))
  message("Install them with:")
  message("install.packages(c(", paste(sprintf('\"%s\"', missing_packages), collapse = ", "), "))")
  stop("Please install the missing packages, then run this script again.")
}

library(tidyverse)
library(tidytext)

data_dir <- "data"
output_dir <- "output"

dir.create(output_dir, showWarnings = FALSE)

lexicon_file <- file.path(data_dir, "student_lexicon.csv")
lexicon_template_file <- file.path(data_dir, "student_lexicon_template.csv")
corpus_file <- file.path(data_dir, "children_lit_sentences.csv")

check_file <- function(path, suggestion = NULL) {
  if (!file.exists(path)) {
    message("Missing file: ", path)
    if (!is.null(suggestion)) {
      message(suggestion)
    }
    stop("Required input file is missing.")
  }
}

regex_escape <- function(x) {
  stringr::str_replace_all(x, "([\\\\.^$|()\\[\\]{}*+?])", "\\\\\\1")
}

normalise_term <- function(x) {
  x %>%
    stringr::str_to_lower() %>%
    stringr::str_squish()
}

message("Setup complete.")
message("Data folder: ", data_dir)
message("Output folder: ", output_dir)

