testthat::context("Reading in CWA file from package")
testthat::test_that("Reading in the data", {
  gz_file = system.file("extdata", "ax3_testfile.cwa.gz", package = "read.cwa")
  file = tempfile(fileext = ".cwa")
  file = R.utils::gunzip(gz_file, destname = file,
                         temporary = TRUE, remove = FALSE,
                         overwrite = TRUE)

  out = read_cwa(file, xyz_only = FALSE)
  hdr = out$header
  out = out$data
  testthat::expect_named(
    out,
    c("time", "X", "Y", "Z", "light", "temperature", "battery",
      "battery_voltage", "battery_percentage", "battery_relative",
      "events")
    )
  testthat::expect_equal(
    colMeans(out[, c("X", "Y", "Z")]),
    c(X = 0.777613146551724, Y = 0.127438936781609, Z = 0.291899245689655)
  )
  testthat::expect_silent(read_cwa(file, verbose = FALSE))
  out = read_cwa(file, xyz_only = TRUE)
  out = out$data
  testthat::expect_named(
    out,
    c("time", "X", "Y", "Z")
    )
  testthat::expect_equal(
    colMeans(out[, c("X", "Y", "Z")]),
    c(X = 0.777613146551724, Y = 0.127438936781609, Z = 0.291899245689655)
  )
})
