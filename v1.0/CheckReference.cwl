#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_check_references.py]
stdout: CheckReference.log

inputs:

  Reference: 
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --reference
      position: 1
  
outputs:
  Index:
    type: File
    outputBinding:
      glob: "*.tar.gz"

  Annotation:
    type: File?
    outputBinding:
      glob: "*-annot*"

  output:
    type: stdout