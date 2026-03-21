# Reconnect a SemsqlConn to its database

Attempts to reconnect a disconnected `SemsqlConn` object to its
database. Returns a new `SemsqlConn`; the original cannot be modified in
place due to S7 value semantics.

## Usage

``` r
reconnect(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

## Value

A new `SemsqlConn` object with an active connection.
