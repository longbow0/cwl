cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_annotate_R1.py
stdout: AnnotateR1.log
inputs:
  R1:
    type: File
    inputBinding:
      prefix: --R1
  Label_Version:
    type: int?
    inputBinding:
      prefix: --label-version
outputs:
  Annotation_R1:
    type: File
    outputBinding:
      glob: '*_Annotation_R1.csv'
  output:
    type: File
    outputBinding:
      glob: '*.log'
