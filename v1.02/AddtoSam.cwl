#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_add_to_sam.py]
stdout: $(inputs.R2_Bam.nameroot.split('.')[0]).AddtoSam.log

inputs:

  Data_Tables:
    type: File[]?
    inputBinding:
      itemSeparator: ","
      prefix: --data-tables

  Annotation_R1:
    type: File[]
    inputBinding:
      itemSeparator: ","
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
      glob: "Annotated_mapping_R2.BAM"

  output:
    type: stdout

