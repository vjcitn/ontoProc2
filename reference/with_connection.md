# Execute code with an automatically managed SemsqlConn

Opens a connection, evaluates an expression with `conn` bound to the
open `SemsqlConn`, then closes the connection even if an error occurs.
Analogous to Python's context manager (`with` statement).

## Usage

``` r
with_connection(db_path, expr)
```

## Arguments

- db_path:

  character(1) path to the SQLite database.

- expr:

  an expression to evaluate; `conn` is bound to the open `SemsqlConn`
  within this expression.

## Value

the value of `expr`.

## Examples

``` r
if (FALSE) { # \dontrun{
result <- with_connection("cl.db", {
  get_ancestors(conn, "CL:0000540")
})
} # }
```
