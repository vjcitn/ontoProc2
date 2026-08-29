<div id="main" class="col-md-9" role="main">

# Execute code with an automatically managed SemsqlConn

<div class="ref-description section level2">

Opens a connection, evaluates an expression with `conn` bound to the
open `SemsqlConn`, then closes the connection even if an error occurs.
Analogous to Python's context manager (`with` statement).

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
with_connection(db_path, expr)
```

</div>

</div>

<div class="section level2">

## Arguments

-   db\_path:

    character(1) path to the SQLite database.

-   expr:

    an expression to evaluate; `conn` is bound to the open `SemsqlConn`
    within this expression.

</div>

<div class="section level2">

## Value

the value of `expr`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
if (FALSE) { # \dontrun{
result <- with_connection("cl.db", {
  get_ancestors(conn, "CL:0000540")
})
} # }
```

</div>

</div>

</div>
