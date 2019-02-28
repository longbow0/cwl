requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
  InlineJavascriptRequirement: {}
cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mist_check_references.py
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
      glob: "*-annot.*"
      outputEval: |
        ${
            if (self.length == 1) { // Targeted
                return self;
            } else if (self.length == 0){ // WTA
                return inputs.Reference;
            }
        }
  Extra_Seqs:
    type: File?
    outputBinding:
      glob: '*concatenated_sup.fasta'
  Reference_Panel_Names:
    type: File
    outputBinding:
      glob: reference_panel_names.json
  output:
    type: File
    outputBinding:
      glob: '*.log'
  Full_Genes:
    type: File?
    outputBinding:
      glob: full-gene-list.json
