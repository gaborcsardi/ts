#| title: 
# ---
If no elements are selected in the tree, then the whole document is
unserialized.

\eval{ts:::doc_tabs("ts_tree_unserialize_details_no_selection")}\if{html}{\out{
<p>
}}


If the tree has an empty selection, then an empty list is returned.

\eval{ts:::doc_tabs("ts_tree_unserialize_details_empty_selection")}
\subsection{The \code{[[} operator}{

The \code{[[} operator works similarly to the combination of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} and
\code{ts_tree_unserialize()}, but it might be more readable.

\eval{ts:::doc_tabs("ts_tree_select_brackets")}
}
