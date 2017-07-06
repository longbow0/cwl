#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_annotate_reads.py]
stdout: annotatereads.txt
inputs:

  R1_annotation: 
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --annotR1
      position: 1

  R2_annotation:
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --annotR2
      position: 2

  FilterMetrics:
    type: File[]?
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --filtering-stats
      position: 3

  Alignment_length:
    type: int?
    inputBinding:
      separate: true
      prefix: --alignment-length
      position: 4

  Bam_input:
    type: File[]?
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --bam-input
      position: 5

  Num_cell_image:
    type: int?
    inputBinding:
      separate: true
      prefix: --num-cell-image
      position: 6

  Index:
    type: File
    inputBinding:
      separate: true
      prefix: --index
      position: 7

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 8

  Extra_seqs:
    type: File?
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --extra-seqs
      position: 9

  Internal_run:
    type: boolean?
    inputBinding:
      prefix: --internal-run
      position: 10

outputs:

  SeqMetrics:
    type: File
    outputBinding:
      glob: "*_SeqMetrics.csv"

  Valid_Reads:
    type: File[]
    outputBinding:
      glob: "*Sorted_Valid_Reads.csv.*"

  Annotation_Read:
    type: File
    outputBinding:
      glob: "*_Annotation_Read.csv"

  output:
    type: stdout
