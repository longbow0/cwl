#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
label: BD Rhapsody™ Analysis Pipeline
doc: >-
  The BD Rhapsody™ assays are used to create sequencing libraries from single
  cell transcriptomes.


  After sequencing, the analysis pipeline takes the FASTQ files and a reference
  file for gene alignment. The pipeline generates molecular counts per cell,
  read counts per cell, metrics, and an alignment file.
$namespaces:
  sbg: "https://sevenbridges.com"
requirements:
- class: ScatterFeatureRequirement
- class: MultipleInputFeatureRequirement
- class: SubworkflowFeatureRequirement
inputs:
  Reads:
    type: File[]
    label: Reads
    "sbg:fileTypes": "fastq.gz, fq.gz"
  AbSeq_Reference:
   type: File[]?
   label: AbSeq Reference
  Reference:
   type: File[]
   label: Reference
  Subsample:
    type: float?
    label: Subsample Reads
    doc: >
      Any number of reads >1 or a fraction between 0 < n < 1 to indicate the percentage
      of reads to subsample.
  Subsample_seed:
    type: int?
    label: Subsample Seed
    doc: >
      For use when replicating a previous subsampling run only. Obtain the seed generated
      from the log file for the SplitFastQ node.
  Subsample_Tags:
    type: float?
    label: Subsample Sample Tags
    doc: >
      Any number of reads > 1 or a fraction between 0 < n < 1 to indicate the percentage
      of tag reads to subsample.
  Tag_Names:
    type: string[]?
    label: Tag Names
    doc: >
      Specify the Sample Tag number followed by - (hyphen) and a sample name to appear
      in the output files. For example: 4-Ramos. Do not use the special characters:
      &, (), [], {}, <>, ?, |
  Sample_Tags_Version:
    label: Sample Tags Version
    doc: The reference AbOligo tags for the multiplexed experiment
    type:
    - 'null'
    - type: enum
      name: 'Sample_Tags_Version'
      symbols:
      - human
      - hs
      - mouse
      - mm
      - custom
outputs:
  UMI_Adjusted_Stats:
    label: UMI Adjusted Statistics
    type: File?
    outputSource: GetDataTable/UMI_Adjusted_Stats
  Cell_Label_Filter:
    label: Cell Label Filter
    type: File[]?
    outputSource: GetDataTable/Cell_Label_Filter
  Expression_Data:
    label: Expression Matrix
    type: File
    outputSource: Uncompress_Datatables/Uncompressed_Expression_Matrix
  Final_Bam:
    label: Final BAM File
    type: File
    outputSource: MergeBAM/Final_Bam
  Metrics_Summary:
    label: Metrics Summary
    type: File
    outputSource: Metrics/Metrics_Summary
  Data_Tables:
    label: Data Tables
    type: File[]?
    outputSource: Uncompress_Datatables/Uncompressed_Data_Tables
  Data_Tables_Unfiltered:
    label: Unfiltered Data Tables
    type: File[]?
    outputSource: GetDataTable/Data_Tables_Unfiltered
  Expression_Data_Unfiltered:
    label: Unfiltered Expression Matrix
    type: File?
    outputSource: GetDataTable/Expression_Data_Unfiltered
  Logs:
    label: Pipeline Logs
    type: Directory
    outputSource: BundleLogs/logs_dir
  Putative_Cells_Origin:
    label: Putative Cells Origin
    type: File?
    outputSource: GetDataTable/Putative_Cells_Origin
  Clustering_Analysis:
    label: Cluster Analysis
    type: File?
    outputSource: ClusterAnalysis/Clustering_Analysis
  Multiplex:
    type: File[]?
    outputSource: GetDataTable/Trueno_out
