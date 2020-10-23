
<!-- README.md is generated from README.Rmd. Please edit that file -->

read.cwa
========

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/muschellij2/read-cwa?branch=master&svg=true)](https://ci.appveyor.com/project/muschellij2/read-cwa)
[![R build
status](https://github.com/muschellij2/read.cwa/workflows/R-CMD-check/badge.svg)](https://github.com/muschellij2/read.cwa/actions)
<!-- badges: end -->

The goal of `read.cwa` is to provide functionality to convert ‘Axtivity’
‘CWA’ files.

Installation
------------

You can install the released version of read.cwa from
[CRAN](https://CRAN.R-project.org) with:

    install.packages("read.cwa")

And the development version from [GitHub](https://github.com/) with:

    # install.packages("devtools")
    devtools::install_github("muschellij2/read.cwa")

Example
-------

This is a basic example which shows you how to read in a CWA:

    library(read.cwa)
    file = system.file("extdata", "ax3_testfile.cwa.gz", package = "read.cwa")
    out = read_cwa(file)
    #> Converting the CWA to CSV
    #> Reading 147 sectors (offset 0, file 147)...
    #> [MD].
    #> Wrote 876815 bytes of data (17400 samples).
    #> Reading in the CSV
    head(out)
    #> # A tibble: 6 x 11
    #>   timestamp               x      y      z light temperature battery
    #>   <dttm>              <dbl>  <dbl>  <dbl> <dbl>       <dbl>   <dbl>
    #> 1 2019-02-26 10:55:06 0.328  0.984  0.203   283         258     190
    #> 2 2019-02-26 10:55:06 0.828 -0.359 -0.375   283         258     190
    #> 3 2019-02-26 10:55:06 0.875 -0.391 -0.391   283         258     190
    #> 4 2019-02-26 10:55:06 0.891 -0.391 -0.391   283         258     190
    #> 5 2019-02-26 10:55:06 0.891 -0.375 -0.391   283         258     190
    #> 6 2019-02-26 10:55:06 0.875 -0.359 -0.375   283         258     190
    #> # … with 4 more variables: battery_voltage <dbl>, battery_percentage <dbl>,
    #> #   battery_relative <dbl>, events <chr>

    out = read_cwa(file, xyz_only = TRUE)
    #> Converting the CWA to CSV
    #> Reading 147 sectors (offset 0, file 147)...
    #> [MD].
    #> Wrote 876815 bytes of data (17400 samples).
    #> Reading in the CSV
    head(out)
    #> # A tibble: 6 x 4
    #>   timestamp               x      y      z
    #>   <dttm>              <dbl>  <dbl>  <dbl>
    #> 1 2019-02-26 10:55:06 0.328  0.984  0.203
    #> 2 2019-02-26 10:55:06 0.828 -0.359 -0.375
    #> 3 2019-02-26 10:55:06 0.875 -0.391 -0.391
    #> 4 2019-02-26 10:55:06 0.891 -0.391 -0.391
    #> 5 2019-02-26 10:55:06 0.891 -0.375 -0.391
    #> 6 2019-02-26 10:55:06 0.875 -0.359 -0.375
    ## basic example code
