#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include "snp-sites.h"
#include <unistd.h>
#include <stdio.h>
#include <errno.h>




SEXP alignment2snp(SEXP in_file_name, SEXP vcf, SEXP multi_fasta, SEXP phylip, SEXP out_file_name) {

  if (!IS_INTEGER(vcf) || !IS_INTEGER(multi_fasta) || !IS_INTEGER(phylip))
    Rf_error("Export alignement file type must be integer(1) for all three!");

  if (!IS_CHARACTER(in_file_name) || LENGTH(in_file_name) != 1)
    Rf_error("'file_name' must be character(1)");

  char output_filename_base[FILENAME_MAX] = "";
  if (IS_CHARACTER(out_file_name) || LENGTH(out_file_name) > 1)
    strcat_s(output_filename_base, FILENAME_MAX,CHARACTER_VALUE(out_file_name));

  /* Define a temporary variable */
  char *fn = (char *)CHARACTER_VALUE(in_file_name);

  FILE *fp;
  fopen_s(&fp ,fn, "r");
  if (fp == NULL){
    char * errTxt = "";
    strerror_s(errTxt, 80, errno);
    Rf_error("opening %s: %s", fn, errTxt);
  }
  fclose(fp);

  /* Add a temporary  name end */
  //strcat_s(output_filename_base,FILENAME_MAX,".tmp");

  generate_snp_sites(fn,
                     INTEGER_VALUE(multi_fasta),
                     INTEGER_VALUE(vcf),
                     INTEGER_VALUE(phylip),
                     output_filename_base);

  SEXP fname = Rf_mkString(output_filename_base);

  return(fname);


}
