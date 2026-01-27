#| title: 
# ---
A tree-sitter tree object has at least four classes:
\itemize{
\item \verb{ts_tree_<parser_name>}, e.g. \code{ts_tree_tsjsonc},
\item \code{ts_tree},
\item \code{tbl}, from the pillar package, for better printing when converted
to a data frame, and
\item \code{data.frame}, since it is a data frame internally.
}

The \code{ts_tree} class has custom \code{\link[=format]{format()}} and \code{\link[=print]{print()}} methods, that
show (part of) the underlying document, and also the selected elements,
if any.\if{html}{\out{
<p>
}}


It is sometimes useful to treat a \code{tree} \code{ts_tree} object as a data
frame, and drop the \code{ts_tree} classes. This can be done by indexing with
single brackets, e.g. \code{tree[]}. This returns a data frame with one
row per token, and various columns with information about the tokens.
See details in the 'Value' section or this page.
