label: BD Rhapsody™ Analysis Pipeline
doc: 'The BD Rhapsody™ assays are used to create sequencing libraries from single
  cell transcriptomes.


  After sequencing, the analysis pipeline takes the FASTQ files and a reference file
  for gene alignment. The pipeline generates molecular counts per cell, read counts
  per cell, metrics, and an alignment file.

  '
cwlVersion: v1.0
class: Workflow
requirements:
- class: ScatterFeatureRequirement
- class: MultipleInputFeatureRequirement
inputs:
  Reads:
    type: File[]
    label: Reads
  AbSeq_Reference:
    type: File[]?
    label: AbSeq Reference
  Reference:
    type: File[]
    label: Reference
  Bam_Input:
    type: File[]?
    label: Bam Input
  Subsample:
    type: float?
    label: Subsample Reads
    doc: 'Any number of reads >1 or a fraction between 0 < n < 1 to indicate the percentage
      of reads to subsample.

      '
  Subsample_seed:
    type: float?
    label: Subsample Seed
    doc: 'For use when replicating a previous subsampling run only. Obtain the seed
      generated from the log file for the SplitFastQ node.

      '
  Subsample_Tags:
    type: float?
    label: Subsample Sample Tags
    doc: 'Any number of reads > 1 or a fraction between 0 < n < 1 to indicate the
      percentage of tag reads to subsample.

      '
  Tag_Names:
    type: string[]?
    label: Tag Names
    doc: 'Specify the Sample Tag number followed by - (hyphen) and a sample name to
      appear in the output files. For example: 4-Ramos. Do not use the special characters:
      &, (), [], {}, <>, ?, |

      '
  Sample_Tags_Version:
    label: Sample Tags Version
    type:
    - 'null'
    - symbols:
      - No Multiplexing
      - Single-Cell Multiplex Kit - Human
      type: enum
      name: Sample_Tags_Version
    doc: The reference AbOligo tags for the multiplexed experiment
  Extra_Seqs:
    type: File?
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
  Expression_Data_Unfiltered:
    type: File?
    outputSource: GetDataTable/Expression_Data_Unfiltered
  Final_Bam:
    type: File
    outputSource: Metrics/Final_Bam
  Metrics_Summary:
    type: File
    outputSource: Metrics/Metrics_Summary
  Data_Tables:
    type: File[]?
    outputSource: GetDataTable/Data_Tables
  Data_Tables_Unfiltered:
    type: File[]?
    outputSource: GetDataTable/Data_Tables_Unfiltered
  Clustering_Analysis:
    type: File?
    outputSource: ClusterAnalysis/Clustering_Analysis
  Logs_Archive:
    type: File
    outputSource: MakeLogsArchive/logs_tarball
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
  CheckReference:
    run: CheckReference.cwl
    in:
      Label_Version: Internal_Settings/Label_Version
      Reference: Reference
      Sample_Tags_Version: Multiplexing_Settings/Sample_Tags_Version
      AbSeq_Reference: AbSeq_Reference
      Putative_Cell_Call: Internal_Settings/Putative_Cell_Call
    out:
    - Index
    - Extra_Seqs
    - output
    - Reference_Panel_Names
  SplitFastQ:
    requirements:
      ResourceRequirement:
        tmpdirMin: 131072
        outdirMin: 65536
    run: SplitFastQ.cwl
    in:
      Reads: Reads
      Subsample: Subsample_Settings/Subsample_Reads
      Subsample_seed: Subsample_Settings/Subsample_Seed
      Label_Version: Internal_Settings/Label_Version
    out:
    - Read_Pairs
    - output
  QualityFilter:
    run: QualityFilter.cwl
    in:
      Read_Pairs: SplitFastQ/Read_Pairs
      Label_Version: Internal_Settings/Label_Version
      Read_Filter_Off: Internal_Settings/Read_Filter_Off
    out:
    - Filter_Metrics
    - R1
    - R2
    - output
    scatter:
    - Read_Pairs
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
    run: AnnotateR2.cwl
    in:
      R2: QualityFilter/R2
      Index: CheckReference/Index
      Extra_Seqs: Extra_Seqs
    out:
    - Annot_R2
    - R2_Bam
    - GTF
    - Full_Genes
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
      Extra_Seqs: Extra_Seqs
      Bam_Input: Bam_Input
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
    - output
  AnnotateMolecules:
    requirements:
      ResourceRequirement:
        ramMin: 16000
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
      Full_Genes: AnnotateR2/Full_Genes
      Putative_Cell_Call: Internal_Settings/Putative_Cell_Call
      Tag_Names: Multiplexing_Settings/Tag_Sample_Names
    out:
    - Annot_Files
    - Cell_Label_Filter
    - Data_Tables
    - Data_Tables_Unfiltered
    - Expression_Data
    - Expression_Data_Unfiltered
    - MI_Adjusted_Stats
    - Putative_Cells_Origin
    - Trueno_out
    - output
  AddtoSam:
    requirements:
      ResourceRequirement:
        ramMin: 4000
        tmpdirMin: 262144
        outdirMin: 131072
    run: AddtoSam.cwl
    in:
      Data_Tables: GetDataTable/Data_Tables
      Annotation_R1: AnnotateR1/Annotation_R1
      Annot_Files: GetDataTable/Annot_Files
      R2_Bam: AnnotateR2/R2_Bam
    out:
    - Annotated_Bam
    - output
    scatter:
    - R2_Bam
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
      Seq_Run: Internal_Settings/Seq_Run
    out:
    - Metrics_Summary
    - Metrics_Archive
    - Final_Bam
    - output
  ClusterAnalysis:
    run: ClusteringAnalysis.cwl
    in:
      Data_Table: GetDataTable/Expression_Data
    out:
    - Clustering_Analysis
    - output
  MakeLogsArchive:
    run: MakeLogsArchive.cwl
    in:
      log_files:
        source:
        - AnnotateReads/output
        - AnnotateR1/output
        - AnnotateR2/output
        - CheckReference/output
        - ClusterAnalysis/output
        - GetDataTable/output
        - Metrics/output
        - SplitFastQ/output
        - AddtoSam/output
        - AnnotateMolecules/output
        - QualityFilter/output
        linkMerge: merge_flattened
    out:
    - logs_tarball
