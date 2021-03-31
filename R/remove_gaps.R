#' Remove Gap Characters in Sequences
#' @description  Removes gaps ("-" or "." characters) in a set of sequences,
#'  either deleting all positions where the first sequence has a gap,
#'  all gaps that occur in any of the sequences  or only those gaps shared by
#'   all sequences in the set.
#'  This function is adopted from \link[DECIPHER]{RemoveGaps} by Erik Wright.
#'  It adds the gaps by first sequences to the \link[DECIPHER]{RemoveGaps}
#'
#' @param myXStringSet An \code{AAStringSet}, \code{DNAStringSet}, or
#' \code{RNAStringSet} object containing sequences.
#' @param removeGaps Determines how gaps ("-" or "." characters) are removed
#' in the sequences.  This should be (an unambiguous abbreviation of) one of
#' \code{"none"}, \code{"all"} \code{"first"} or \code{"common"}.
#' @param processors The number of processors to use, or \code{NULL} to
#' automatically detect and use all available processors.
#'
#' @details The {removeGaps} argument controls which gaps are removed in
#' {myXStringSet}.  Setting {removeGaps} to {"first"} will remove
#' all gaps in the first input sequence together with the same position in the
#' in every sequence.  For other usages see \link[DECIPHER]{RemoveGaps}.
#'
#' @return An {XStringSet} of the same type as {myXStringSet}.
#' @export
#'
#' @seealso \link[DECIPHER]{AlignSeqs}, \link[DECIPHER]{RemoveGaps}.
#'
#' @examples
#' dna <- DNAStringSet(c("ACT-G-", "AC--G-"))
#' RemoveGaps(dna, "first")
RemoveGaps <- function(myXStringSet,
	removeGaps="first",
	processors=1) {

	# error checking
	if (is(myXStringSet, "DNAStringSet")) {
		type <- 1L
	} else if (is(myXStringSet, "RNAStringSet")) {
		type <- 2L
	} else if (is(myXStringSet, "AAStringSet")) {
		type <- 3L
	} else {
		stop("myXStringSet must be an AAStringSet, DNAStringSet, or RNAStringSet.")
	}
	GAPS <- c("none", "all", "common", "first")
	removeGaps <- pmatch(removeGaps[1], GAPS)
	if (is.na(removeGaps))
		stop("Invalid removeGaps method.")
	if (removeGaps == -1)
		stop("Ambiguous removeGaps method.")
	if (!is.null(processors) && !is.numeric(processors))
		stop("processors must be a numeric.")
	if (!is.null(processors) && floor(processors)!=processors)
		stop("processors must be a whole number.")
	if (!is.null(processors) && processors < 1)
		stop("processors must be at least 1.")
	if (is.null(processors)) {
		processors <- detectCores()
	} else {
		processors <- as.integer(processors)
	}
	if (removeGaps==2L) { # all gaps
		ns <- names(myXStringSet)
		myXStringSet <- .Call("removeGaps",
			myXStringSet,
			type,
			processors,
			PACKAGE="seq2vcf")
		names(myXStringSet) <- ns
	} else if (removeGaps==3L) { # common gaps
		ns <- names(myXStringSet)
		myXStringSet <- .Call("removeCommonGaps",
			myXStringSet,
			type,
			processors,
			PACKAGE="seq2vcf")
		names(myXStringSet) <- ns
	} else if (removeGaps==4L) { # first sequence gaps
	  ns <- names(myXStringSet)
	  myXStringSet <- .Call("removeFirstSeqGaps",
	                        myXStringSet,
	                        type,
	                        processors,
	                        PACKAGE="seq2vcf")
	  names(myXStringSet) <- ns
	}

	return(myXStringSet)
}
