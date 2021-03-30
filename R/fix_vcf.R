#' Fix Variant Call File from SNP Align
#'
#' Adds proper chromosome name and start position to the vcf exported by
#' \href{https://github.com/sanger-pathogens/snp-sites}{SNP-sites} software.
#'
#' @param fname file name  for input and output (only if overwrite enabled)
#' @param start start position of the sequence on chromosome
#' @param chrom chromosome value to be used
#' @param conversionCheck should the file be checked for previous conversion
#' @param overwriteInput (boolean) should the input file be overwritten
#' with the fixed values
#'
#' @return an invisible data frame of the fixed vcf file data
#' @export
#'
fix_vcf<-function(fname, chrom, start, conversionCheck = TRUE,
                  overwriteInput = TRUE){

  mycbVEP <- read.table(fname, header = T, sep = "\t", comment.char = "",
                        skip=3, nrows = -1)

  #get the vep header
  headVEP <- read.table(fname, header = F, sep = "*", comment.char = "",
                        nrows = 4)

  if(unique(mycbVEP$X.CHROM) != 1 & mycbVEP$POS[1] > start & conversionCheck){
    warning("Likely this conversion has already been preformed! Exiting!")
    invisble(mycbVEP)
  }

  mycbVEP$X.CHROM <- chrom
  mycbVEP$POS <- mycbVEP$POS + (start - 1)

  if(overwriteInput){
    write.table(headVEP,file=fname, row.names = F, col.names = F,
                sep = "\t", quote = F )
    write.table(mycbVEP,file=fname, row.names = F, col.names = F,
                sep = "\t", quote = F, append = T )
  }


  invisible(mycbVEP)
}
