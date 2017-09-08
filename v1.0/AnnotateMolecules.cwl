#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_annotate_molecules.py]
stdout: $(inputs.Valids.basename.split('.')[2]).AnnotateMolecules.log

inputs:

  Valids:
    type: File
    inputBinding:
      separate: true
      prefix: --valid-annot
      position: 1

outputs:

  Gene_Status_List:
    type: File
    outputBinding:
      glob: "*_GeneStatus.csv.*"

  Mol_Annot_List:
    type: File
    outputBinding:
      glob: "*_Annotation_Molecule.csv.*"

  output:
    type: stdout

