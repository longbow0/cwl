#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_annotate_reads.py]
stdout: AnnotateReads.log

inputs:

  R1_Annotation:
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --annotR1
      position: 1

  R2_Annotation:
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --annotR2
      position: 2

  Filter_Metrics:
    type: File[]?
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --filtering-stats
      position: 3

  Bam_Input:
    type: File[]?
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --bam-input
      position: 4

  Index:
    type: File
    inputBinding:
      separate: true
      prefix: --index
      position: 5

outputs:

  Seq_Metrics:
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

