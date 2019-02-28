# Defaults (when a value is not specified):
#   Label_Version: 2 (9mer)
#   Barcode_Num: 65536 (number of unique UMIs)
#   AbSeq_UMI: 1 (use AbUMI for RSEC, if both BeadUMI and AbUMI are available)
#   Putative_Cell_Call: 0 (mRNA only)
#   Seq_Run: false
#   Use_DBEC: true
#   Read_Filter_Off: false
cwlVersion: v1.0
class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
inputs: []
outputs:
  Label_Version:
    type: int?
  Read_Filter_Off:
    type: boolean?
  Barcode_Num:
    type: int?
  Seq_Run:
    type: string?
  AbSeq_UMI:
    type: int?
  Putative_Cell_Call:
    type: int?
  Use_DBEC:
    type: boolean?
  Extra_Seqs:
    type: File?
  MinChunkSize:
    type: int?
  NumRecordsPerSplit:
    type: int?
expression: |-
  ${
    var internalInputs = [
      '_Label_Version',
      '_Read_Filter_Off',
      '_Barcode_Num',
      '_Seq_Run',
      '_AbSeq_UMI',
      '_Putative_Cell_Call',
      '_Use_DBEC',
      '_Extra_Seqs',
      '_MinChunkSize',
      '_NumRecordsPerSplit',
    ];
    var internalOutputs = {}
    for (var i = 0; i < internalInputs.length; i++) {
      var internalInput = internalInputs[i];
      var internalOutput = internalInput.slice(1); // remove leading underscore
      if (inputs.hasOwnProperty(internalInput)) {
        internalOutputs[internalOutput] = inputs[internalInput]; // if input specified, redirect to output
      } else {
        internalOutputs[internalOutput] = null; // if input not specified, provide a null
      }
    }
    return internalOutputs;
  }
