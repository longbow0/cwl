cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_split_fastqs.py
stdout: SplitFastQ.log
inputs:
  Reads:
    type: File[]
    inputBinding:
      prefix: --reads
      itemSeparator: ','
  Label_Version:
    type: int?
    inputBinding:
      prefix: --label-version
  Subsample:
    type: float?
    inputBinding:
      prefix: --subsample
  Subsample_seed:
    type: float?
    inputBinding:
      prefix: --subsample-seed
outputs:
  Read_Pairs:
    type: File[]
    outputBinding:
      glob: '*.tar.gz'
  output:
    type: File
    outputBinding:
      glob: '*.log'
