#' many
#'
#' Bundle files.
#'
#' @importFrom roxygen2 roclet roxy_tag_warning block_get_tags roclet_output
#' @importFrom roxygen2 roclet_process roxy_tag_parse rd_section roxy_tag_rd
#'
#' @rdname roclets
#' @export
roclet_many <- function() {
  roclet("many")
}

#' @export
roclet_process.roclet_many <- function(x, blocks, env, base_path, ...) { # nolint
  list()
}

#' @export
roclet_output.roclet_many <- function(x, results, base_path, ...) { # nolint
  roxygen2::load_pkgload(base_path)

  many::bundle()

  invisible(NULL)
}

#' @export
roxy_tag_parse.roxy_tag_many <- function(x) { # nolint
  list()
}
