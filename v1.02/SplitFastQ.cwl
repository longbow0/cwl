#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_split_fastqs.py]
stdout: SplitFastQ.log

inputs:

  Reads:
    type: File[]
    inputBinding:
      prefix: --reads
      itemSeparator: ","

  Subsample:
    type: float?
    inputBinding:
      prefix: --subsample

  Subsample_seed:
    type: float?
    inputBinding:
      prefix: --subsample-seed

outputs:

  Read_Pairs:
    type: File[]
    outputBinding:
      glob: "*.tar.gz"

  output:
    type: stdout

