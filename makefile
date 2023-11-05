install: check
	R -e "devtools::install()"

check: document
	R -e "devtools::check()"

install: check
	R -e "devtools::install()"

document:
	R -e "devtools::document()"

