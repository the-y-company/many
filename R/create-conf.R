#' Configuration
#' 
#' Create configuration bundler.
#' 
#' @export
use_conf <- \(){
  file <- "many.R"

  if(file.exists(file))
    stop(file, "already exists")

  cli_alert_success(
    sprintf(
      "File {.file %s} created",
      file
    )
  )

  tmp <- system.file("templates/conf.R", package = "many") 
  file.copy(tmp, file)
  use_build_ignore(file)
  invisible(TRUE)
}
