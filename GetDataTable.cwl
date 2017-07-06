#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_get_datatables.py]
stdout: datatables.log

inputs:

  Molecule_annotation_list:
    type: File[]
    inputBinding:
      itemSeparator: ","
      separate: true
      prefix: --mol-annot
      position: 1

  Gene_status_list:
    type: File[]
    inputBinding:
      itemSeparator: ","
      separate: true
      prefix: --gene-status
      position: 2

  SeqMetrics:
    type: File
    inputBinding:
      separate: true
      prefix: --seq-stats
      position: 3

  Full_genes:
    type: File[]?
    inputBinding:
      itemSeparator: ","
      separate: True
      prefix: --full-gene-list
      position: 4

outputs:

  Metrics_files:
    type: File
    outputBinding:
      glob: "metrics-files.tar.gz"

  ReadsPerCell:
    type: File
    outputBinding:
      glob: "*ReadsPerCell.csv"

  Expression_Data:
    type: File
    outputBinding:
      glob: "*_Expression_Data.st"

  cell_label_filter:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.png"

  Gene_status:
    type: File
    outputBinding:
      glob: "*_GeneStatus.csv"

  molAnnot:
    type: File
    outputBinding:
      glob: "*_Annotation_Molecule.csv"

  molAnnotBG:
    type: File
    outputBinding:
      glob: "*_Annotation_Molecule_by_gene.csv"

  MI_Adjusted_Stats:
    type: File
    outputBinding:
      glob: "*_UMI_Adjusted_Stats.csv"

  MI_Adjusted_Stats_Filtered:
    type: File
    outputBinding:
      glob: "*_UMI_Adjusted_CellLabel_Stats.csv"

  output:
    type: stdout
