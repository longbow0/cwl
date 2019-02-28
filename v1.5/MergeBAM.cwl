requirements:
  DockerRequirement:
    dockerPull: bdgenomics/rhapsody:1.5
  InlineJavascriptRequirement: {}
hints:
  ResourceRequirement:
    coresMin: 4
  arv:RuntimeConstraints:
    outputDirType: keep_output_dir
$namespaces:
  arv: http://arvados.org/cwl#
class: CommandLineTool
cwlVersion: v1.0
baseCommand:
- samtools
- merge
stdout: samtools_merge.log
inputs:
  BamFiles:
    type: File[]
    inputBinding:
      position: 1
  Is_Trueno:
    type: boolean
  Sample_Name:
    type: string
arguments:
- prefix: -@
  valueFrom: $(runtime.cores)
- position: 0
  valueFrom: |-
    ${
        if (inputs.Is_Trueno) {
            return "Combined_" + inputs.Sample_Name + "_final.BAM"
        } else {
            return inputs.Sample_Name + "_final.BAM"
        }
    }
outputs:
  Final_Bam:
    type: File
    outputBinding:
      glob: '*_final.BAM'
  log:
    type: File
    outputBinding:
      glob: '*.log'
