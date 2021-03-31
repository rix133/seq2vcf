test_that("removes gaps from first sequence only", {
  dna <- DNAStringSet(c("ACT-G-", "AC--G-"))
  res <- RemoveGaps(dna, "first")
  #expect_equal(length(res[[1]]), 4)
  #expect_equal(length(res[[2]]), 4)
  expect_equal(as.character(res[[1]]), "ACTG")
  expect_equal(as.character(res[[2]]), "AC-G")

  dna <- DNAStringSet(c("AC-T-G-", "AC---G-"))
  res <- RemoveGaps(dna, "first")
  #expect_equal(length(res[[1]]), 4)
  #expect_equal(length(res[[2]]), 4)
  expect_equal(as.character(res[[1]]), "ACTG")
  expect_equal(as.character(res[[2]]), "AC-G")

})

test_that("removes all gaps from first sequence only", {
  dna <- DNAStringSet(c("AC---TG", "ACGGGTC"))
  res <- RemoveGaps(dna, "first")
  #expect_equal(length(res[[1]]), 4)
  #expect_equal(length(res[[2]]), 4)
  expect_equal(as.character(res[[1]]), "ACTG")
  expect_equal(as.character(res[[2]]), "ACTC")

})
