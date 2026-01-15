#!/usr/bin/env nextflow

params.inputFile = null
params.cutoff = null


process gcFilter {

  input:
  path fasta
  val cutoff
  path rscript

  output:
  path "output.txt"

  script:
  """
  Rscript "$rscript" "$fasta" "$cutoff"
  """
}

workflow {
  ch_fasta = Channel.fromPath(params.inputFile)
  ch_r     = Channel.fromPath('GCcontent.R')
  gcFilter(ch_fasta, params.cutoff, ch_r)
}
