cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_get_datatables.py
stdout: GetDataTable.log
inputs:
  Molecule_Annotation_List:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --mol-annot
  Gene_Status_List:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --gene-status
  Seq_Metrics:
    type: File
    inputBinding:
      prefix: --seq-stats
  Full_Genes:
    type:
      items:
      - 'null'
      - File
      type: array
    inputBinding:
      itemSeparator: ','
      prefix: --full-gene-list
  Putative_Cell_Call:
    type: int?
    inputBinding:
      prefix: --putative-cell-call
  Tag_Names:
    type: string[]?
    inputBinding:
      itemSeparator: ','
      prefix: --tag-names
outputs:
  Annot_Files:
    type: File
    outputBinding:
      glob: metrics-files.tar.gz
  Data_Tables:
    type: File[]?
    outputBinding:
      glob: '*PerCell.csv'
  Data_Tables_Unfiltered:
    type: File[]?
    outputBinding:
      glob: '*PerCell_Unfiltered.csv.gz'
  Expression_Data:
    type: File
    outputBinding:
      glob: '*_Expression_Data.st'
  Expression_Data_Unfiltered:
    type: File?
    outputBinding:
      glob: '*_Expression_Data_Unfiltered.st.gz'
  Cell_Label_Filter:
    type: File[]?
    outputBinding:
      glob: Metrics-files/Cell_Label_Filtering/*.png
  Putative_Cells_Origin:
    type: File?
    outputBinding:
      glob: Metrics-files/Cell_Label_Filtering/*_Putative_Cells_Origin.csv
  MI_Adjusted_Stats:
    type: File?
    outputBinding:
      glob: Metrics-files/Annotations/*_UMI_Adjusted_Stats.csv
  Trueno_out:
    type: File[]?
    outputBinding:
      glob: Trueno/*
  output:
    type: File
    outputBinding:
      glob: '*.log'
