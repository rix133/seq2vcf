#' Convert .fasta File to .vcf File
#'
#' Converts a file that has multiple sequences of the same length
#' into a basic variant call format file using
#' \href{https://github.com/sanger-pathogens/snp-sites}{SNP-sites} software.
#' Be aware that the sequences must be of same length i.e. aligned beforehand.
#'
#' @param fname - path to the converted file
#' @param chromosome - the chromosome where the fasta sequence lies
#' @param start_at - the first nucleotide position on the chromosome
#'
#' @return if assigned returns the data.frame of the resulting vcf file.
#' @export
#'
aln2vcf<-function(fname, chromosome=1, start_at=0){
  res_file <- alignment_file_to_snp_sites_file(in_file = fname,
                                   vcf = 1L,
                                   out_file = fname)
  vcfTbl <- fix_vcf(res_file, chromosome, start_at, FALSE)
  cat(paste("Created:", res_file))
  invisible(vcfTbl)
}
