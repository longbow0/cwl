requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
  InlineJavascriptRequirement: {}
doc: >
  CheckFastqs does several quality control routines including: (1) ensuring that read
  pair file names are formatted correctly and contain a read pair mate; (2) disambiguating
  the "Subsample Reads" input and; (3) if not provided, generating a subsampling seed
  that the downstream instances can use.
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_check_fastqs.py
inputs:
  Reads:
    type: File[]
    inputBinding:
      prefix: --reads
      itemSeparator: ','
  Subsample:
    type: float?
    inputBinding:
      prefix: --subsample
  UserInputSubsampleSeed:
    type: int?
    inputBinding:
      prefix: --subsample-seed
  MinChunkSize:
    type: int?
    inputBinding:
      prefix: --min-split-size
    doc: >
      The minimum size (megabytes) of a file that should get split into chunks of
      a size designated in NumRecordsPerSplit
outputs:
  SubsamplingRatio:
    type: float
    outputBinding:
      glob: subsampling_info.json
      loadContents: true
      outputEval: |
        $(JSON.parse(self[0].contents).subsampling_ratio)
  SubsampleSeed:
    type: int
    outputBinding:
      glob: subsampling_info.json
      loadContents: true
      outputEval: |
        $(JSON.parse(self[0].contents).subsampling_seed)
  FilesToSkipSplitAndSubsample:
    type: string[]
    outputBinding:
      glob: files_to_skip_split_and_subsample.json
      loadContents: true
      outputEval: |
        $(JSON.parse(self[0].contents).files_to_skip_split_and_subsample)
  log:
    type: File
    outputBinding:
      glob: '*.log'
