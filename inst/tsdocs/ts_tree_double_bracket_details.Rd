#| title: 
# ---
The following two expressions are equivalent:

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{ts_tree_select(tree, <selectors>) |> ts_tree_unserialize()
}\if{html}{\out{</div>}}

and

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree[[list(<selectors>)]]
}\if{html}{\out{</div>}}\if{html}{\out{
<p>
}}


\eval{ts:::doc_tabs("ts_tree_select_brackets")}
\subsection{The \verb{[[<-} replacement operator}{

The \verb{[[<-} operator works similarly to the combination of
\code{\link[ts:ts_tree_select]{ts_tree_select()}} and
\code{\link[ts:ts_tree_update]{ts_tree_update()}}, (and also to the
replacement function \code{\link[ts:ts_tree_select<-]{ts_tree_select<-()}}),
but it might be more readable.

\eval{ts:::doc_tabs("ts_tree_select_brackets_set")}
}
