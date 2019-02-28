$namespaces:
  arv: http://arvados.org/cwl#
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
  arv:RuntimeConstraints:
    outputDirType: keep_output_dir
requirements:
- class: InlineJavascriptRequirement
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gunzip
arguments:
- position: 0
  valueFrom: '-c'
inputs:
  Compressed_File:
    type: File
    inputBinding:
      position: 1
stdout: $(inputs.Compressed_File.nameroot)
outputs:
  Uncompressed_File:
    type: File
    outputBinding:
      glob: $(inputs.Compressed_File.nameroot)