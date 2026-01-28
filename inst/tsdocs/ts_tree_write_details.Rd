#| title: 
# ---
If \code{tree} was created from a file, then \code{ts_tree_write()} by default
writes it back to the same file. Otherwise, the \code{file} argument must be
specified.

\eval{ts:::doc_tabs("ts_tree_write_details_file")}

To write to a connection, pass a connection object to the \code{file}
argument. If the connection is opened in binary mode, the raw bytes
are written using \code{\link[base:readBin]{base::writeBin()}}. Otherwise, the raw bytes are
converted to characters using the system encoding before writing using
\code{\link[base:rawConversion]{base::rawToChar()}}.\if{html}{\out{
</p><p><!-- ------------------------------------------------------>
}}


Use \code{file = stdout()} to write to the standard output, i.e. to the
console in an interactive R session.
