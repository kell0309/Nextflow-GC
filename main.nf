#!/usr/bin/env nextflow

params.inputFile = null
params.cutoff    = 0.5

process gcFilter {

  input:
  path fasta
  val  cutoff

  output:
  path "output.txt"

  script:
  """
  Rscript GCcontent.R "$fasta" "$cutoff"
  """
}

workflow {
  Channel
    .fromPath(params.inputFile)
    .set { ch_fasta }

  Channel
    .value(params.cutoff)
    .set { ch_cutoff }

  gcFilter(ch_fasta, ch_cutoff)
}