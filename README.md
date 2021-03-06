
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Convert Aligned Reads to Variant Call Format (VCF)

<!-- badges: start -->
<!-- badges: end -->

The goal of seq2vcf is to convert aligned RNA DNA or protein sequences
to a Variant Call Format (.vcf) file for variant calling using Ensembl
VEP (Variant Effect Predictor).

Behind the scenes the package uses
[SNP-sites](https://github.com/sanger-pathogens/snp-sites) with a few
tweaks. Notably, to make it compile under Windows the *regex.h* is
replaced with *pcre.h*.

This package is work in progress and may change in any time.

## Installation

You likely need to install *zlibbioc* beforehand:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("zlibbioc")
```

Then you can install **seq2vcf** using:

``` r
#NB! Requires RTools (see below)
install.packages("remotes")
remotes::install_github("rix133/seq2vcf")
```

However, to build under windows you need to have RTools40 installed.
Also you may need to install the *curl* and *pcre* library for Rtools.

To install these libraries you need to:

-   Open **Rtools Bash**
    [Instructions](https://github.com/r-windows/docs/blob/master/rtools40.md#readme)
-   For curl: `pacman -S mingw-w64-{i686,x86_64}-curl`
-   For pcre: `pacman -S mingw-w64-{i686,x86_64}-pcre` (should be
    installed by default)

If released you can install the released version of seq2vcf from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("seq2vcf")
```

## Example

This is a basic example which shows you how to convert a simple
**.fasta** file:

``` r
library(seq2vcf)
aln2vcf("./tests/data/small_alignment.aln")
#> Created: ./tests/data/small_alignment.aln.vcf
```
