requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
cwlVersion: v1.0
class: CommandLineTool
$namespaces:
  arv: "http://arvados.org/cwl#"
  sbg: "https://sevenbridges.com"
hints:
- class: "arv:RuntimeConstraints"
  keep_cache: 512
- class: "sbg:AWSInstanceType"
  value: "c5.18xlarge"
baseCommand:
- mist_annotate_R1.py
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
      glob: "*_Annotation_R1.csv.gz"
  output:
    type: File
    outputBinding:
      glob: '*.log'
