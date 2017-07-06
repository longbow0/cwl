#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_metrics.py]
stdout: metrics.log
inputs:

  Final_Bam:
    type: File
    inputBinding:
      separate: true
      prefix: --bam
      position: 1

  Metrics_files:
    type: File
    inputBinding:
      separate: true
      prefix: --metrics-files
      position: 2
      
  ReadAnnot:
    type: File
    inputBinding:
      separate: true
      prefix: --read-annot
      position: 3

  Marker_file:
    type: File?
    inputBinding:
      separate: true
      prefix: --marker-file
      position: 4

  Cell_type:
    type: File?
    inputBinding:
      separate: true
      prefix: --show-cell-type
      position: 5

outputs:

  MetricsSummary:
    type: File
    outputBinding:
      glob: "*_Metrics_Summary.csv"

  DataTables:
    type: File[]?
    outputBinding:
      glob: "*PerCell.csv"

  MetricsArchive:
    type: File
    outputBinding:
      glob: "internal-metrics-archive.tar.gz"

  output:
    type: stdout