steps:
  Subsample_Settings:
    label: Subsample Settings
    run: SubsampleSettings.cwl
    in:
      _Subsample_Reads: Subsample
      _Subsample_Seed: Subsample_seed
    out:
    - Subsample_Reads
    - Subsample_Seed
  Multiplexing_Settings:
    label: Multiplexing Settings
    run: MultiplexingSettings.cwl
    in:
      _Subsample_Tags: Subsample_Tags
      _Tag_Sample_Names: Tag_Names
      _Sample_Tags_Version: Sample_Tags_Version
    out:
    - Subsample_Tags
    - Tag_Sample_Names
    - Sample_Tags_Version
  Internal_Settings:
    label: Internal Settings
    run: InternalSettings.cwl
    in: []
    out:
    - Label_Version
    - Read_Filter_Off
    - Barcode_Num
    - Seq_Run
    - AbSeq_UMI
    - Putative_Cell_Call
    - Use_DBEC
    - Extra_Seqs
    - MinChunkSize
    - NumRecordsPerSplit
  CheckReference:
    run: CheckReference.cwl
    in:
      Reference: Reference
      AbSeq_Reference: AbSeq_Reference
      Label_Version: Internal_Settings/Label_Version
      Sample_Tags_Version: Multiplexing_Settings/Sample_Tags_Version
      Putative_Cell_Call: Internal_Settings/Putative_Cell_Call
    out:
    - Index
    - Extra_Seqs
    - Reference_Panel_Names
    - Full_Genes
    - output
  CheckFastqs:
    run: CheckFastqs.cwl
    in:
      Reads: Reads
      Subsample: Subsample_Settings/Subsample_Reads
      UserInputSubsampleSeed: Subsample_Settings/Subsample_Seed
      MinChunkSize: Internal_Settings/MinChunkSize
    out:
    - SubsampleSeed
    - SubsamplingRatio
    - FilesToSkipSplitAndSubsample
    - log
  SplitAndSubsample:
    run: SplitAndSubsample.cwl
    in:
      Fastqs: Reads
      FilesToSkipSplitAndSubsample: CheckFastqs/FilesToSkipSplitAndSubsample
      SubsampleRatio: CheckFastqs/SubsamplingRatio
      SubsampleSeed: CheckFastqs/SubsampleSeed
      NumRecordsPerSplit: Internal_Settings/NumRecordsPerSplit
    out:
    - SplitAndSubsampledFastqs
    - log
  PairReadFiles:
    run: PairReadFiles.cwl
    in:
      Reads: SplitAndSubsample/SplitAndSubsampledFastqs
    out:
    - ReadPairs
  QualityFilter:
    run: QualityFilter.cwl
    in:
      Split_Read_Pairs: PairReadFiles/ReadPairs
      Label_Version: Internal_Settings/Label_Version
      Read_Filter_Off: Internal_Settings/Read_Filter_Off
    scatter:
    - Split_Read_Pairs
    scatterMethod: dotproduct
    out:
    - Filter_Metrics
    - R1
    - R2
    - output
  AnnotateR1:
    run: AnnotateR1.cwl
    in:
      R1: QualityFilter/R1
      Label_Version: Internal_Settings/Label_Version
    out:
    - Annotation_R1
    - output
    scatter:
    - R1
  AnnotateR2:
    requirements:
      ResourceRequirement:
        ramMin: 4000
    run: AnnotateR2.cwl
    in:
      R2: QualityFilter/R2
      Index: CheckReference/Index
      Extra_Seqs: Internal_Settings/Extra_Seqs
    out:
    - Annot_R2
    - R2_Bam
    - GTF
    - output
    - R2_Quality_Metrics
    scatter:
    - R2
  AnnotateReads:
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: AnnotateReads.cwl
    in:
      R1_Annotation: AnnotateR1/Annotation_R1
      R2_Annotation: AnnotateR2/Annot_R2
      Filter_Metrics: QualityFilter/Filter_Metrics
      Extra_Seqs: Internal_Settings/Extra_Seqs
      Sample_Tags_Version: Multiplexing_Settings/Sample_Tags_Version
      Subsample_Tags: Multiplexing_Settings/Subsample_Tags
      Label_Version: Internal_Settings/Label_Version
      Index: CheckReference/Index
      Putative_Cell_Call: Internal_Settings/Putative_Cell_Call
      R2_Quality_Metrics: AnnotateR2/R2_Quality_Metrics
      Reference_Panel_Names: CheckReference/Reference_Panel_Names
      AbSeq_UMI: Internal_Settings/AbSeq_UMI
    out:
    - Seq_Metrics
    - Valid_Reads
    - Annotation_Read
    - Is_Trueno
    - Sample_Name
    - output
  AnnotateMolecules:
    run: AnnotateMolecules.cwl
    in:
      Valids: AnnotateReads/Valid_Reads
      Barcode_Num: Internal_Settings/Barcode_Num
      Use_DBEC: Internal_Settings/Use_DBEC
      AbSeq_UMI: Internal_Settings/AbSeq_UMI
    out:
    - Mol_Annot_List
    - Gene_Status_List
    - output
    scatter:
    - Valids
  GetDataTable:
    requirements:
      ResourceRequirement:
        ramMin: 32000
    run: GetDataTable.cwl
    in:
      Molecule_Annotation_List: AnnotateMolecules/Mol_Annot_List
      Gene_Status_List: AnnotateMolecules/Gene_Status_List
      Seq_Metrics: AnnotateReads/Seq_Metrics
      Full_Genes: CheckReference/Full_Genes
      Putative_Cell_Call: Internal_Settings/Putative_Cell_Call
      Tag_Names: Multiplexing_Settings/Tag_Sample_Names
    out:
    - Tag_Calls
    - Molecular_Annotation
    - Tag_Annotation
    - Annot_Files
    - Cell_Label_Filter
    - Data_Tables
    - Data_Tables_Unfiltered
    - Expression_Data
    - Expression_Data_Unfiltered
    - UMI_Adjusted_Stats
    - Putative_Cells_Origin
    - Trueno_out
    - output
  AddtoSam:
    requirements:
      ResourceRequirement:
        ramMin: 16000
        tmpdirMin: 262144
        outdirMin: 131072
    run: AddtoSam.cwl
    in:
      Data_Tables: GetDataTable/Data_Tables
      Annotation_R1: AnnotateR1/Annotation_R1
      Molecular_Annotation: GetDataTable/Molecular_Annotation
      Tag_Calls: GetDataTable/Tag_Calls
      R2_Bam: AnnotateR2/R2_Bam
      Seq_Metrics: AnnotateReads/Seq_Metrics
    out:
    - Annotated_Bam
    - output
    scatter:
    - R2_Bam
  MergeBAM:
    run: MergeBAM.cwl
    in:
      BamFiles: AddtoSam/Annotated_Bam
      Is_Trueno: AnnotateReads/Is_Trueno
      Sample_Name: AnnotateReads/Sample_Name
    out:
    - Final_Bam
    - log
  Metrics:
    requirements:
      ResourceRequirement:
        ramMin: 32000
        tmpdirMin: 65536
        outdirMin: 65536
    run: Metrics.cwl
    in:
      Data_Tables: GetDataTable/Data_Tables
      Annot_Files: GetDataTable/Annot_Files
      Seq_Run: Internal_Settings/Seq_Run
      Seq_Metrics: AnnotateReads/Seq_Metrics
      Molecular_Annotation: GetDataTable/Molecular_Annotation
      Tag_Annotation: GetDataTable/Tag_Annotation
      UMI_Adjusted_Stats: GetDataTable/UMI_Adjusted_Stats
    out:
    - Metrics_Summary
    - Metrics_Archive
    - output
  ClusterAnalysis:
    requirements:
      ResourceRequirement:
        ramMin: 16000
    run: ClusteringAnalysis.cwl
    in:
      Data_Table: GetDataTable/Expression_Data
    out:
    - Clustering_Analysis
    - output
  Uncompress_Datatables:
    run: UncompressDatatables.cwl
    in:
      Compressed_Data_Table: GetDataTable/Data_Tables
      Compressed_Expression_Matrix: GetDataTable/Expression_Data
    out:
      - Uncompressed_Data_Tables
      - Uncompressed_Expression_Matrix
  BundleLogs:
    run: BundleLogs.cwl
    in:
      log_files:
        source:
        - AnnotateReads/output
        - AnnotateR1/output
        - AnnotateR2/output
        - CheckReference/output
        - GetDataTable/output
        - Metrics/output
        - AddtoSam/output
        - AnnotateMolecules/output
        - QualityFilter/output
        - CheckFastqs/log
        - SplitAndSubsample/log
        - MergeBAM/log
        - ClusterAnalysis/output
        linkMerge: merge_flattened
    out:
    - logs_dir
