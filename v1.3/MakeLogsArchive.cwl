cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- tar
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
arguments:
- position: 0
  prefix: cvzf
  valueFrom: logs.tar.gz
inputs:
  log_files:
    type: File[]
    inputBinding:
      position: 1
outputs:
  logs_tarball:
    type: File
    outputBinding:
      glob: logs.tar.gz
