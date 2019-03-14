requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
  InlineJavascriptRequirement: {}
$namespaces:
  arv: http://arvados.org/cwl#
hints:
- class: "arv:RuntimeConstraints"
  keep_cache: 512
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_annotate_reads.py
inputs:
  R1_Annotation:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --annotR1
  R2_Annotation:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --annotR2
  Filter_Metrics:
    type:
      items:
      - 'null'
      - File
      type: array
    inputBinding:
      itemSeparator: ','
      prefix: --filtering-stats
  Bam_Input:
    type: File[]?
    inputBinding:
      prefix: --bam-input
  Sample_Tags_Version:
    type: string?
    inputBinding:
      prefix: --sample-tags-version
  Subsample_Tags:
    type: float?
    inputBinding:
      prefix: --subsample-tags
  Index:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --index
  Label_Version:
    type: int?
    inputBinding:
      prefix: --label-version
  Extra_Seqs:
    type: File?
    inputBinding:
      itemSeparator: ','
      prefix: --extra-seqs
  Reference_Panel_Names:
    type: File
    inputBinding:
      prefix: --reference-panel-names
  Putative_Cell_Call:
    type: int?
    inputBinding:
      prefix: --putative-cell-call
  R2_Quality_Metrics:
    type: File[]
    inputBinding:
      prefix: --r2-quality-metrics
      itemSeparator: ','
  AbSeq_UMI:
    type: int?
    inputBinding:
      prefix: --umi-option
outputs:
  Seq_Metrics:
    type: File
    outputBinding:
      glob: "*_SeqMetrics.csv.gz"

  Valid_Reads:
    type: File[]
    outputBinding:
      glob: '*Sorted_Valid_Reads.csv.*'
  Annotation_Read:
    type: File
    outputBinding:
      glob: "*_Annotation_Read.csv.gz"
  output:
    type: File
    outputBinding:
      glob: '*.log'
  Is_Trueno:
    type: boolean
    outputBinding:
      loadContents: true
      glob: metadata.json
      outputEval: $(JSON.parse(self[0].contents).is_trueno)
  Sample_Name:
    type: string
    outputBinding:
      loadContents: true
      glob: metadata.json
      outputEval: $(JSON.parse(self[0].contents).sample)