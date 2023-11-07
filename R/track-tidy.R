#' Tidy
#'
#' Tidy copied files, removes all files.
#'
#' @inheritParams bundle
#'
#' @export
tidy <- \(src = "srcpkg", dest = "R"){
  # because file.path does not strip that !?
  src <- gsub("/$", "", src)
  dest <- gsub("/$", "", dest)

  existing_dest_files <- list.files(
    dest,
    pattern = "*.R$",
    recursive = TRUE
  ) |>
    (\(.) file.path(dest, .))()

  expected_dest_files <- list.files(
    src,
    pattern = "*.R$",
    recursive = TRUE
  ) |>
    sapply(\(file) {
      file <- file.path(src, file)
      make_destination_file(file, dest)
    }) |>
    unname()

  to_delete <- existing_dest_files[!existing_dest_files %in% expected_dest_files]

  # we need to keep this file regardless
  to_delete <- to_delete[!to_delete %in% file.path(dest, "00_DO_NOT_EDIT.R")]

  if (!length(to_delete)) {
    return(invisible())
  }

  to_delete |>
    sapply(\(file){
      info("REMOVING:  ", bold(file))
      remove_file(file)
    })

  invisible(to_delete)
}
