#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: MultipleInputFeatureRequirement

hints:
  DockerRequirement:
    dockerPull: rhapsody

inputs:

  Reads:
    type: File[]

  Subsample:
    type: float?

  Subsample_seed:
    type: float?

  Reference: 
    type: File[]

  Bam_Input:
    type: File[]?

outputs:

  MI_Adjusted_Stats:
    type: File?
    outputSource: GetDataTable/MI_Adjusted_Stats

  Putative_Cells_Origin:
    type: File?
    outputSource: GetDataTable/Putative_Cells_Origin

  Cell_Label_Filter:
    type: File[]?
    outputSource: GetDataTable/Cell_Label_Filter

  Expression_Data:
    type: File
    outputSource: GetDataTable/Expression_Data

  Final_Bam:
    type: File
    outputSource: Metrics/Final_Bam

  Metrics_Summary:
    type: File
    outputSource: Metrics/Metrics_Summary

  Data_Tables:
    type: File[]?
    outputSource: Metrics/Data_Tables

  Clustering_Analysis:
    type: File?
    outputSource: ClusterAnalysis/Clustering_Analysis

  Logs_dir:
    type: Directory
    outputSource: MakeLogDir/logs_out_dir

steps:

  CheckReference:
    run: CheckReference.cwl
    in:
      Reference: Reference
    out: [Index, Annotation, output]

  SplitFastQ:
    run: SplitFastQ.cwl
    in:
      Reads: Reads
      Subsample: Subsample
      Subsample_seed: Subsample_seed
    out: [Read_Pairs, output]

  QualityFilter:
    run: QualityFilter.cwl
    in:
      Read_Pairs: SplitFastQ/Read_Pairs
    out: [Filter_Metrics, R1, R2, output]
    scatter: QualityFilter/Read_Pairs

  AnnotateR1:
    run: AnnotateR1.cwl
    in:
      R1: QualityFilter/R1
    out: [Annotation_R1, output]
    scatter: AnnotateR1/R1

  AnnotateR2:
    run: AnnotateR2.cwl
    in:
      R2: QualityFilter/R2
      Index: CheckReference/Index
      Annotation: CheckReference/Annotation
    out: [Annot_R2, R2_Bam, Full_Genes, output]
    scatter: AnnotateR2/R2

  AnnotateReads:
    run: AnnotateReads.cwl
    in:
      R1_Annotation: AnnotateR1/Annotation_R1
      R2_Annotation: AnnotateR2/Annot_R2
      Filter_Metrics: QualityFilter/Filter_Metrics
      Bam_Input: Bam_Input
      Index: CheckReference/Index
    out: [Seq_Metrics, Valid_Reads, Annotation_Read, output]

  AnnotateMolecules:
    run: AnnotateMolecules.cwl
    in:
      Valids: AnnotateReads/Valid_Reads
    out: [Mol_Annot_List, Gene_Status_List, output]
    scatter: AnnotateMolecules/Valids

  GetDataTable:
    run: GetDataTable.cwl
    in:
      Molecule_Annotation_List: AnnotateMolecules/Mol_Annot_List
      Gene_Status_List: AnnotateMolecules/Gene_Status_List
      Seq_Metrics: AnnotateReads/Seq_Metrics
      Full_Genes: AnnotateR2/Full_Genes
    out: [Metrics_Files, Cell_Label_Filter, Reads_Per_Cell, Expression_Data, Mol_Annot, MI_Adjusted_Stats,
    Putative_Cells_Origin, output]

  AddtoSam:
    run: AddtoSam.cwl
    in:
      Reads_Per_Cell: GetDataTable/Reads_Per_Cell
      Read_Annot: AnnotateReads/Annotation_Read
      Mol_Annot: GetDataTable/Mol_Annot
      R2_Bam: AnnotateR2/R2_Bam
    out: [Annotated_Bam, output]
    scatter: R2_Bam

  Metrics:
    run: Metrics.cwl
    in:
      Annotated_Bam: AddtoSam/Annotated_Bam
      Metrics_Files: GetDataTable/Metrics_Files
      Read_Annot: AnnotateReads/Annotation_Read
    out: [Metrics_Summary, Data_Tables, Final_Bam, output]

  ClusterAnalysis:
    run: ClusteringAnalysis.cwl
    in:
      Data_Table: GetDataTable/Expression_Data
    out: [Clustering_Analysis, output]

  MakeLogDir:
    run: make_log_directory.cwl
    in:
      log_files:
        source: [AnnotateReads/output, AnnotateR1/output, AnnotateR2/output, CheckReference/output,
                 ClusterAnalysis/output, GetDataTable/output, Metrics/output, SplitFastQ/output, AddtoSam/output,
                  AnnotateMolecules/output, QualityFilter/output]
        linkMerge: merge_flattened
    out: [logs_out_dir]