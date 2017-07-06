#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_check_references.py]
inputs:

  Reference: 
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --reference
      position: 1

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 2
  
outputs:
  index:
    type: File
    outputBinding:
      glob: "*.tar.gz"

  Extra_seqs:
    type: File?
    outputBinding:
      glob: "*concatenated_sup.fasta"

  Annotation:
    type: File?
    outputBinding:
      glob: "*-annot*"

  output:
    type: stdout