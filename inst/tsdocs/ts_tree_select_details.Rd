#| title: 
# ---
The selection process is iterative. Selection expressions (selectors)
are applied one by one, and each selector selects nodes from the
currently selected nodes. For each selector, it is applied individually
to each currently selected node, and the results are concatenated.\if{html}{\out{
<p>
}}


The selection process starts from the root of the DOM tree, the document
node (see \code{\link[ts:ts_tree_dom]{ts_tree_dom()}}), unless
\code{refine = TRUE} is set, in which case it starts from the current
selection.\if{html}{\out{
<p>
}}


See the various types of selection expressions below.
\subsection{Selectors}{
\subsection{All elements: \code{TRUE}}{

Selects all child nodes of the current nodes.

\eval{ts:::doc_tabs("ts_tree_select_true")}
}

\subsection{Specific keys: character vector}{

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.

\eval{ts:::doc_tabs("ts_tree_select_character")}
}

\subsection{By position: integer vector}{

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.

\eval{ts:::doc_tabs("ts_tree_select_integer")}
}

\subsection{Matching keys: regular expression}{

A character scalar named \code{regex} can be used to select child nodes
whose names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.

\eval{ts:::doc_tabs("ts_tree_select_regex")}
}

\subsection{Tree sitter query matches}{

A character scalar named \code{query} can be used to select nodes matching
a tree-sitter query. See \code{\link[ts:ts_tree_query]{ts_tree_query()}}
for details on tree-sitter queries.\if{html}{\out{
<p>
}}


Instead of a character scalar this can also be a two-element list, where
the first element is the query string and the second element is a
character vector of capture names to select. In this case only nodes
matching the given capture names will be selected.

\eval{ts:::doc_tabs("ts_tree_select_tsquery")}
}

\subsection{Explicit node ids}{

You can use \code{I(c(...))} to select nodes by their ids directly. This is
for advanced use cases only.

\eval{ts:::doc_tabs("ts_tree_select_ids")}
}

}

\subsection{Refining selections}{

If the \code{refine} argument of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} is \code{TRUE}, then
the selection starts from the already selected elements (all of them
simultanously), instead of starting from the document element.

\eval{ts:::doc_tabs("ts_tree_select_refine")}
}

\subsection{The \verb{ts_tree_select<-()} replacement function}{

The \code{\link[ts:ts_tree_select<-]{ts_tree_select<-()}} replacement
function works similarly to the combination of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} and
\code{\link[ts:ts_tree_update]{ts_tree_update()}}, but it might be more
readable.

\eval{ts:::doc_tabs("ts_tree_select_set")}
}

\subsection{The \code{[[} and \verb{[[<-} operators}{

The \code{[[} operator works similarly to the combination of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} and
\code{\link[ts:ts_tree_unserialize]{ts_tree_unserialize()}}, but it
might be more readable.

\eval{ts:::doc_tabs("ts_tree_select_brackets")}\if{html}{\out{
<p>
}}


The \verb{[[<-} operator works similarly to the combination of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} and
\code{\link[ts:ts_tree_update]{ts_tree_update()}}, (and also to the
replacement function \code{\link[ts:ts_tree_select<-]{ts_tree_select<-()}}),
but it might be more readable.

\eval{ts:::doc_tabs("ts_tree_select_brackets_set")}
}
