/*
 * Rdefines.h is needed for the SEXP typedef, for the error(), INTEGER(),
 * GET_DIM(), LOGICAL(), NEW_INTEGER(), PROTECT() and UNPROTECT() macros,
 * and for the NA_INTEGER constant symbol.
 */
#include <Rdefines.h>

/*
 * R_ext/Rdynload.h is needed for the R_CallMethodDef typedef and the
 * R_registerRoutines() prototype.
 */
#include <R_ext/Rdynload.h>


/*
 * Biostrings_interface.h is needed for the DNAencode(), get_XString_asRoSeq(),
 * init_match_reporting(), report_match() and reported_matches_asSEXP()
 * protoypes, and for the COUNT_MRMODE and START_MRMODE constant symbols.
 */
#include "Biostrings_interface.h"

//  header file
#include "seq2vcf.h"

/*
 * -- REGISTRATION OF THE .Call ENTRY POINTS ---
 */
static const R_CallMethodDef callMethods[] = { // method call, pointer, num args

	{"removeCommonGaps", (DL_FUNC) &removeCommonGaps, 3},
	{"removeGaps", (DL_FUNC) &removeGaps, 3},
	{"removeFirstSeqGaps", (DL_FUNC) &removeFirstSeqGaps, 3},
	{NULL, NULL, 0}
};

void R_init_seq2vcf(DllInfo *info)
{
	R_registerRoutines(info, NULL, callMethods, NULL, NULL);
}
