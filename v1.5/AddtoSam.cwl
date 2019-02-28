requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_add_to_sam.py
inputs:
  Data_Tables:
    type: File[]?
    inputBinding:
      itemSeparator: ","
      prefix: "--data-tables"
  Annotation_R1:
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: "--annot-r1"
  Molecular_Annotation:
    type: File
    inputBinding:
      prefix: "--annot-mol-file"
  Tag_Calls:
    type: File?
    inputBinding:
      prefix: "--tag-calls"
  R2_Bam:
    type: File
    inputBinding:
      prefix: "--r2-bam"
  Seq_Metrics:
    type: File
    inputBinding:
      prefix: "--seq-stats"
outputs:
  Annotated_Bam:
    type: File
    outputBinding:
      glob: "Annotated_mapping_R2.BAM"
  output:
    type: File
    outputBinding:
      glob: "*.log"