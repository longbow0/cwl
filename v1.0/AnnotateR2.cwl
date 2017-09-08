#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody

baseCommand: [mist_annotate_R2.py]
stdout: $(inputs.R2.nameroot.split('.')[0]).AnnotateR2.log

inputs:

  R2: 
    type: File
    inputBinding:
      separate: true
      prefix: --R2
      position: 1

  Index:
    type: File
    inputBinding:
      separate: true
      prefix: --index
      position: 2

  Annotation:
    type: File?
    inputBinding:
      separate: true
      prefix: --annotation
      position: 3


outputs:

  Annot_R2:
    type: File
    outputBinding:
      glob: "*Annotation_R2.csv"

  R2_Bam:
    type: File
    outputBinding:
      glob: "*mapping_R2.BAM"

  Full_Genes:
      type: File?
      outputBinding:
        glob: "*gene-list.txt"

  output:
    type: stdout

