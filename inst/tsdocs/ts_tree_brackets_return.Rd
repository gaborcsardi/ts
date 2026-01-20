#| title: 
# ---
A data frame with one row per token, and columns:
\itemize{
\item \code{id}: integer, the id of the token. The (root) document node has id 1.
\item \code{parent}: integer, the id of the parent token. The root token has
parent \code{NA}
\item \code{field_name}: character, the field name of the token in its parent.
\item \code{type}: character, the type of the token.
\item \code{code}: character, the actual code of the token.
\item \code{start_byte}, \code{end_byte}: integer, the byte positions of the token
in the input.
\item \code{start_row}, \code{start_column}, \code{end_row}, \code{end_column}: integer, the
position of the token in the input.
\item \code{is_missing}: logical, whether the token is a missing token added by
the parser to recover from errors.
\item \code{has_error}: logical, whether the token has a parse error.
\item \code{children}: list of integer vectors, the ids of the children tokens.
\item \code{dom_type}: character, the type of the node in the DOM tree. See
\code{\link[ts:ts_tree_dom]{ts_tree_dom()}}. Nodes that are not part
of the DOM tree have \code{NA_character_} here.
\item \code{dom_children}: list of integer vectors, the ids of the children in the
DOM tree. See \code{\link[ts:ts_tree_dom]{ts_tree_dom()}}.
\item \code{dom_parent}: integer, the parent of the node in the DOM tree. See
\code{\link[ts:ts_tree_dom]{ts_tree_dom()}}. Nodes that are not part
of the DOM tree and the document node have have \code{NA_integer_} here.
}

Other, undocumented columns may also be present, these are considered
internal and may change without notice.
