
library(ontoProc2)

test_that("cells_with_pmp acquires records as expected", {
 x = cells_with_pmp(c("PR:000002064", "PR:000001874"))
 expect_true(inherits(x, "data.frame"))
 expect_true(nrow(x)>50)
})

test_that("get_present_pmp acquires records as expected", {
 x = get_present_pmp(c("CL:0000091", "CL:0000926"))
 expect_true(inherits(x, "data.frame"))
 expect_true(nrow(x)>10)
})
