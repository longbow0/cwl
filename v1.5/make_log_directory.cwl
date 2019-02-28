cwlVersion: v1.0
class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
- class: MultipleInputFeatureRequirement
inputs:
  log_files: File[]
outputs:
  logs_out_dir: Directory
expression: |-
  ${
    return {"logs_out_dir": {
      "class": "Directory",
      "basename": "Logs",
      "listing": inputs.log_files
    } };
  }
