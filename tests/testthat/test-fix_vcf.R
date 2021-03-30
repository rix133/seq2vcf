#this is the expected output from aln2vcf
fname <- "../data/small_alignment.aln.vcf"

test_that("reseting start position works", {

  #this case I presume that the changed base is the 16-th
  #in the original sequence and the seqeunce starts at 11th base

  res <- fix_vcf(fname, 1, 11, TRUE, FALSE)
  nr <- res[1,2]
  expect_equal(nr,16)
})

test_that("setting chromosome to string works", {

  #this case I presume that the changed base is the 16-th
  #in the original sequence and the seqeunce starts at 11th base

  res <- fix_vcf(fname, "test1", 1, TRUE, FALSE)
  expect_equal(res[1,1],"test1")
})
