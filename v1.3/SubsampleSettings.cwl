cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
stdout: Settings.log
requirements:
- class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
arguments:
- position: 0
  valueFrom: Subsampling Settings Dispatched Successfully
inputs:
  _Subsample_Reads:
    type: float?
  _Subsample_Seed:
    type: float?
outputs:
  Subsample_Reads:
    type: float?
    outputBinding:
      outputEval: $(inputs._Subsample_Reads)
  Subsample_Seed:
    type: float?
    outputBinding:
      outputEval: $(inputs._Subsample_Seed)
