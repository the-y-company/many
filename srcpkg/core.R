#' Bundle
#'
#' Bundles R files from nested directory into a flat one.
#'
#' @param file Source file to copy.
#'
#' @name bundle
#' @export
bundle <- \(plugin = c(), ...){
  if(!is_many()){
    error("this is not a \"many\" project, run `use_many()`\n")
    return(invisible())
  }

  # because file.path does not strip that !?
  src <- "srcpkg"
  dest <- "R"

  bundle_announce("{.pkg many}: bundling")
  on.exit({
    bundle_done("{.pkg many}: done")
  })

  list.files(
    src,
    pattern = "*.R$",
    recursive = TRUE
  ) |>
    lapply(\(file) {
      file <- file.path(src, file)
      bundle_file(file = file)
    })

  tidy(src, dest)
  save_hashes()

  invisible()
}

#' @rdname bundle
#' @export
bundle_file <- \(file, ...) {
  if (missing(file)) {
    stop("missing file")
  }

  destination <- make_destination_file(file, "R")

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
