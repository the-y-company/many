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
  files <- list.files(
    src, 
    pattern = "*.R$", 
    recursive = TRUE
  ) |>
    lapply(\(file) {
      file <- file.path(src, file)
      bundle_file(file = file, dest = dest)
    })

  save_hashes() 
}

#' @rdname bundle
#' @export
bundle_file <- \(file, dest = "R") {
  if(missing(file))
    stop("missing file")

  destination <- make_destination_file(file, dest)

  if(!hash_match(destination, type = "dst")) {
    cat("ignoring", destination, "it looks like it way edited, delete manually and re-run.\n")
    return()
  }
    
  remove_file(destination)

  # should not happen: failsafe.
  if(file.exists(destination)){
    cat(destination, "already exists, skipping:", file, "\n")
    return()
  }

  cat(file, "copied to", destination, "\n")

  copied <- file.copy(
    file, 
    to = destination,
    overwrite = FALSE
  )

  hash_set(file, type = "src")
  hash_set(destination, type = "dst")

  invisible(copied)
}
