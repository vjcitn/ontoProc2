utils::globalVariables(c("predicate", "subject", "value", "object", 
    "prtag", "tag2cn", "prlab", "select", "%like%", "tbl"))

.onLoad <- function(libname, pkgname) {
   S7::methods_register()
}
