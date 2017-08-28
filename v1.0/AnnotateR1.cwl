#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: rhapsody

baseCommand: [mist_annotate_R1.py]
stdout: $(inputs.R1.nameroot.split('.')[0]).AnnotateR1.log

inputs:

  R1: 
    type: File
    inputBinding:
      separate: true
      prefix: --R1
      position: 1

outputs:

  Annotation_R1:
    type: File
    outputBinding:
      glob: "*_Annotation_R1.csv"

  output:
    type: stdout