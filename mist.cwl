#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement

hints:
  DockerRequirement:
    dockerPull: mist

inputs:

  Reads:
    type:
      type: array
      items: File

  Label_version:
    type: ["null", int]

  Internal_run:
    type: ["null", boolean]

  Read_filter_off:
    type: ["null", boolean]

  Barcode_num:
    type: ["null", int]

  Alignment_length:
    type: ["null", int]

  Reference: 
    type:
      type: array
      items: File

  Bam_input:
    type:
      - "null"
      - type: array
        items: File

  Num_cell_image:
    type: ["null", int]

  Marker_file:
    type: ["null", File]

  Cell_type:
    type: ["null", File]

outputs:
  Annotation_R1:
    type:
      type: array
      items: File
    outputSource: AnnotateR1/Annotation_R1

  R2_bam:
    type:
      type: array
      items: File
    outputSource: AnnotateR2/R2_bam

  Annot_R2:
    type:
      type: array
      items: File
    outputSource: AnnotateR2/Annot_R2

  SeqMetrics:
    type: File
    outputSource: AnnotateReads/SeqMetrics

  Valid_Reads:
    type:
      type: array
      items: File
    outputSource: AnnotateReads/Valid_Reads

  Annotation_Read:
    type: File
    outputSource: AnnotateReads/Annotation_Read

  molAnnot:
    type: File
    outputSource: GetDataTable/molAnnot

  molAnnotBG:
    type: File
    outputSource: GetDataTable/molAnnotBG

  Gene_status:
    type: File
    outputSource: GetDataTable/Gene_status

  MI_Adjusted_Stats:
    type: File
    outputSource: GetDataTable/MI_Adjusted_Stats

  MI_Adjusted_Stats_Filtered:
    type: File
    outputSource: GetDataTable/MI_Adjusted_Stats_Filtered

  Metrics_files:
    type: File
    outputSource: GetDataTable/Metrics_files

  cell_label_filter:
    type: 
      type: array
      items: File
    outputSource: GetDataTable/cell_label_filter

  ReadsPerCell:
    type: File
    outputSource: GetDataTable/ReadsPerCell

  Expression_Data:
    type: File
    outputSource: GetDataTable/Expression_Data

  FinalBam:
    type: File
    outputSource: AddtoSam/FinalBam

  MetricsSummary:
    type: File
    outputSource: Metrics/MetricsSummary

  DataTables:
    type:
      - "null"
      - type: array
        items: File
    outputSource: Metrics/DataTables

  MetricsArchive:
    type: ["null", File]
    outputSource: Metrics/MetricsArchive

  ClusteringAnalysis:
    type: ["null", File]
    outputSource: ClusterAnalysis/ClusteringAnalysis

steps:

  CheckReference:
    run: CheckReference.cwl
    in:
      Label_version: Label_version
      Reference: Reference
    out: [index, Annotation, Extra_seqs]

  SplitFastQ:
    requirements:
      ResourceRequirement:
        tmpdirMin: 131072
        outdirMin: 65536
    run: SplitFastQ.cwl
    in:
      Reads: Reads
      Label_version: Label_version
    out: [Read_pairs]

  QualityFilter:
    run: QualityFilter.cwl
    in:
      Read_pairs: SplitFastQ/Read_pairs
      Label_version: Label_version
      Read_filter_off: Read_filter_off
    out: [FilterMetrics,R1,R2]
    scatter: QualityFilter/Read_pairs

  AnnotateR1:
    run: AnnotateR1.cwl
    in:
      R1: QualityFilter/R1
      Label_version: Label_version
    out: [Annotation_R1]
    scatter: AnnotateR1/R1

  AnnotateR2:
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: AnnotateR2.cwl
    in:
      R2: QualityFilter/R2
      Alignment_length: Alignment_length
      Label_version: Label_version
      Index: CheckReference/index
      Annotation: CheckReference/Annotation
      Extra_seqs: CheckReference/Extra_seqs
    out: [Annot_R2,R2_bam,GTF,Full_genes]
    scatter: AnnotateR2/R2

  AnnotateReads:
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: AnnotateReads.cwl
    in:
      R1_annotation: AnnotateR1/Annotation_R1
      R2_annotation: AnnotateR2/Annot_R2
      FilterMetrics: QualityFilter/FilterMetrics
      Extra_seqs: CheckReference/Extra_seqs
      Alignment_length: Alignment_length
      Bam_input: Bam_input
      Label_version: Label_version
      Index: CheckReference/index
      Num_cell_image: Num_cell_image
      Internal_run: Internal_run
    out: [SeqMetrics,Valid_Reads,Annotation_Read]

  AnnotateMolecules:
    requirements:
      ResourceRequirement:
        ramMin: 16000
    run: AnnotateMolecules.cwl
    in:
      Valids: AnnotateReads/Valid_Reads
      Barcode_num: Barcode_num
    out: [molAnnot_list,Gene_status_list]
    scatter: AnnotateMolecules/Valids

  GetDataTable:
    run: GetDataTable.cwl
    in:
      Molecule_annotation_list: AnnotateMolecules/molAnnot_list
      Gene_status_list: AnnotateMolecules/Gene_status_list
      SeqMetrics: AnnotateReads/SeqMetrics
      Full_genes: AnnotateR2/Full_genes
    out: [Metrics_files,cell_label_filter,ReadsPerCell,Expression_Data,molAnnot,molAnnotBG,Gene_status, MI_Adjusted_Stats,MI_Adjusted_Stats_Filtered]

  AddtoSam:
    requirements:
      ResourceRequirement:
        tmpdirMin: 262144
        outdirMin: 131072
    run: AddtoSam.cwl
    in:
      ReadsPerCell: GetDataTable/ReadsPerCell
      ReadAnnot: AnnotateReads/Annotation_Read
      MolAnnot: GetDataTable/molAnnot
      Bam_file: AnnotateR2/R2_bam
    out: [FinalBam]

  Metrics:
    run: Metrics.cwl
    in:
      Final_Bam: AddtoSam/FinalBam
      Metrics_files: GetDataTable/Metrics_files
      ReadAnnot: AnnotateReads/Annotation_Read
      Marker_file: Marker_file
      Cell_type: Cell_type
    out: [MetricsSummary,DataTables, MetricsArchive]

  ClusterAnalysis:
    run: ClusteringAnalysis.cwl
    in:
      DataTable: GetDataTable/Expression_Data
    out: [ClusteringAnalysis, ClusteringAnalysisInternal]

