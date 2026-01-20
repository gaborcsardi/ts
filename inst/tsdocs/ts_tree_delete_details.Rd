#| title: 
# ---
The formatting of the rest of the document is left as is.

\eval{ts:::doc_tabs("ts_tree_delete_details_formatting")}\if{html}{\out{
<p>
}}


If the tree does not have a selection, the tree corresponding to the
empty document is returned, i.e. the whole content is deleted.

\eval{ts:::doc_tabs("ts_tree_delete_details_no_selection")}\if{html}{\out{
<p>
}}


If the tree has a selection, but it is the empty selection, then
the tree is returned unchanged.

\eval{ts:::doc_tabs("ts_tree_delete_details_empty_selection")}\if{html}{\out{
<p>
}}


For parsers that support comments, deleting elements that include
comments typically delete the comments as well. Other comments are
kept as is. See details in the manual of the specific parser.

\eval{ts:::doc_tabs("ts_tree_delete_details_comments")}
