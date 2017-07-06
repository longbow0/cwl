#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_annotate_molecules.py]
stdout: molecules.log

inputs:

  Valids:
    type: File
    inputBinding:
      separate: true
      prefix: --valid-annot
      position: 1

  Barcode_num:
    type: int?
    inputBinding:
      separate: true
      prefix: --num-bc
      position: 2

outputs:

  Gene_status_list:
    type: File
    outputBinding:
      glob: "*_GeneStatus.csv.*"

  molAnnot_list:
    type: File
    outputBinding:
      glob: "*_Annotation_Molecule.csv.*"

  output:
    type: stdout 
