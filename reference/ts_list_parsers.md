# List installed tree-sitter parsers

The ts package contains a common interface to several tree-sitter
parsers, implemented in other R packages. `ts_list_parsers()` lists the
available parsers installed in the system.

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

## Details

To see tree-sitter parser packages that are available on CRAN, but not
installed on your system, see the packages that depend on ts and have a
name with a 'ts' prefix.

Here is an example that includes all tree-sitter parsers at this time:

    ts_list_parsers()

    #> # A data frame: 2 × 5
    #>   package version    title           library                    loaded
    #> * <chr>   <chr>      <chr>           <chr>                      <lgl>
    #> 1 tsjsonc 0.0.0.9000 Edit JSON Files /Users/gaborcsardi/Librar… FALSE
    #> 2 tstoml  0.0.0.9000 Edit TOML files /Users/gaborcsardi/Librar… FALSE

## Examples

``` r
ts_list_parsers()
#> # A data frame: 2 × 5
#>   package version    title           library                     loaded
#> * <chr>   <chr>      <chr>           <chr>                       <lgl> 
#> 1 tsjsonc 0.0.0.9000 Edit JSON Files /home/runner/work/_temp/Li… TRUE  
#> 2 tstoml  0.0.0.9000 Edit TOML files /home/runner/work/_temp/Li… TRUE  
```
