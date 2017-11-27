#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: rhapsody:v1.02

baseCommand: [mist_cluster_analysis.py]
stdout: ClusterAnalysis.log

inputs:

  Data_Table:
    type:
      - File[]
      - File
    inputBinding:
      itemSeparator: ','
      prefix: --datatable

outputs:

  Clustering_Analysis:
    type: File?
    outputBinding:
      glob: "ClusteringAnalysis.zip"

  output:
    type: stdout


