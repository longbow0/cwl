#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_add_to_sam.py]
stdout: $(inputs.R2_Bam.nameroot.split('.')[0]).AddtoSam.log

inputs:

  Reads_Per_Cell:
    type: File?
    inputBinding:
      separate: true
      prefix: --reads
      position: 1

  Read_Annot:
    type: File
    inputBinding:
      separate: true
      prefix: --read-annot
      position: 2

  Mol_Annot:
    type: File
    inputBinding:
      separate: true
      prefix: --mol-annot
      position: 4

  R2_Bam:
    type: File
    inputBinding:
      separate: true
      itemSeparator: ","
      prefix: --bam
      position: 3

outputs:

  Annotated_Bam:
    type: File
    outputBinding:
      glob: "Annotated_mapping_R2.BAM"

  output:
    type: stdout

