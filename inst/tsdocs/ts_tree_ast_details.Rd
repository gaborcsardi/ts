#| title: 
# ---
\subsection{The syntax tree and the DOM tree}{

This syntax tree contains all nodes of the tree-sitter parse tree,
including both named and unnamed nodes and comments. E.g. for a JSON(C)
document it includes the pairs, brackets, braces, commas, colons,
double quotes and string escape sequences as separate nodes.\if{html}{\out{
<p>
}}


See \code{\link[ts:ts_tree_dom]{ts::ts_tree_dom()}} for a tree that
shows the semantic structure of the parsed document, which may be
different from the syntax tree.

\eval{ts:::doc_tabs("ts_tree_ast_details_syntax_vs_dom")}
}
