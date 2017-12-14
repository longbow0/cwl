#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_annotate_reads.py]
stdout: AnnotateReads.log

inputs:

  R1_Annotation:
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: --annotR1

  R2_Annotation:
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: --annotR2

  Filter_Metrics:
    type: {"items": ["null", "File"], "type": "array"}
    inputBinding:
      itemSeparator: ","
      prefix: --filtering-stats

  Bam_Input:
    type: File[]?
    inputBinding:
      prefix: --bam-input

  Sample_Tags_Version:
    type:
      - "null"
      -  type: enum
         symbols: [human, hs, mouse, mm, custom]
    inputBinding:
      prefix: --sample-tags-version

  Subsample_Tags:
    type: float?
    inputBinding:
      prefix: --subsample-tags

  Index:
    type: File
    inputBinding:
      prefix: --index

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

