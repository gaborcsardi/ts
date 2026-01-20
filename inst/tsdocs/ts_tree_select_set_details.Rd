#| title: 
# ---
The following two expressions are equivalent:

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{tree <- ts_tree_select(tree, <selectors>) |> ts_tree_update(value)
}\if{html}{\out{</div>}}

and

\if{html}{\out{<div class="sourceCode r"><p style="display:none">&nbsp;}}\preformatted{ts_tree_select(tree, <selectors>) <- value
}\if{html}{\out{</div>}}

\eval{ts:::doc_tabs("ts_tree_select_set")}
