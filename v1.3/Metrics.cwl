cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_metrics.py
stdout: Metrics.log
inputs:
  Annotated_Bam:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --bam
  Annot_Files:
    type: File
    inputBinding:
      prefix: --annot-files
  Read_Annot:
    type: File
    inputBinding:
      prefix: --read-annot
  Seq_Run:
    type: string?
    inputBinding:
      prefix: --seq-run
  Data_Tables:
    type: File[]?
    inputBinding:
      itemSeparator: ','
      prefix: --data-tables
outputs:
  Metrics_Summary:
    type: File
    outputBinding:
      glob: '*_Metrics_Summary.csv'
  Metrics_Archive:
    type: File
    outputBinding:
      glob: internal-metrics-archive.tar.gz
  Final_Bam:
    type: File
    outputBinding:
      glob: '*.final.BAM'
  output:
    type: File
    outputBinding:
      glob: '*.log'
