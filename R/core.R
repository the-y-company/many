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
  list.files(
    src, 
    pattern = "*.R$", 
    recursive = TRUE
  ) |>
    lapply(\(file) {
      file <- file.path(src, file)
      bundle_file(file = file, dest = dest)
    }) |> 
    invisible()
}

#' @rdname bundle
#' @export
bundle_file <- \(file, dest = "R") {
  if(missing(file))
    stop("missing file")

  destination <- make_destination_file(file, dest)
  remove_file(destination)

  # should not happen: failsafe.
  if(file.exists(destination)){
    cat(destination, "already exists, skipping:", file, "\n")
    return()
  }

  cat(file, "copied to", destination, "\n")

  file.copy(
    file, 
    to = destination,
    overwrite = FALSE
  )
}
