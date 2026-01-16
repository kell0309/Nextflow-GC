#!/usr/bin/env nextflow

params.inputFile = null
params.cutoff    = 0.5

process gcFilter {
  publishDir params.outdir, mode: 'copy'
  
  input:
  path fasta
  path rscript
  val  cutoff
  
  output:
  path "output.txt"
  
  script:
  """
  Rscript ${rscript} ${fasta} ${cutoff}
  """
}

workflow {
  
  ch_fasta = Channel.fromPath(params.inputFile)
  
  ch_rscript = Channel.fromPath("${projectDir}/GCcontent.R")
  
  ch_cutoff = Channel.value(params.cutoff)

  gcFilter(ch_fasta, ch_rscript, ch_cutoff)
}