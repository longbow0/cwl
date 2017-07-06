#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_add_to_sam.py]
stdout: addtosam.log

inputs:

  ReadsPerCell:
    type: File
    inputBinding:
      separate: true
      prefix: --reads
      position: 1

  ReadAnnot:
    type: File
    inputBinding:
      separate: true
      prefix: --read-annot
      position: 2

  MolAnnot:
    type: File
    inputBinding:
      separate: true
      prefix: --mol-annot
      position: 4

  Bam_file:
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --bam
      position: 3

outputs:

  FinalBam:
    type: File
    outputBinding:
      glob: "*sorted.final.BAM"

  output:
    type: stdout

