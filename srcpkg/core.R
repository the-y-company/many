#' Bundle
#'
#' Bundles R files from nested directory into a flat one.
#'
#' @param src Source directory.
#' @param file Source file to copy.
#' @param dest Destination directory.
#'
#' @name bundle
#' @export
bundle <- \(src = "srcpkg", dest = "R"){
  if(!is_many()){
    error("this is not a \"many\" project, run `use_many()`\n")
    return(invisible())
  }

  # because file.path does not strip that !?
  src <- gsub("/$", "", src)
  dest <- gsub("/$", "", dest)

  list.files(
    src,
    pattern = "*.R$",
    recursive = TRUE
  ) |>
    lapply(\(file) {
      file <- file.path(src, file)
      bundle_file(file = file, dest = dest)
    })

  tidy(src, dest)
  save_hashes()

  invisible()
}

#' @rdname bundle
#' @export
bundle_file <- \(file, dest = "R") {
  if (missing(file)) {
    stop("missing file")
  }

  destination <- make_destination_file(file, dest)

  if (!hash_match(destination, type = "dst")) {
    error("MISMATCH:  ", bold(destination), " it looks like it was edited, delete manually and re-run.\n")
    return()
  }

  if (hash_match(file, default = FALSE)) {
    info("UNCHANGED: ", underline(file), ".\n")
    return()
  }

  # we cleanup
  remove_file(destination)

  copied <- file.copy(
    file,
    to = destination,
    overwrite = FALSE
  )

  # really should not happen
  if (!copied) {
    error("ERROR:     copying ", underline(file), " to ", bold(destination), "\n")
    return()
  }

  success("COPIED:    ", underline(file), " copied to ", bold(destination), "\n")

  hash_set(file, type = "src")
  hash_set(destination, type = "dst")

  invisible(copied)
}
