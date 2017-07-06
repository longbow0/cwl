#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_quality_filter.py]
stdout: output.txt

inputs:

  Read_pairs:
    type: File
    inputBinding:
      prefix: --read-pairs
      itemSeparator: ","
      separate: true
      position: 1

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 2

  Read_filter_off:
    type: boolean?
    inputBinding:
      prefix: --read-filter-off
      position: 3

outputs:

  R1:
    type: File
    outputBinding:
      glob: "*_R1*.fastq.gz"

  R2:
    type: File
    outputBinding:
      glob: "*_R2*.fastq.gz"

  FilterMetrics:
    type: File?
    outputBinding:
      glob: "*read_quality.csv"

  output:
    type: stdout
