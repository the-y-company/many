ms <- NULL
md <- NULL

#' Create Maps
#' 
#' Create maps, either empty or with `.many` content.
#' 
#' @keywords internal
create_maps <- \() {
  md <<- mapper::map()
  ms <<- mapper::map()

  if(!file.exists(".many"))
    return()

  hashes <- jsonlite::read_json(".many")
  
  src <- hashes$src
  dst <- hashes$dst

  src |>
    seq_along() |>
    lapply(\(i) {
      ms$set(names(src)[i], src[[i]])
    })

  dst |>
    seq_along() |>
    lapply(\(i) {
      md$set(names(dst)[i], dst[[i]])
    })
}

# Create maps on load
.onLoad <- \(...) {
  create_maps()
}

#' Hash
#' 
#' Hash
#' 
#' @param file File to hash.
#' @param type Type of file to hash.
#' 
#' @name hash
#' @keywords internal
hash_set <- \(file, type = c("src", "dst")) {
  type <- match.arg(type)

  if(type == "src")
    ms$set(file, hash(file))
  else
    md$set(file, hash(file))

  invisible()
}

#' @rdname hash
#' @keywords internal
hash_get <- \(file, type = c("src", "dst")) {
  type <- match.arg(type)

  if(type == "src")
    return(ms$get(file))
  else
    return(md$get(file))

  invisible()
}

#' @rdname hash
#' @keywords internal
hash_has <- \(file, type = c("src", "dst")) {
  type <- match.arg(type)

  if(type == "src")
    return(ms$has(file))
  else
    return(md$has(file))
}

#' @rdname hash
#' @keywords internal
hash_match <- \(file, type = c("src", "dst"), default = TRUE) {
  old_hash <- hash_get(file, type = type)

  # this is the first time we run this
  # the corresponding R file does not yet exist
  if(!file.exists(file))
    return(default)

  new_hash <- hash(file)

  if(is.null(old_hash))
    return(default)

  identical(old_hash, new_hash)
}

#' @rdname hash
#' @keywords internal
hash_name <- \(file, type = c("src", "dst")) {
  if(missing(file))
    stop("missing file")

  type <- match.arg(type)

  sprintf("%s|%s", type, file)
}

#' Hash File
#' 
#' Hash file content
#' 
#' @param file File to hash.
#' 
#' @importFrom digest digest
hash <- \(file) {
  if(missing(file))
    stop("missing file")

  file |>
    readLines() |>
    digest(algo = "md5")
}

#' Save Hahshes
#' 
#' Save all hashes to file.
#' 
#' @keywords internal
save_hashes <- \(){
  sfiles <- ms$ls() |>
    sapply(\(key) ms$get(key))

  dfiles <- md$ls() |>
    sapply(\(key) md$get(key))

  list(
    src = as.list(sfiles),
    dst = as.list(dfiles)
  ) |>
    jsonlite::write_json(".many", auto_unbox = TRUE, pretty = TRUE)
}
