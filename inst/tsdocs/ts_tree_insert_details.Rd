#| title: 
# ---
It is not always possible to insert a new element into a selected
element. For example in a JSONC document you can only insert a new
element into an array or an object, but not into scalar elements.
If the insertion is not possible, an error is raised.

\eval{ts:::doc_tabs("ts_tree_insert_details_errors")}\if{html}{\out{
<p>
}}


If \code{tree} does not have a selection, the new element is inserted into
at the top level.

\eval{ts:::doc_tabs("ts_tree_insert_details_no_selection")}\if{html}{\out{
<p>
}}


If \code{tree} has an empty selection, then it is returned unchanged, i.e.
no new element is inserted.

\eval{ts:::doc_tabs("ts_tree_insert_details_empty_selection")}
