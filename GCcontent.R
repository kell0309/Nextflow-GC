args <- commandArgs(trailingOnly = TRUE)

file <- args[1]
cutoff <- as.numeric(args[2])

lines <- readLines(file)

out <- c()
header <- ""
seq <- ""

for (line in lines) {
  if (substr(line, 1, 1) == ">") {
    header <- line
    seq <- ""
  } else {
    seq <- paste0(seq, line)
    gc <- (sum(strsplit(seq, "")[[1]] %in% c("G","C"))) / nchar(seq)
    if (gc > cutoff) {
      out <- c(out, header, seq)
    }
  }
}

writeLines(out, "output.txt")
