#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: rhapsody

baseCommand: [mist_metrics.py]
stdout: Metrics.log

inputs:

  Annotated_Bam:
    type: File[]
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --bam
      position: 1

  Metrics_Files:
    type: File
    inputBinding:
      separate: true
      prefix: --metrics-files
      position: 2
      
  Read_Annot:
    type: File
    inputBinding:
      separate: true
      prefix: --read-annot
      position: 3

outputs:

  Metrics_Summary:
    type: File
    outputBinding:
      glob: "*_Metrics_Summary.csv"

  Data_Tables:
    type: File[]?
    outputBinding:
      glob: "*PerCell.csv"

  Final_Bam:
    type: File
    outputBinding:
      glob: '*.final.BAM'

  output:
    type: stdout
