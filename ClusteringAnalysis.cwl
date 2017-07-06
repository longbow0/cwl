#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_cluster_analysis.py]
stdout: cluster_analysis.log

inputs:

  DataTable:
    type:
      - File[]
      - File
    inputBinding:
      itemSeparator: ','
      separate: true
      prefix: --datatable
      position: 1

outputs:

  ClusteringAnalysis:
    type: File
    outputBinding:
      glob: "ClusteringAnalysis.zip"

  ClusteringAnalysisInternal:
    type: File?
    outputBinding:
      glob: "ClusterNumberAnalysis*.zip"

  output:
    type: stdout

