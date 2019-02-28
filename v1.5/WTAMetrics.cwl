cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: mist
baseCommand:
- mist_wta_add_on_metrics.py
stdout: WTAMetrics.log
inputs:
  Bam:
    type: File[]
    inputBinding:
      prefix: --bam
  Rsec_Mols:
    type: File[]
    inputBinding:
      prefix: --rsec-mols
  Ribosomal_annotation:
    type: File[]
    inputBinding:
      prefix: --ribo-annot
  Mitochondrial_annotation:
    type: File[]
    inputBinding:
      prefix: --mito-annot
  RefFlat:
    type: File[]
    inputBinding:
      prefix: --refflat
outputs:
  WTA_metrics:
    type: File
    outputBinding:
      glob: '*_WTA_Supplemental_Metrics.csv'
  output:
    type: stdout
