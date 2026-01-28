#| title: 
# ---
A list with entries \code{patterns} and \code{matched_captures}.\if{html}{\out{
</p><p><!-- ------------------------------------------------------>
}}


\code{patterns} contains information about all patterns in the queries and
it is a data frame with columns: \code{id}, \code{name}, \code{pattern}, \code{match_count}.\if{html}{\out{
</p><p><!-- ------------------------------------------------------>
}}


\code{matched_captures} contains information about all matches, and it has
columns \code{id}, \code{pattern}, \code{match}, \code{start_byte}, \code{end_byte}, \code{start_row},
\code{start_column}, \code{end_row}, \code{end_column}, \code{name}, \code{code}.\if{html}{\out{
</p><p><!-- ------------------------------------------------------>
}}


The \code{pattern} column of \code{matched_captured} refers to the \code{id} column of
\code{patterns}.
