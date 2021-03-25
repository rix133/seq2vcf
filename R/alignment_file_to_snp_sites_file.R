#' alignment_file_to_snp_sites_file
#'
#' @return
#'
#' @useDynLib seq2vcf alignment2snp
alignment_file_to_snp_sites_file <- function(
  in_file="./tests/data/small_alignment.aln",
  vcf=1L,
  aln =0L,
  phylip=0L,
  out_file="test") {

  endings<-c("vcf"=vcf, "aln"=aln, "phylip"=phylip)

  if(sum(endings == 1) == 1){
    ending <- endings[which(endings==max(endings))]
    out_file <- paste0(out_file,".", names(ending))
  }

  result <- .Call("alignment2snp",in_file_name = in_file,
                  vcf = vcf,
                  multi_fasta = aln,
                  phylip = phylip,
                  out_file_name = out_file)
  return(out_file)
}
