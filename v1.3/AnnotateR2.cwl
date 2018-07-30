cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_annotate_R2.py
stdout: AnnotateR2.log
inputs:
  R2:
    type: File
    inputBinding:
      prefix: --R2
  Index:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --index
  Extra_Seqs:
    type: File?
    inputBinding:
      prefix: --extra-seqs
outputs:
  Annot_R2:
    type: File
    outputBinding:
      glob: '*Annotation_R2.csv'
  R2_Bam:
    type: File
    outputBinding:
      glob: '*mapping_R2.BAM'
  R2_Quality_Metrics:
    type: File
    outputBinding:
      glob: '*_picard_quality_metrics.csv'
  GTF:
    type: File?
    outputBinding:
      glob: '*-annot.gtf'
  Full_Genes:
    type: File?
    outputBinding:
      glob: '*gene-list.txt'
  output:
    type: File
    outputBinding:
      glob: '*.log'
