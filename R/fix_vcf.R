#' Fix Variant Call File from SNP Align
#'
#' Adds proper chromosome name and start position to the vcf exported by
#' \href{https://github.com/sanger-pathogens/snp-sites}{SNP-sites} software.
#'
#' @param fname input and output filename
#' @param start start position of the sequence on chromosome
#' @param chrom chromosome value to be used
#' @param conversionCheck should the file be checked for previous conversion
#'
#' @return an invisible data frame of the vcf
#' @export
#'
#' @examples
fix_vcf<-function(fname, chrom, start, conversionCheck = TRUE){

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
  mycbVEP$POS <- mycbVEP$POS + start


  write.table(headVEP,file=fname, row.names = F, col.names = F,
              sep = "\t", quote = F )
  write.table(mycbVEP,file=fname, row.names = F, col.names = F,
              sep = "\t", quote = F, append = T )

  invisible(mycbVEP)
}
