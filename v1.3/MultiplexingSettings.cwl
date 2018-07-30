cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
stdout: MultiplexingSettings.log
requirements:
- class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
arguments:
- position: 0
  valueFrom: Multiplexing Settings Dispatched Successfully
inputs:
  _Subsample_Tags:
    type: float?
  _Tag_Sample_Names:
    type: string[]?
  _Sample_Tags_Version:
    type: Any?
outputs:
  Subsample_Tags:
    type: float?
    outputBinding:
      outputEval: $(inputs._Subsample_Tags)
  Tag_Sample_Names:
    type: string[]?
    outputBinding:
      outputEval: $(inputs._Tag_Sample_Names)
  Sample_Tags_Version:
    type: string?
    outputBinding:
      outputEval: "${\n  if (inputs._Sample_Tags_Version) {\n    if (inputs._Sample_Tags_Version.toLowerCase().indexOf('human')\
        \ >= 0) {\n      return('hs');\n    } if (inputs._Sample_Tags_Version.toLowerCase().indexOf('mouse')\
        \ >= 0) {\n      return('mm');\n    } if (inputs._Sample_Tags_Version == 'No\
        \ Multiplexing') {\n      return(null);\n    } else {\n      return(inputs._Sample_Tags_Version);\n\
        \    }\n  } else {\n    return(null);\n  }\n}\n"
