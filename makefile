install: check
	R -s -e "devtools::install()"

check: document
	R -s -e "devtools::check()"

document:
	R -s -e "devtools::document()"

