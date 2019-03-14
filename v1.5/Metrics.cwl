requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
cwlVersion: v1.0
class: CommandLineTool
$namespaces:
  arv: http://arvados.org/cwl#
  sbg: "https://sevenbridges.com"
hints:
- class: "arv:RuntimeConstraints"
  keep_cache: 512
- class: "sbg:AWSInstanceType"
  value: "r4.16xlarge"
baseCommand:
- mist_metrics.py
inputs:
  Annot_Files:
    type: File
    inputBinding:
      prefix: --annot-files
  Seq_Run:
    type: string?
    inputBinding:
      prefix: --seq-run
  Data_Tables:
    type: File[]?
    inputBinding:
      itemSeparator: ','
      prefix: --data-tables
  Seq_Metrics:
    type: File
    inputBinding:
      prefix: --seq-stats
  Molecular_Annotation:
    type: File
    inputBinding:
      prefix: "--annot-mol-file"
  Tag_Annotation:
    type: File?
    inputBinding:
      prefix: "--tag-annot"
  UMI_Adjusted_Stats:
    type: File?
    inputBinding:
      prefix: "--umi-adjusted-stats"
outputs:
  Metrics_Summary:
    type: File
    outputBinding:
      glob: '*_Metrics_Summary.csv'
  Metrics_Archive:
    type: File
    outputBinding:
      glob: internal-metrics-archive.tar.gz
  output:
    type: File
    outputBinding:
      glob: '*.log'
