cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_annotate_molecules.py
stdout: AnnotateMolecules.log
inputs:
  Valids:
    type: File
    inputBinding:
      prefix: --valid-annot
  Barcode_Num:
    type: int?
    inputBinding:
      prefix: --num-bc
  Use_DBEC:
    type: boolean?
    inputBinding:
      prefix: --use-dbec
  AbSeq_UMI:
    type: int?
    inputBinding:
      prefix: --abseq-umi
outputs:
  Gene_Status_List:
    type: File
    outputBinding:
      glob: '*_GeneStatus.csv.*'
  Mol_Annot_List:
    type: File
    outputBinding:
      glob: '*_Annotation_Molecule.csv.*'
  output:
    type: File
    outputBinding:
      glob: '*.log'
