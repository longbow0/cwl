cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_add_to_sam.py
stdout: AddtoSam.log
inputs:
  Data_Tables:
    type: File[]?
    inputBinding:
      itemSeparator: ','
      prefix: --data-tables
  Annotation_R1:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --annot-R1
  Annot_Files:
    type: File
    inputBinding:
      prefix: --annot-files
  R2_Bam:
    type: File
    inputBinding:
      prefix: --bam
outputs:
  Annotated_Bam:
    type: File
    outputBinding:
      glob: Annotated_mapping_R2.BAM
  output:
    type: File
    outputBinding:
      glob: '*.log'
