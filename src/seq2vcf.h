// R_init_seq2vcf.c

void R_init_seq2vcf(DllInfo *info);

// RemoveGaps.c

SEXP removeCommonGaps(SEXP x, SEXP type, SEXP nThreads);

SEXP removeGaps(SEXP x, SEXP type, SEXP nThreads);

SEXP removeFirstSeqGaps(SEXP x, SEXP type, SEXP nThreads);


