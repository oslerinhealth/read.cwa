testthat::context("Reading in CWA file from package")
testthat::test_that("Reading in the data", {
  gz_file = system.file("extdata", "ax3_testfile.cwa.gz", package = "cwaconvert")
  file = tempfile(fileext = ".cwa")
  file = R.utils::gunzip(gz_file, destname = file,
                         temporary = TRUE, remove = FALSE)

  out = read_cwa(file)
  testthat::expect_named(
    out,
    c("timestamp", "x", "y", "z", "light", "temperature", "battery",
      "battery_voltage", "battery_percentage", "battery_relative",
      "events")
    )
  testthat::expect_equal(
    colMeans(out[, c("x", "y", "z")]),
    c(x = 0.777613146551724, y = 0.127438936781609, z = 0.291899245689655)
  )
  testthat::expect_silent(read_cwa(file, verbose = FALSE))
  out = read_cwa(file, xyz_only = TRUE)
  testthat::expect_named(
    out,
    c("timestamp", "x", "y", "z")
    )
  testthat::expect_equal(
    colMeans(out[, c("x", "y", "z")]),
    c(x = 0.777613146551724, y = 0.127438936781609, z = 0.291899245689655)
  )
})
