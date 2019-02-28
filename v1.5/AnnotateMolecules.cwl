requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
$namespaces:
  arv: http://arvados.org/cwl#
hints:
  arv:RuntimeConstraints:
    keep_cache: 512
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_annotate_molecules.py
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
      prefix: --umi-option
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
