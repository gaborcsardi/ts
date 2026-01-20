#| title: 
# ---
If \code{tree} does not have a selection, then the whole document is
formatted.

\eval{ts:::doc_tabs("ts_tree_format_details_no_selection")}\if{html}{\out{
<p>
}}


If \code{tree} has an empty selection, then it is returned unchanged.

\eval{ts:::doc_tabs("ts_tree_format_details_empty_selection")}\if{html}{\out{
<p>
}}


Some parsers support options to customize the formatting.
See details in the manual of the specific parser.

\eval{ts:::doc_tabs("ts_tree_format_details_options")}
