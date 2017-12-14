#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:v1.02

baseCommand: [mist_annotate_R2.py]
stdout: $(inputs.R2.nameroot.split('.')[0]).AnnotateR2.log

inputs:

  R2: 
    type: File
    inputBinding:
      prefix: --R2

  Index:
    type: File
    inputBinding:
      prefix: --index

  Annotation:
    type: File?
    inputBinding:
      prefix: --annotation

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

