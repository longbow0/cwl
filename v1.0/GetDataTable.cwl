#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_get_datatables.py]
stdout: GetDataTable.log

inputs:

  Molecule_Annotation_List:
    type: File[]
    inputBinding:
      itemSeparator: ","
      separate: true
      prefix: --mol-annot
      position: 1

  Gene_Status_List:
    type: File[]
    inputBinding:
      itemSeparator: ","
      separate: true
      prefix: --gene-status
      position: 2

  Seq_Metrics:
    type: File
    inputBinding:
      separate: true
      prefix: --seq-stats
      position: 3

  Full_Genes:
    type: File[]?
    inputBinding:
      itemSeparator: ","
      separate: True
      prefix: --full-gene-list
      position: 4

outputs:

  Metrics_Files:
    type: File
    outputBinding:
      glob: "metrics-files.tar.gz"

  Reads_Per_Cell:
    type: File?
    outputBinding:
      glob: "*ReadsPerCell.csv"

  Expression_Data:
    type: File
    outputBinding:
      glob: "*_Expression_Data.st"

  Cell_Label_Filter:
    type: File[]?
    outputBinding:
      glob: "*.png"

  Gene_Status:
    type: File
    outputBinding:
      glob: "*_GeneStatus.csv"

  Mol_Annot:
    type: File
    outputBinding:
      glob: "*_Annotation_Molecule.csv"

  MI_Adjusted_Stats:
    type: File?
    outputBinding:
      glob: "*_UMI_Adjusted_Stats.csv"

  Putative_Cells_Origin:
    type: File?
    outputBinding:
      glob: "*_Putative_Cells_Origin.csv"

  output:
    type: stdout

