<div align="center">
# Many

Use _many_ directories to build R packages.

This allows using many folders to write R packages,
letting you structure the project more or less how you
want but keep the existing R toolchain around R packages
(testing, documentation, etc.).

</div>

## Usage

The function `bundle` looks, by default, for
`.R` files in the `srcpkg` and simply copies
them to the `/R` directory whilst tracking of
changes in the hidden `.many` file.
If that process fails you can run `reset` to clear
that file.

The `srcpkg` can contain multiple nested directories,
for an example look at the source code the this package.

Everything else remains the same, e.g.: use of `inst`, etc.

You can set the `MANY_VERBOSE` environment variable to `FALSE` if
you want to switch off all messages.

## Setup

You can use the `use_many()` function from the root of
a package.

It will create the `srcpkg` directory and copy existing files
from the `R/` directory to it.

```r
# usethis::create_package("my.pkg")
# setwd("my.pkg")
many::use_many()
```

> Note that the `R` directory gets wiped at every `bundle`
> call. Do not edit any of the files within it.

From there call `many::bundle()` to copy your files across.

## Bundling

You do not want to run `bundle()` manually after every change to the
source code.

Below are some options, pick your favourite.

### Roclet

Use the roxygen2 roclet `many::roclet_many` in your `DESCRIPTION` as indicated
below in order to bundle the files every time you run `devtools::document()`.

```r
Roxygen: list(markdown = TRUE, roclets = c("collate", "namespace", "rd", "many::roclet_many"))
```

### RStudio Addin

Look for the "Bundle" addin in RStudio and select it.
The addin will bundle any file in `srcpkg` on save.

### Vscode

The easiest is probably to add a command to the
[emeraldwalk plugin](https://marketplace.visualstudio.com/items?itemName=emeraldwalk.RunOnSave).

```json
"emeraldwalk.runonsave": {
	"commands": [
		{
			"match": "*.R$",
			"isAsync": false,
			"cmd": "R -s -e 'many::bundle(\\'${file}\\')'"
		},
	]
}
```
