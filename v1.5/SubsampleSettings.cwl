cwlVersion: v1.0
class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
inputs:
  _Subsample_Reads:
    type: float?
  _Subsample_Seed:
    type: int?
outputs:
  Subsample_Reads:
    type: float?
  Subsample_Seed:
    type: int?
expression: |-
  ${
    var subsamplingOutputs = {
      Subsample_Reads: inputs._Subsample_Reads,
      Subsample_Seed: inputs._Subsample_Seed
    }
    return subsamplingOutputs;
  }
