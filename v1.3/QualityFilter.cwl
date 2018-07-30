cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_quality_filter.py
stdout: QualityFilter.log
inputs:
  Read_Pairs:
    type: File
    inputBinding:
      prefix: --read-pairs
      itemSeparator: ','
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
      glob: '*_R1_*.fastq.gz'
  R2:
    type: File
    outputBinding:
      glob: '*_R2_*.fastq.gz'
  Filter_Metrics:
    type: File?
    outputBinding:
      glob: '*read_quality.csv'
  output:
    type: File
    outputBinding:
      glob: '*.log'
