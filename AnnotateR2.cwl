#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: mist

baseCommand: [mist_annotate_R2.py]
stdout: output.txt

inputs:

  R2: 
    type: File
    inputBinding:
      separate: true
      prefix: --R2
      position: 1

  Alignment_length:
    type: int?
    inputBinding:
      separate: true
      prefix: --alignment-length
      position: 2

  Label_version:
    type: int?
    inputBinding:
      separate: true
      prefix: --label-version
      position: 3

  Index:
    type: File
    inputBinding:
      separate: true
      prefix: --index
      position: 4

  Annotation:
    type: File?
    inputBinding:
      separate: true
      prefix: --annotation
      position: 5

  Extra_seqs:
    type: File?
    inputBinding:
      separate: true
      prefix: --extra-seqs
      position: 6
  
outputs:

  Annot_R2:
    type: File
    outputBinding:
      glob: "*Annotation_R2.csv"

  R2_bam:
    type: File
    outputBinding:
      glob: "*mapping_R2.BAM"

  GTF:
    type: File?
    outputBinding:
      glob: "*-annot.gtf"

  Full_genes:
      type: File?
      outputBinding:
        glob: "*gene-list.txt"
  output:
    type: stdout
