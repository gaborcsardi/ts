#| title: 
# ---
A selection starts from the root of the DOM tree, the document node
(see \code{\link[=ts_tree_dom]{ts_tree_dom()}}), unless \code{refine = TRUE} is set, in which case it
starts from the current selection.\if{html}{\out{
<p/>
}}


A list of selection expressions is applied in order. Each selection
expression selects nodes from the currently selected nodes.\if{html}{\out{
<p/>
}}


See the various types of selection expressions below.\if{html}{\out{
<p/>
}}

\subsection{Selectors}{
\subsection{All elements: \code{TRUE}}{

Selects all child nodes of the current nodes.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_true")}
}

\subsection{Specific keys: character vector}{

Selects child nodes with the given names from nodes with named children.
If a node has no named children, it selects nothing from that node.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_character")}
}

\subsection{By position: integer vector}{

Selects child nodes by position. Positive indices count from the start,
negative indices count from the end. Zero indices are not allowed.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_integer")}
}

\subsection{Matching keys: regular expression}{

A character scalar named \code{regex} can be used to select child nodes
whose names match the given regular expression, from nodes with named
children. If a node has no named children, it selects nothing from that
node.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_regex")}
}

\subsection{Tree sitter query matches}{

A character scalar named \code{query} can be used to select nodes matching
a tree-sitter query. See \code{\link[=ts_tree_query]{ts_tree_query()}} for details on tree-sitter
queries.\if{html}{\out{
<p/>
}}


Instead of a character scalar this can also be a two-element list, where
the first element is the query string and the second element is a
character vector of capture names to select. In this case only nodes
matching the given capture names will be selected.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_tsquery")}
}

\subsection{Explicit node ids}{

You can use \code{I(c(...))} to select nodes by their ids directly. This is
for advanced use cases only.\if{html}{\out{
<p/>
}}


\eval{ts:::doc_tabs("ts_tree_select_ids")}
}

}

\subsection{Refining selections}{

If the \code{refine} argument of \code{\link[=ts_tree_select]{ts_tree_select()}} is \code{TRUE}, then
the selection starts from the already selected elements (all of them
simultanously), instead of starting from the document element.
}

\subsection{The \code{[[} and \verb{[[<-} operators}{

The \code{[[} operator works similarly to \code{\link[=ts_tree_select]{ts_tree_select()}} on ts_tree
objects, but it might be more readable.\if{html}{\out{
<p/>
}}


The \verb{[[<-} operator works similarly to \code{\link[=ts_tree_select<-]{ts_tree_select<-()}}, but it
might be more readable.\if{html}{\out{
<p/>
}}

}
