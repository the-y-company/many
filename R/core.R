#' Bundle
#' 
#' Bundles R files from nested directory into a flat one.
#' 
#' @param src Source directory.
#' @param dest Destination directory.
#' 
#' @export
bundle <- \(src = "srcpkg", dest = "R"){
  cleanup(dest)
  
  list.files(
    ".", 
    pattern = "*.R$", 
    recursive = TRUE
  ) |>
    lapply(\(file) {
      destination <- make_destination_file(file, dest)

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
    })
}

make_destination_file <- \(srcfile, destdir) {
  base <- basename(srcfile)
  sprintf("%s/%s", destdir, base)
}

cleanup <- \(destdir) {
  cat("cleaning up", destdir, "\n")

  if(dir.exists(destdir))
    unlink(destdir, recursive = TRUE, force = TRUE)

  create_dir_if_not_exists(destdir)
}
