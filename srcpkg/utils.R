#' Create Directory
#' 
#' Create directory if it does not exist.
#' 
#' @param dir Directory to create.
#' 
#' @keywords internal
create_dir_if_not_exists <- \(dir){
  if(dir.exists(dir))
    return()

  dir.create(dir)
}

#' Make Destination File
#' 
#' Make destination path for file copy.
#' 
#' @param srcfile Source file to copy.
#' @param destdir Desitnation directory.
#' 
#' @keywords internal
make_destination_file <- \(srcfile, destdir) {
  fl <- srcfile |>
    strsplit("/") |>
    (\(.) .[[1]])()

  fl <- fl[2:length(fl)] |>
    (\(.) paste0(., collapse = "-"))()

  file.path(destdir, fl)
}

#' Remove file
#' 
#' Remove file if exists.
#' 
#' @param file Path to file.
#' 
#' @keywords internal
remove_file <- \(file) {
  if(missing(file))
    stop("missing file")

  if(!file.exists(file))
    return(invisible(FALSE))

  file.remove(file) |>
    invisible()
}
