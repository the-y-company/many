install: check
	R -s -e "devtools::install()"

check: document
	R -s -e "devtools::check()"

document:
	R -s -e "many::document()"

site:
	R -s -e "pkgdown::build_site()"
