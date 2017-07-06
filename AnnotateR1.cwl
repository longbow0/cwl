#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_annotate_R1.py]
stdout: output.txt

inputs:

  R1: 
    type: File
    inputBinding:
      separate: true
      prefix: --R1
      position: 1

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 2

outputs:
  Annotation_R1:
    type: File
    outputBinding:
      glob: "*_Annotation_R1.csv"

  output:
    type: stdout