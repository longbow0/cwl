#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_split_fastqs.py]
stdout: output.txt

inputs:

  Reads:
    type: File[]
    inputBinding:
      prefix: --reads
      itemSeparator: ","
      separate: true
      position: 1

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 2

outputs:

  Read_pairs:
    type: File[]
    outputBinding:
      glob: "*.tar.gz"

  output:
    type: stdout
