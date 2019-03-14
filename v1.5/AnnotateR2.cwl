requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
$namespaces:
  arv: http://arvados.org/cwl#
  sbg: "https://sevenbridges.com"
hints:
  - class: arv:RuntimeConstraints
    keep_cache: 512
  - class: 'sbg:AWSInstanceType'
    value: c5.18xlarge
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_annotate_R2.py
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
      glob: "*Annotation_R2.csv.gz"
  R2_Bam:
    type: File
    outputBinding:
      glob: "*mapping_R2.BAM"
  R2_Quality_Metrics:
    type: File
    outputBinding:
      glob: '*_picard_quality_metrics.csv.gz'
  GTF:
    type: File?
    outputBinding:
      glob: '*-annot.gtf'
  output:
    type: File
    outputBinding:
      glob: '*.log'
