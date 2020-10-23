#' Convert a CWA activity file to a CSV
#' @param file input CWA file
#' @param outfile output CSV file
#' @param verbose print diagnostic messages
#' @param xyz_only read only time and X/Y/Z columns
#' @return Name of output CSV file
#' @export
#' @useDynLib read.cwa , .registration=TRUE
#' @examples
#' gz_file = system.file("extdata", "ax3_testfile.cwa.gz", package = "read.cwa")
#' file = R.utils::gunzip(gz_file, temporary = TRUE, remove = FALSE, overwrite = TRUE)
#' out = read_cwa(file)
#' out = read_cwa(file, xyz_only = FALSE)
convert_cwa <- function(file, outfile = tempfile(fileext = ".csv"),
                        xyz_only = TRUE,
                        verbose = TRUE) {
  file = path.expand(file)
  file = normalizePath(file, winslash = "/", mustWork = TRUE)
  for (ext in c("bz2", "gz", "xz")) {
    if (R.utils::isCompressedFile(file, method = "extension", ext = ext,
                                  fileClass = "")) {
      FUN = switch(ext,
                   gz = gzfile,
                   xz = xzfile,
                   bz2 = bzfile
      )
      file = R.utils::decompressFile(
        file, temporary = TRUE,
        overwrite = TRUE,
        ext = ext,
        FUN = FUN,
        remove = FALSE)
    }
  }
  outfile = as.character(outfile)
  stopifnot(nchar(outfile) > 0)
  args = c(file,  outfile)
  .Call("convert_cwa_",  args[1], args[2],
        as.integer(xyz_only),
        as.integer(verbose),
        PACKAGE = "read.cwa")
}

#' @rdname convert_cwa
#' @export
read_cwa_csv = function(file, xyz_only = TRUE, verbose = TRUE) {
  default = readr::col_double()
  event_col = readr::col_character()
  if (xyz_only) {
    default = readr::col_skip()
    event_col = readr::col_skip()
  }
  col_spec = readr::cols(
    timestamp = readr::col_datetime(format = ""),
    .default = default,
    x = readr::col_double(),
    y = readr::col_double(),
    z = readr::col_double(),
    events = event_col
  )
  cnames = c("timestamp", "x", "y", "z",
             "light", "temperature", "battery",
             "battery_voltage",
             "battery_percentage",
             "battery_relative",
             "events")
  if (xyz_only) {
    col_spec$cols$events = NULL
    cnames = c("timestamp", "x", "y", "z")
  }
  x = readr::read_csv(
    file,
    col_names = cnames,
    col_types = col_spec,
    progress = verbose
  )
}

#' @rdname convert_cwa
#' @export
read_cwa <- function(file, outfile = tempfile(fileext = ".csv"),
                     xyz_only = TRUE,
                     verbose = TRUE) {
  if (verbose) {
    message("Converting the CWA to CSV")
  }
  csv_file = convert_cwa(file, outfile = outfile, xyz_only = xyz_only,
                         verbose = verbose)
  if (verbose) {
    message(paste0("Reading in the CSV: ", csv_file))
  }
  read_cwa_csv(csv_file, xyz_only = xyz_only, verbose = verbose)
}
