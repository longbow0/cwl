requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
cwlVersion: v1.0
class: CommandLineTool
$namespaces:
  arv: "http://arvados.org/cwl#"
  sbg: "https://sevenbridges.com"
hints:
- class: "arv:RuntimeConstraints"
  keep_cache: 512
- class: "sbg:AWSInstanceType"
  value: "c5.18xlarge"
baseCommand:
- mist_quality_filter.py
inputs:
  Split_Read_Pairs:
    type:
      type: record
      fields:
      - name: R1
        type: File
        inputBinding:
          prefix: --r1
      - name: R2
        type: File
        inputBinding:
          prefix: --r2
      - name: readPairID
        type: int
        inputBinding:
          prefix: --read-pair-id
      - name: library
        type: string
        inputBinding:
          prefix: --library
  Label_Version:
    type: int?
    inputBinding:
      prefix: --label-version
  Read_Filter_Off:
    type: boolean?
    inputBinding:
      prefix: --read-filter-off
outputs:
  R1:
    type: File
    outputBinding:
      glob: '*_R1_.fastq.gz'
  R2:
    type: File
    outputBinding:
      glob: '*_R2_.fastq.gz'
  Filter_Metrics:
    type: File?
    outputBinding:
      glob: "*read_quality.csv.gz"
  output:
    type: File
    outputBinding:
      glob: '*.log'
