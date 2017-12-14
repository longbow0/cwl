#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_get_datatables.py]
stdout: GetDataTable.log

inputs:

  Molecule_Annotation_List:
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: --mol-annot

  Gene_Status_List:
    type: File[]
    inputBinding:
      itemSeparator: ","
      prefix: --gene-status

  Seq_Metrics:
    type: File
    inputBinding:
      prefix: --seq-stats

  Full_Genes:
    type: File[]?
    inputBinding:
      itemSeparator: ","
      prefix: --full-gene-list

  Tag_Names:
    type: string[]?
    inputBinding:
      itemSeparator: ","
      prefix: --tag-names

outputs:

  Annot_Files:
    type: File
    outputBinding:
      glob: "metrics-files.tar.gz"

  Data_Tables:
    type: File[]?
    outputBinding:
      glob: "*PerCell.csv"

  Expression_Data:
    type: File
    outputBinding:
      glob: "*_Expression_Data.st"

  Cell_Label_Filter:
    type: File[]?
    outputBinding:
      glob: "Metrics-files/Cell_Label_Filtering/*.png"

  Putative_Cells_Origin:
    type: File?
    outputBinding:
      glob: "Metrics-files/Cell_Label_Filtering/*_Putative_Cells_Origin.csv"

  MI_Adjusted_Stats:
    type: File?
    outputBinding:
      glob: "Metrics-files/Annotations/*_UMI_Adjusted_Stats.csv"

  Trueno_out:
    type: File[]?
    outputBinding:
      glob: "Trueno/*"

  output:
    type: stdout

