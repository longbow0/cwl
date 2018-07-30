cwlVersion: v1.0
class: CommandLineTool
baseCommand: echo
stdout: InternalSettings.log
requirements:
- class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
arguments:
- position: 0
  valueFrom: Internal Settings Dispatched Successfully
inputs: []
outputs:
  Label_Version:
    type: int?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Label_Version')) { return inputs._Label_Version
        } else { return null } }
  Read_Filter_Off:
    type: boolean?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Read_Filter_Off')) { return inputs._Read_Filter_Off
        } else { return null } }
  Barcode_Num:
    type: int?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Barcode_Num')) { return inputs._Barcode_Num
        } else { return null } }
  Seq_Run:
    type: string?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Seq_Run')) { return inputs._Seq_Run
        } else { return null } }
  AbSeq_UMI:
    type: int?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_AbSeq_UMI')) { return inputs._AbSeq_UMI
        } else { return null } }
  Putative_Cell_Call:
    type: int?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Putative_Cell_Call')) { return inputs._Putative_Cell_Call
        } else { return null } }
  Use_DBEC:
    type: boolean?
    outputBinding:
      outputEval: ${ if (inputs.hasOwnProperty('_Use_DBEC')) { return inputs._Use_DBEC
        } else { return true } }
