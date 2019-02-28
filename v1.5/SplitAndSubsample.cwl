doc: >
  SplitAndSubsample splits, subsamples and formats read files to be deposited in QualityFilter.
cwlVersion: v1.0
class: Workflow
$namespaces:
  arv: http://arvados.org/cwl#
requirements:
- class: ScatterFeatureRequirement
- class: InlineJavascriptRequirement
inputs:
  Fastqs:
    type: File[]
  SubsampleSeed:
    type: int
  SubsampleRatio:
    type: float
  NumRecordsPerSplit:
    type: int?
  FilesToSkipSplitAndSubsample:
    type: string[]
outputs:
  SplitAndSubsampledFastqs:
    type: File[]
    outputSource: FlattenOutput/SplitFastqList
  log:
    type: File[]
    outputSource: SplitAndSubsample/log
steps:
  SplitAndSubsample:
    doc: Allocate one docker/python process per file to do the actual file splitting.
    in:
      Fastq: Fastqs
      SubsampleSeed: SubsampleSeed
      SubsampleRatio: SubsampleRatio
      NumRecordsPerSplit: NumRecordsPerSplit
      FilesToSkipSplitAndSubsample: FilesToSkipSplitAndSubsample
    scatter:
    - Fastq
    out:
    - SplitAndSubsampledFastqs
    - log
    run:
      id: split_fastq
      class: CommandLineTool
      cwlVersion: v1.0
      hints:
        arv:RuntimeConstraints:
          outputDirType: keep_output_dir
      requirements:
        DockerRequirement:
          dockerPull: bdgenomics/rhapsody:1.5
      baseCommand:
      - mist_split_fastq.py
      inputs:
        Fastq:
          type: File
          inputBinding:
            prefix: --fastq-file-path
        SubsampleSeed:
          type: int
          inputBinding:
            prefix: --subsample-seed
        SubsampleRatio:
          type: float
          inputBinding:
            prefix: --subsample-ratio
        NumRecordsPerSplit:
          type: int?
          inputBinding:
            prefix: --num-records
        FilesToSkipSplitAndSubsample:
          type: string[]
          inputBinding:
            prefix: --files-to-skip-split-and-subsample
            itemSeparator: ','
      outputs:
        SplitAndSubsampledFastqs:
          type: File[]
          outputBinding:
            glob: '*.fastq.gz'
            outputEval: ${ if (self.length === 0) { return [inputs.Fastq]; } else
              { return self; } }
        log:
          type: File
          outputBinding:
            glob: '*.log'
  FlattenOutput:
    doc: After scattering "SplitAndSubsample" on a File array, the output of each
      node is also an array. Thus, we are left with a nestled list. This JS expression
      flattens this list to deal with the split reads in PairReadFiles.cwl
    in:
      nestledSplitFastqList: SplitAndSubsample/SplitAndSubsampledFastqs
    out:
    - SplitFastqList
    run:
      id: flatten_output
      cwlVersion: v1.0
      class: ExpressionTool
      inputs:
        nestledSplitFastqList:
          type:
            type: array
            items:
              type: array
              items: File
      outputs:
        SplitFastqList:
          type: File[]
      expression: |
        ${
          return {SplitFastqList: [].concat.apply([], inputs.nestledSplitFastqList)}
        }
