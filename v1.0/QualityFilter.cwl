#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_quality_filter.py]
stdout: $(inputs.Read_Pairs.nameroot.split('.')[0]).QualityFilter.log

inputs:

  Read_Pairs:
    type: File
    inputBinding:
      prefix: --read-pairs
      itemSeparator: ","
      separate: true
      position: 1

outputs:

  R1:
    type: File
    outputBinding:
      glob: "*_R1*.fastq.gz"

  R2:
    type: File
    outputBinding:
      glob: "*_R2*.fastq.gz"

  Filter_Metrics:
    type: File?
    outputBinding:
      glob: "*read_quality.csv"

  output:
    type: stdout

