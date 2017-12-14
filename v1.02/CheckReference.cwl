#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_check_references.py]
stdout: CheckReference.log

inputs:

  Reference: 
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: --reference

  Sample_Tags_Version:
    type:
      - "null"
      -  type: enum
         symbols: [human, hs, mouse, mm, custom]
    inputBinding:
      prefix: --sample-tags-version

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