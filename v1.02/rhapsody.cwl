#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: MultipleInputFeatureRequirement

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

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

  Sample_Tags_Version:
    type: string?

  Subsample_Tags:
    type: float?

  Tag_Names:
    type: string[]?

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
    outputSource: GetDataTable/Data_Tables

  Trueno_out:
    type: File[]?
    outputSource: GetDataTable/Trueno_out

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
      Sample_Tags_Version: Sample_Tags_Version
    out: [Index, Annotation, output]

  SplitFastQ:
    requirements:
      ResourceRequirement:
        tmpdirMin: 131072
        outdirMin: 65536
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
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: AnnotateR2.cwl
    in:
      R2: QualityFilter/R2
      Index: CheckReference/Index
      Annotation: CheckReference/Annotation
    out: [Annot_R2, R2_Bam, Full_Genes, output]
    scatter: AnnotateR2/R2

  AnnotateReads:
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: AnnotateReads.cwl
    in:
      R1_Annotation: AnnotateR1/Annotation_R1
      R2_Annotation: AnnotateR2/Annot_R2
      Filter_Metrics: QualityFilter/Filter_Metrics
      Bam_Input: Bam_Input
      Sample_Tags_Version: Sample_Tags_Version
      Subsample_Tags: Subsample_Tags
      Index: CheckReference/Index
    out: [Seq_Metrics, Valid_Reads, Annotation_Read, output]

  AnnotateMolecules:
    requirements:
      ResourceRequirement:
        ramMin: 16000
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
      Tag_Names: Tag_Names
    out: [Annot_Files,Cell_Label_Filter, Data_Tables, Expression_Data, MI_Adjusted_Stats, Putative_Cells_Origin,
          Trueno_out, output]

  AddtoSam:
    requirements:
      ResourceRequirement:
        tmpdirMin: 262144
        outdirMin: 131072
    run: AddtoSam.cwl
    in:
      Data_Tables: GetDataTable/Data_Tables
      Annotation_R1: AnnotateR1/Annotation_R1
      Annot_Files: GetDataTable/Annot_Files
      R2_Bam: AnnotateR2/R2_Bam
    out: [Annotated_Bam, output]
    scatter: R2_Bam

  Metrics:
    requirements:
      ResourceRequirement:
        ramMin: 32000
        tmpdirMin: 65536
        outdirMin: 65536
    run: Metrics.cwl
    in:
      Annotated_Bam: AddtoSam/Annotated_Bam
      Data_Tables: GetDataTable/Data_Tables
      Annot_Files: GetDataTable/Annot_Files
      Read_Annot: AnnotateReads/Annotation_Read
    out: [Metrics_Summary, Final_Bam, output]

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