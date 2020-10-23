#' Convert a CWA activity file to a CSV
#' @param file input CWA file
#' @param outfile output CSV file
#' @param verbose print diagnostic messages
#' @return Name of output CSV file
#' @export
#' @useDynLib cwaconvert , .registration=TRUE
convert_cwa <- function(file, outfile = tempfile(fileext = ".csv"),
                        verbose = TRUE) {
  file = path.expand(file)
  file = normalizePath(file, winslash = "/", mustWork = TRUE)
  for (ext in c("bz2", "gz", "xz")) {
    if (R.utils::isCompressedFile(file, method = "extension", ext = ext,
                                  fileClass = "")) {
      file = R.utils::decompressFile(file, temporary = TRUE,
                                     overwrite = TRUE,
                                     ext = ext,
                                     REMOVE = FALSE)
    }
  }
  outfile = as.character(outfile)
  stopifnot(nchar(outfile) > 0)
  args = c(file,  outfile)
  .Call("convert_cwa_",  args[1], args[2],
        as.integer(verbose),
        PACKAGE = "cwaconvert")
}

#' @rdname convert_cwa
#' @export
read_cwa_csv = function(file) {
  x = readr::read_csv(
    file,
    col_names = c("timestamp", "x", "y", "z",
                  "light", "temperature", "battery",
                  "battery_voltage",
                  "battery_percentage",
                  "battery_relative",
                  "events"
    ),
    col_types = readr::cols(
      timestamp = readr::col_datetime(format = ""),
      .default = readr::col_double(),
      events = readr::col_character()
    )
  )
}
