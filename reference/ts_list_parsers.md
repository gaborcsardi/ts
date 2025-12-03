# List installed tree-sitter parsers

List installed tree-sitter parsers

## Usage

``` r
ts_list_parsers(lib_path = .libPaths())
```

## Arguments

- lib_path:

  Library paths to search for installed packages. Default is
  [`base::.libPaths()`](https://rdrr.io/r/base/libPaths.html).

## Value

A data frame with columns:

- `package`: character, the name of the package.

- `version`: character, the version of the package.

- `title`: character, the title of the package.

- `library`: character, the library path where the package is installed.

- `loaded`: logical, whether the package is currently loaded.

## Examples

``` r
ts_list_parsers()
#> # A data frame: 1 × 5
#>   package version    title           library                     loaded
#>   <chr>   <chr>      <chr>           <chr>                       <lgl> 
#> 1 tsjsonc 0.0.0.9000 Edit JSON Files /home/runner/work/_temp/Li… TRUE  
```
