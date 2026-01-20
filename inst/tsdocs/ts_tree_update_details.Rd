#| title: 
# ---
If the tree does not have a selection, the new element replaces the
whole document.

\eval{ts:::doc_tabs("ts_tree_update_details_no_selection")}\if{html}{\out{
<p>
}}


If the tree has an empty selection, the new element is inserted at the
position of where the selected elements would be.

\eval{ts:::doc_tabs("ts_tree_update_details_empty_selection")}
