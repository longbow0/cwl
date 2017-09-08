#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_split_fastqs.py]
stdout: SplitFastQ.log

inputs:

  Reads:
    type: File[]
    inputBinding:
      prefix: --reads
      itemSeparator: ","
      separate: true
      position: 1

  Subsample:
    type: float?
    inputBinding:
      separate: true
      prefix: --subsample
      position: 3

  Subsample_seed:
    type: float?
    inputBinding:
      separate: true
      prefix: --subsample-seed
      position: 4

outputs:

  Read_Pairs:
    type: File[]
    outputBinding:
      glob: "*.tar.gz"

  output:
    type: stdout

