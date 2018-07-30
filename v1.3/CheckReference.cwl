cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.3
baseCommand:
- mist_check_references.py
stdout: CheckReference.log
inputs:
  Reference:
    type: File[]
    inputBinding:
      itemSeparator: ','
      prefix: --reference
  Label_Version:
    type: int?
    inputBinding:
      prefix: --label-version
  AbSeq_Reference:
    type: File[]?
    inputBinding:
      prefix: --abseq-reference
  Sample_Tags_Version:
    type: string?
    inputBinding:
      prefix: --sample-tags-version
  Putative_Cell_Call:
    type: int?
    inputBinding:
      prefix: --putative-cell-call
outputs:
  Index:
    type: File[]
    outputBinding:
      glob: '*-annot.*'
  Extra_Seqs:
    type: File?
    outputBinding:
      glob: '*concatenated_sup.fasta'
  Reference_Panel_Names:
    type: File
    outputBinding:
      glob: reference_panel_names.*
  output:
    type: File
    outputBinding:
      glob: '*.log'
