# Utility functions for ts language implementations

It is unlikely that you will need to use these functions directly,
except when implementing a new language for the ts package.

## Usage

``` r
ts_collapse(
  s,
  sep = ", ",
  sep2 = sub("^,", "", last),
  last = ", and ",
  trunc = Inf,
  width = Inf,
  ellipsis = "...",
  style = c("both-ends", "head")
)

ts_cnd(..., class = NULL, call = ts_caller_env(), .envir = parent.frame())

ts_caller_arg(arg)

as_ts_caller_arg(x)

# S3 method for class 'ts_caller_arg'
as.character(x, ...)

ts_caller_env(n = 1)

ts_check_named_arg(arg, frame = -1)

ts_parse_error_cnd(tree, text, call = ts_caller_env())
```

## Arguments

- s:

  For `ts_collapse()` a character vector to collapse.

- sep:

  Separator string for most elements.

- sep2:

  Separator string for two elements.

- last:

  Separator string before the last element.

- trunc:

  Integer, maximum number of elements to show before truncation.

- width:

  Integer, maximum display width of the collapsed string. If the
  collapsed string exceeds this width, it will be truncated with
  `ellipsis`.

- ellipsis:

  String to indicate truncation.

- style:

  Character, the collapsing style to use. Possible values are
  `"both-ends"` (the default), which shows the first few and last few
  elements when truncating, and `"head"`, which shows only the first few
  elements.

- ...:

  Arguments collapsed and interpolated into a condition message.

- class:

  A character vector of classes for the condition.

- call:

  Environment of the call to associate with the error condition,
  defaults to the caller's environment.

- .envir:

  The environment in which to evaluate the `...` expressions, defaults
  to the parent frame.

- arg:

  Argument to check.

- x:

  A ts_caller_arg object.

- n:

  Number of frames to go up to find the caller environment.

- frame:

  Frame number to inspect, defaults to the caller's frame.

- tree:

  A `ts_tree` object as returned by
  [`ts_tree_new()`](https://gaborcsardi.github.io/ts/reference/ts_tree_new.md).

- text:

  Raw vector, the original text used to parse the tree.

## Value

`ts_collapse()` returns a character scalar, the collapsed string.

`ts_cnd()` returns an error condition object.

`ts_caller_arg()` returns the captured expression as a ts_caller_arg
object.

`as_ts_caller_arg()` returns a ts_caller_arg object.

`as.character.ts_caller_arg()` returns a short string representation of
the caller argument, a character scalar.

`ts_caller_env()` returns an environment, or `NULL` is called from the
global environment.

`ts_check_named_arg()` returns `TRUE` invisibly if the argument was
named, otherwise it raises an error.

`ts_parse_error_cnd()` returns a ts_parse_error condition

## Details

`ts_collapse()` collapses a character vector into a single string, with
options for truncation by number of elements or display width. It is
useful for creating informative error messages.

`ts_cnd()` creates a condition object. It interpolates its arguments
into a single message.

`ts_caller_arg()` captures the expression used as an argument to a
function, for use in error messages.

`as_ts_caller_arg()` converts an object into a caller argument object.
This is useful when referring to parts of the caller argument in
downstream error messages.

`as.character.ts_caller_arg()` formats a caller argument object as a
short string for use in error messages. Multi-line expressions are
truncated after the first line.

`ts_caller_env()` returns the environment of the caller function, `n`
levels up the call stack. This is useful for associating error
conditions with the correct call.

`ts_check_named_arg()` checks whether an argument was supplied with a
name. If not, it raises an error.

`ts_parse_error_cnd()` creates a parse error condition associated with a
`ts_tree` object and the original text. The error message includes
information about the location of parse errors in the text. It also has
[`format()`](https://rdrr.io/r/base/format.html) and
[`print()`](https://rdrr.io/r/base/print.html) methods to display the
error together with the relevant lines of the original text.
