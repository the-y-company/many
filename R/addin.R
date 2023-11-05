#' Bundle on Save
#'
#' Bundle file on save.
#'
#' @export
bundle_on_save <- \(){
  handle <- rstudioapi::registerCommandCallback(
    "saveSourceDoc", 
    \() {
      doc <- rstudioapi::getActiveDocumentContext()
      print(doc)
      bundle_file(doc$path)
      rstudioapi::showDialog(
        "many",
        "Files bundled"
      )
    })
}
