requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
$namespaces:
  arv: http://arvados.org/cwl#
hints:
  arv:RuntimeConstraints:
    keep_cache: 512
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_cluster_analysis.py
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
      glob: ClusteringAnalysisInternal*.zip
  output:
    type: File
    outputBinding:
      glob: '*.log'
