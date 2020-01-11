#!/usr/bin/env cwl-runner
{
    "$graph": [
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "hints": [
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "r4.16xlarge"
                }
            ],
            "baseCommand": [
                "mist_add_to_bam.py"
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--annot-r1"
                    },
                    "id": "#AddtoBam.cwl/Annotation_R1"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--data-tables"
                    },
                    "id": "#AddtoBam.cwl/Data_Tables"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--annot-mol-file"
                    },
                    "id": "#AddtoBam.cwl/Molecular_Annotation"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--r2-bam"
                    },
                    "id": "#AddtoBam.cwl/R2_Bam"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    },
                    "id": "#AddtoBam.cwl/Seq_Metrics"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--tag-calls"
                    },
                    "id": "#AddtoBam.cwl/Tag_Calls"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "Annotated_mapping_R2.BAM"
                    },
                    "id": "#AddtoBam.cwl/Annotated_Bam"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#AddtoBam.cwl/output"
                }
            ],
            "id": "#AddtoBam.cwl",
            "$namespaces": {
                "sbg": "https://sevenbridges.com"
            }
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "hints": [
                {
                    "keep_cache": 512,
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_annotate_molecules.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--umi-option"
                    },
                    "id": "#AnnotateMolecules.cwl/AbSeq_UMI"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--num-bc"
                    },
                    "id": "#AnnotateMolecules.cwl/Barcode_Num"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--use-dbec"
                    },
                    "id": "#AnnotateMolecules.cwl/Use_DBEC"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--valid-annot"
                    },
                    "id": "#AnnotateMolecules.cwl/Valids"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_GeneStatus.csv.*"
                    },
                    "id": "#AnnotateMolecules.cwl/Gene_Status_List"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_Annotation_Molecule.csv.*"
                    },
                    "id": "#AnnotateMolecules.cwl/Mol_Annot_List"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#AnnotateMolecules.cwl/output"
                }
            ],
            "id": "#AnnotateMolecules.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "hints": [
                {
                    "class": "http://arvados.org/cwl#RuntimeConstraints",
                    "keep_cache": 512
                },
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "c5.18xlarge"
                }
            ],
            "baseCommand": [
                "mist_annotate_R1.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--label-version"
                    },
                    "id": "#AnnotateR1.cwl/Label_Version"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--R1"
                    },
                    "id": "#AnnotateR1.cwl/R1"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_Annotation_R1.csv.gz"
                    },
                    "id": "#AnnotateR1.cwl/Annotation_R1"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#AnnotateR1.cwl/output"
                }
            ],
            "id": "#AnnotateR1.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "envDef": [
                        {
                            "envValue": "$(String(runtime.cores))",
                            "envName": "CORES_ALLOCATED_PER_CWL_PROCESS"
                        }
                    ],
                    "class": "EnvVarRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "class": "http://arvados.org/cwl#RuntimeConstraints",
                    "keep_cache": 512
                },
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "c5.18xlarge"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_annotate_R2.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--extra-seqs"
                    },
                    "id": "#AnnotateR2.cwl/Extra_Seqs"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--index"
                    },
                    "id": "#AnnotateR2.cwl/Index"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--R2"
                    },
                    "id": "#AnnotateR2.cwl/R2"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--vdj-version"
                    },
                    "id": "#AnnotateR2.cwl/VDJ_Version"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*Annotation_R2.csv.gz"
                    },
                    "id": "#AnnotateR2.cwl/Annot_R2"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*-annot.gtf"
                    },
                    "id": "#AnnotateR2.cwl/GTF"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*mapping_R2.BAM"
                    },
                    "id": "#AnnotateR2.cwl/R2_Bam"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_picard_quality_metrics.csv.gz"
                    },
                    "id": "#AnnotateR2.cwl/R2_Quality_Metrics"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#AnnotateR2.cwl/output"
                }
            ],
            "id": "#AnnotateR2.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "class": "http://arvados.org/cwl#RuntimeConstraints",
                    "keep_cache": 512
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_annotate_reads.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--umi-option"
                    },
                    "id": "#AnnotateReads.cwl/AbSeq_UMI"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--bam-input"
                    },
                    "id": "#AnnotateReads.cwl/Bam_Input"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--extra-seqs"
                    },
                    "id": "#AnnotateReads.cwl/Extra_Seqs"
                },
                {
                    "type": {
                        "items": [
                            "null",
                            "File"
                        ],
                        "type": "array"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--filtering-stats"
                    },
                    "id": "#AnnotateReads.cwl/Filter_Metrics"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--index"
                    },
                    "id": "#AnnotateReads.cwl/Index"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--label-version"
                    },
                    "id": "#AnnotateReads.cwl/Label_Version"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    },
                    "id": "#AnnotateReads.cwl/Putative_Cell_Call"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--annotR1"
                    },
                    "id": "#AnnotateReads.cwl/R1_Annotation"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--annotR2"
                    },
                    "id": "#AnnotateReads.cwl/R2_Annotation"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "prefix": "--r2-quality-metrics",
                        "itemSeparator": ","
                    },
                    "id": "#AnnotateReads.cwl/R2_Quality_Metrics"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--reference-panel-names"
                    },
                    "id": "#AnnotateReads.cwl/Reference_Panel_Names"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--sample-tags-version"
                    },
                    "id": "#AnnotateReads.cwl/Sample_Tags_Version"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--subsample-tags"
                    },
                    "id": "#AnnotateReads.cwl/Subsample_Tags"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--vdj-version"
                    },
                    "id": "#AnnotateReads.cwl/VDJ_Version"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_Annotation_Read.csv.gz"
                    },
                    "id": "#AnnotateReads.cwl/Annotation_Read"
                },
                {
                    "type": "boolean",
                    "outputBinding": {
                        "loadContents": true,
                        "glob": "metadata.json",
                        "outputEval": "$(JSON.parse(self[0].contents).is_trueno)"
                    },
                    "id": "#AnnotateReads.cwl/Is_Trueno"
                },
                {
                    "type": "string",
                    "outputBinding": {
                        "loadContents": true,
                        "glob": "metadata.json",
                        "outputEval": "$(JSON.parse(self[0].contents).sample)"
                    },
                    "id": "#AnnotateReads.cwl/Sample_Name"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_SeqMetrics.csv.gz"
                    },
                    "id": "#AnnotateReads.cwl/Seq_Metrics"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "*Sorted_Valid_Reads.csv.*"
                    },
                    "id": "#AnnotateReads.cwl/Valid_Reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "metadata.json"
                    },
                    "id": "#AnnotateReads.cwl/metadata"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#AnnotateReads.cwl/output"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_IG_Valid_Reads.fasta.gz"
                    },
                    "id": "#AnnotateReads.cwl/validIgReads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_TCR_Valid_Reads.fasta.gz"
                    },
                    "id": "#AnnotateReads.cwl/validTcrReads"
                }
            ],
            "id": "#AnnotateReads.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#BundleLogs.cwl/log_files"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#BundleLogs.cwl/logs_dir"
                }
            ],
            "expression": "${\n  /* shamelly cribbed from https://gist.github.com/jcxplorer/823878 */\n  function uuid() {\n    var uuid = \"\", i, random;\n    for (i = 0; i < 32; i++) {\n      random = Math.random() * 16 | 0;\n      if (i == 8 || i == 12 || i == 16 || i == 20) {\n        uuid += \"-\";\n      }\n      uuid += (i == 12 ? 4 : (i == 16 ? (random & 3 | 8) : random)).toString(16);\n    }\n    return uuid;\n  }\n  var listing = [];\n  for (var i = 0; i < inputs.log_files.length; i++) {\n    var log_file = inputs.log_files[i];\n    log_file.basename = uuid() + \"-\" + log_file.basename;\n    listing.push(log_file);\n  }\n  return ({\n    logs_dir: {\n      class: \"Directory\",\n      basename: \"Logs\",\n      listing: listing\n    }\n  });\n}",
            "id": "#BundleLogs.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_cell_classifier.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#Cell_Classifier.cwl/molsPerCellMatrix"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*cell_type_experimental.csv"
                    },
                    "id": "#Cell_Classifier.cwl/cellTypePredictions"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#Cell_Classifier.cwl/log"
                }
            ],
            "id": "#Cell_Classifier.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "doc": "CheckFastqs does several quality control routines including: (1) ensuring that read pair file names are formatted correctly and contain a read pair mate; (2) disambiguating the \"Subsample Reads\" input and; (3) if not provided, generating a subsampling seed that the downstream instances can use.\n",
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_check_fastqs.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--min-split-size"
                    },
                    "doc": "The minimum size (megabytes) of a file that should get split into chunks of a size designated in NumRecordsPerSplit\n",
                    "id": "#CheckFastqs.cwl/MinChunkSize"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "prefix": "--reads",
                        "itemSeparator": ","
                    },
                    "id": "#CheckFastqs.cwl/Reads"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--subsample"
                    },
                    "id": "#CheckFastqs.cwl/Subsample"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--subsample-seed"
                    },
                    "id": "#CheckFastqs.cwl/UserInputSubsampleSeed"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "outputBinding": {
                        "glob": "files_to_skip_split_and_subsample.json",
                        "loadContents": true,
                        "outputEval": "$(JSON.parse(self[0].contents).files_to_skip_split_and_subsample)\n"
                    },
                    "id": "#CheckFastqs.cwl/FilesToSkipSplitAndSubsample"
                },
                {
                    "type": "int",
                    "outputBinding": {
                        "glob": "subsampling_info.json",
                        "loadContents": true,
                        "outputEval": "$(JSON.parse(self[0].contents).subsampling_seed)\n"
                    },
                    "id": "#CheckFastqs.cwl/SubsampleSeed"
                },
                {
                    "type": "float",
                    "outputBinding": {
                        "glob": "subsampling_info.json",
                        "loadContents": true,
                        "outputEval": "$(JSON.parse(self[0].contents).subsampling_ratio)\n"
                    },
                    "id": "#CheckFastqs.cwl/SubsamplingRatio"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#CheckFastqs.cwl/log"
                }
            ],
            "id": "#CheckFastqs.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_check_references.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--abseq-reference"
                    },
                    "id": "#CheckReference.cwl/AbSeq_Reference"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--label-version"
                    },
                    "id": "#CheckReference.cwl/Label_Version"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    },
                    "id": "#CheckReference.cwl/Putative_Cell_Call"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--reference"
                    },
                    "id": "#CheckReference.cwl/Reference"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--sample-tags-version"
                    },
                    "id": "#CheckReference.cwl/Sample_Tags_Version"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--vdj-version"
                    },
                    "id": "#CheckReference.cwl/VDJ_Version"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "combined_extra_seq.fasta"
                    },
                    "id": "#CheckReference.cwl/Extra_Seqs"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "full-gene-list.json"
                    },
                    "id": "#CheckReference.cwl/Full_Genes"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "*-annot.*",
                        "outputEval": "${\n    if (self.length == 1) { // Targeted\n        return self;\n    } else if (self.length == 0){ // WTA\n        return inputs.Reference;\n    }\n}\n"
                    },
                    "id": "#CheckReference.cwl/Index"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "reference_panel_names.json"
                    },
                    "id": "#CheckReference.cwl/Reference_Panel_Names"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#CheckReference.cwl/output"
                }
            ],
            "id": "#CheckReference.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#FilteredDataTables.cwl/Dense_DataTables"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#FilteredDataTables.cwl/Dense_DataTables_Unfiltered"
                }
            ],
            "outputs": [
                {
                    "id": "#FilteredDataTables.cwl/Data_Tables",
                    "type": {
                        "type": "array",
                        "items": "File"
                    }
                }
            ],
            "expression": "${\n  var keep_datatable = [];\n  if (inputs.Dense_DataTables_Unfiltered.length > 2) {\n    return {'Data_Tables': inputs.Dense_DataTables};\n  }\n  for (var i = 0; i < inputs.Dense_DataTables.length; i++) {\n    if (inputs.Dense_DataTables[i].basename.indexOf('RSEC') !== -1) {\n      keep_datatable.push(inputs.Dense_DataTables[i]);\n    }\n  }\n  return {'Data_Tables': keep_datatable};\n}",
            "id": "#FilteredDataTables.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "hints": [
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "r5.2xlarge"
                }
            ],
            "baseCommand": [
                "mist_get_datatables.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--basic-algo-only"
                    },
                    "id": "#GetDataTable.cwl/Basic_Algo_Only"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--exact-cell-count"
                    },
                    "id": "#GetDataTable.cwl/Exact_Cell_Count"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--full-gene-list"
                    },
                    "id": "#GetDataTable.cwl/Full_Genes"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--gene-status"
                    },
                    "id": "#GetDataTable.cwl/Gene_Status_List"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--mol-annot"
                    },
                    "id": "#GetDataTable.cwl/Molecule_Annotation_List"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    },
                    "id": "#GetDataTable.cwl/Putative_Cell_Call"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    },
                    "id": "#GetDataTable.cwl/Seq_Metrics"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--tag-names"
                    },
                    "id": "#GetDataTable.cwl/Tag_Names"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "metrics-files.tar.gz"
                    },
                    "id": "#GetDataTable.cwl/Annot_Files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "Cell_Label_Filtering/*.png"
                    },
                    "id": "#GetDataTable.cwl/Cell_Label_Filter"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "cell_order.json"
                    },
                    "id": "#GetDataTable.cwl/Cell_Order"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_Expression_Data.st.gz"
                    },
                    "id": "#GetDataTable.cwl/Expression_Data"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_Expression_Data_Unfiltered.st.gz"
                    },
                    "id": "#GetDataTable.cwl/Expression_Data_Unfiltered"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "gene_list.json"
                    },
                    "id": "#GetDataTable.cwl/Gene_List"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "Annotations/*_Annotation_Molecule.csv.gz"
                    },
                    "id": "#GetDataTable.cwl/Molecular_Annotation"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "Cell_Label_Filtering/*_Putative_Cells_Origin.csv"
                    },
                    "id": "#GetDataTable.cwl/Putative_Cells_Origin"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "*PerCell_Sparse.csv.gz"
                    },
                    "id": "#GetDataTable.cwl/Sparse_Data_Tables"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "*PerCell_Unfiltered_Sparse.csv.gz"
                    },
                    "id": "#GetDataTable.cwl/Sparse_Data_Tables_Unfiltered"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "Annotations/*_Annotation_Molecule_Trueno.csv"
                    },
                    "id": "#GetDataTable.cwl/Tag_Annotation"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "Trueno/*_Calls.csv"
                    },
                    "id": "#GetDataTable.cwl/Tag_Calls"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "Trueno/*"
                    },
                    "id": "#GetDataTable.cwl/Trueno_out"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "Annotations/*_UMI_Adjusted_CellLabel_Stats.csv"
                    },
                    "id": "#GetDataTable.cwl/UMI_Adjusted_CellLabel_Stats"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "Annotations/*_UMI_Adjusted_Stats.csv"
                    },
                    "id": "#GetDataTable.cwl/UMI_Adjusted_Stats"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#GetDataTable.cwl/output"
                }
            ],
            "id": "#GetDataTable.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "outputDirType": "keep_output_dir",
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "samtools",
                "index"
            ],
            "stdout": "samtools_index.log",
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#IndexBAM.cwl/BamFile"
                }
            ],
            "arguments": [
                {
                    "position": 2,
                    "valueFrom": "${\n    return inputs.BamFile.basename + \".bai\"\n}"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.bai"
                    },
                    "id": "#IndexBAM.cwl/Index"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#IndexBAM.cwl/log"
                }
            ],
            "id": "#IndexBAM.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [],
            "outputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#InternalSettings.cwl/AbSeq_UMI"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#InternalSettings.cwl/Barcode_Num"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#InternalSettings.cwl/Extra_Seqs"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#InternalSettings.cwl/Label_Version"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#InternalSettings.cwl/MinChunkSize"
                },
                {
                    "type": [
                        "null",
                        "long"
                    ],
                    "id": "#InternalSettings.cwl/NumRecordsPerSplit"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#InternalSettings.cwl/Putative_Cell_Call"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "id": "#InternalSettings.cwl/Read_Filter_Off"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "id": "#InternalSettings.cwl/Seq_Run"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "id": "#InternalSettings.cwl/Use_DBEC"
                }
            ],
            "expression": "${\n  var internalInputs = [\n    '_Label_Version',\n    '_Read_Filter_Off',\n    '_Barcode_Num',\n    '_Seq_Run',\n    '_AbSeq_UMI',\n    '_Putative_Cell_Call',\n    '_Use_DBEC',\n    '_Extra_Seqs',\n    '_MinChunkSize',\n    '_NumRecordsPerSplit',\n  ];\n  var internalOutputs = {}\n  for (var i = 0; i < internalInputs.length; i++) {\n    var internalInput = internalInputs[i];\n    var internalOutput = internalInput.slice(1); // remove leading underscore\n    if (inputs.hasOwnProperty(internalInput)) {\n      internalOutputs[internalOutput] = inputs[internalInput]; // if input specified, redirect to output\n    } else {\n      internalOutputs[internalOutput] = null; // if input not specified, provide a null\n    }\n  }\n  return internalOutputs;\n}",
            "id": "#InternalSettings.cwl"
        },
        {
            "class": "Workflow",
            "label": "BD Rhapsody\u2122 Targeted Analysis Pipeline",
            "doc": "The BD Rhapsody\u2122 assays are used to create sequencing libraries from single cell transcriptomes.\n\nAfter sequencing, the analysis pipeline takes the FASTQ files and a reference file for gene alignment. The pipeline generates molecular counts per cell, read counts per cell, metrics, and an alignment file.",
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "AbSeq Reference",
                    "id": "#main/AbSeq_Reference"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable Refined Putative Cell Calling",
                    "doc": "Determine putative cells using only the basic algorithm (minimum second derivative along the cumulative reads curve).  The refined algorithm attempts to remove false positives and recover false negatives, but may not be ideal for certain complex mixtures of cell types.  Does not apply if Exact Cell Count is set.",
                    "id": "#main/Basic_Algo_Only"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Exact Cell Count",
                    "doc": "Set a specific number (>=1) of cells as putative, based on those with the highest error-corrected read count",
                    "id": "#main/Exact_Cell_Count"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "Reads",
                    "id": "#main/Reads",
                    "https://sevenbridges.comfileTypes": "FASTQ.GZ, FQ.GZ"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "Reference",
                    "doc": "A fasta file containing the mRNA panel amplicon targets used in the experiment",
                    "id": "#main/Reference"
                },
                {
                    "label": "Sample Tags Version",
                    "doc": "The sample multiplexing kit version.  This option should only be set for a multiplexed experiment.",
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "name": "#main/Sample_Tags_Version/Sample_Tags_Version",
                            "symbols": [
                                "#main/Sample_Tags_Version/Sample_Tags_Version/human",
                                "#main/Sample_Tags_Version/Sample_Tags_Version/hs",
                                "#main/Sample_Tags_Version/Sample_Tags_Version/mouse",
                                "#main/Sample_Tags_Version/Sample_Tags_Version/mm",
                                "#main/Sample_Tags_Version/Sample_Tags_Version/custom"
                            ]
                        }
                    ],
                    "id": "#main/Sample_Tags_Version"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Subsample Reads",
                    "doc": "Any number of reads >1 or a fraction between 0 < n < 1 to indicate the percentage of reads to subsample.\n",
                    "id": "#main/Subsample"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Subsample Sample Tags",
                    "doc": "Any number of reads > 1 or a fraction between 0 < n < 1 to indicate the percentage of tag reads to subsample.\n",
                    "id": "#main/Subsample_Tags"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Subsample Seed",
                    "doc": "For use when replicating a previous subsampling run only. Obtain the seed generated from the log file for the SplitFastQ node.\n",
                    "id": "#main/Subsample_seed"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "label": "Tag Names",
                    "doc": "Specify the Sample Tag number followed by - (hyphen) and a sample name to appear in the output files. For example: 4-Ramos. Do not use the special characters: &, (), [], {}, <>, ?, |\n",
                    "id": "#main/Tag_Names"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "e-value threshold for J gene",
                    "doc": "The e-value threshold for J gene call by IgBlast/PyIR, default is set as 0.001\n",
                    "id": "#main/VDJ_JGene_Evalue"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "e-value threshold for V gene",
                    "doc": "The e-value threshold for V gene call by IgBlast/PyIR, default is set as 0.001\n",
                    "id": "#main/VDJ_VGene_Evalue"
                },
                {
                    "label": "VDJ Species Version",
                    "doc": "The VDJ species and chain types.  This option should only be set for VDJ experiment.",
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#hs",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mm",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#main/VDJ_Version"
                }
            ],
            "outputs": [
                {
                    "label": "Cell Label Filter",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/GetDataTable/Cell_Label_Filter",
                    "id": "#main/Cell_Label_Filter"
                },
                {
                    "label": "Data Tables",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/Uncompress_Datatables/Uncompressed_Data_Tables",
                    "id": "#main/Data_Tables"
                },
                {
                    "label": "Unfiltered Data Tables",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/Sparse_to_Dense_Datatable_Unfiltered/Data_Tables",
                    "id": "#main/Data_Tables_Unfiltered"
                },
                {
                    "label": "Expression Matrix",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/Uncompress_Datatables/Uncompressed_Expression_Matrix",
                    "id": "#main/Expression_Data"
                },
                {
                    "label": "Unfiltered Expression Matrix",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/GetDataTable/Expression_Data_Unfiltered",
                    "id": "#main/Expression_Data_Unfiltered"
                },
                {
                    "label": "Final BAM File",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": [
                        "#main/MergeBAM/Final_Bam",
                        "#main/IndexBAM/Index"
                    ],
                    "id": "#main/Final_Bam"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/CellClassifier/cellTypePredictions",
                    "id": "#main/ImmuneCellClassification(Experimental)"
                },
                {
                    "label": "Pipeline Logs",
                    "type": "Directory",
                    "outputSource": "#main/BundleLogs/logs_dir",
                    "id": "#main/Logs"
                },
                {
                    "label": "Metrics Summary",
                    "type": "File",
                    "outputSource": "#main/Metrics/Metrics_Summary",
                    "id": "#main/Metrics_Summary"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/GetDataTable/Trueno_out",
                    "id": "#main/Multiplex"
                },
                {
                    "label": "Putative Cells Origin",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/GetDataTable/Putative_Cells_Origin",
                    "id": "#main/Putative_Cells_Origin"
                },
                {
                    "label": "UMI Adjusted Statistics",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/GetDataTable/UMI_Adjusted_Stats",
                    "id": "#main/UMI_Adjusted_Stats"
                },
                {
                    "label": "VDJ",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": [
                        "#main/AnnotateVDJResults/vdjCellsDatatable",
                        "#main/AnnotateVDJResults/vdjCellsDatatableUnfiltered",
                        "#main/AnnotateVDJResults/vdjCellChainDatatableUnfiltered",
                        "#main/AnnotateVDJResults/vdjMetricsCsv"
                    ],
                    "id": "#main/vdj"
                }
            ],
            "steps": [
                {
                    "requirements": [
                        {
                            "ramMin": 16000,
                            "tmpdirMin": 262144,
                            "outdirMin": 131072,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#AddtoBam.cwl",
                    "in": [
                        {
                            "source": "#main/AnnotateR1/Annotation_R1",
                            "id": "#main/AddtoBam/Annotation_R1"
                        },
                        {
                            "source": "#main/Sparse_to_Dense_Datatable/Data_Tables",
                            "id": "#main/AddtoBam/Data_Tables"
                        },
                        {
                            "source": "#main/GetDataTable/Molecular_Annotation",
                            "id": "#main/AddtoBam/Molecular_Annotation"
                        },
                        {
                            "source": "#main/AnnotateR2/R2_Bam",
                            "id": "#main/AddtoBam/R2_Bam"
                        },
                        {
                            "source": "#main/AnnotateReads/Seq_Metrics",
                            "id": "#main/AddtoBam/Seq_Metrics"
                        },
                        {
                            "source": "#main/GetDataTable/Tag_Calls",
                            "id": "#main/AddtoBam/Tag_Calls"
                        }
                    ],
                    "out": [
                        "#main/AddtoBam/Annotated_Bam",
                        "#main/AddtoBam/output"
                    ],
                    "scatter": [
                        "#main/AddtoBam/R2_Bam"
                    ],
                    "id": "#main/AddtoBam"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 32000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#AnnotateMolecules.cwl",
                    "in": [
                        {
                            "source": "#main/Internal_Settings/AbSeq_UMI",
                            "id": "#main/AnnotateMolecules/AbSeq_UMI"
                        },
                        {
                            "source": "#main/Internal_Settings/Barcode_Num",
                            "id": "#main/AnnotateMolecules/Barcode_Num"
                        },
                        {
                            "source": "#main/Internal_Settings/Use_DBEC",
                            "id": "#main/AnnotateMolecules/Use_DBEC"
                        },
                        {
                            "source": "#main/AnnotateReads/Valid_Reads",
                            "id": "#main/AnnotateMolecules/Valids"
                        }
                    ],
                    "out": [
                        "#main/AnnotateMolecules/Mol_Annot_List",
                        "#main/AnnotateMolecules/Gene_Status_List",
                        "#main/AnnotateMolecules/output"
                    ],
                    "scatter": [
                        "#main/AnnotateMolecules/Valids"
                    ],
                    "id": "#main/AnnotateMolecules"
                },
                {
                    "run": "#AnnotateR1.cwl",
                    "in": [
                        {
                            "source": "#main/Internal_Settings/Label_Version",
                            "id": "#main/AnnotateR1/Label_Version"
                        },
                        {
                            "source": "#main/QualityFilter/R1",
                            "id": "#main/AnnotateR1/R1"
                        }
                    ],
                    "out": [
                        "#main/AnnotateR1/Annotation_R1",
                        "#main/AnnotateR1/output"
                    ],
                    "scatter": [
                        "#main/AnnotateR1/R1"
                    ],
                    "id": "#main/AnnotateR1"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 4000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#AnnotateR2.cwl",
                    "in": [
                        {
                            "source": "#main/CheckReference/Extra_Seqs",
                            "id": "#main/AnnotateR2/Extra_Seqs"
                        },
                        {
                            "source": "#main/CheckReference/Index",
                            "id": "#main/AnnotateR2/Index"
                        },
                        {
                            "source": "#main/QualityFilter/R2",
                            "id": "#main/AnnotateR2/R2"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/AnnotateR2/VDJ_Version"
                        }
                    ],
                    "out": [
                        "#main/AnnotateR2/Annot_R2",
                        "#main/AnnotateR2/R2_Bam",
                        "#main/AnnotateR2/GTF",
                        "#main/AnnotateR2/output",
                        "#main/AnnotateR2/R2_Quality_Metrics"
                    ],
                    "scatter": [
                        "#main/AnnotateR2/R2"
                    ],
                    "id": "#main/AnnotateR2"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 32000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#AnnotateReads.cwl",
                    "in": [
                        {
                            "source": "#main/Internal_Settings/AbSeq_UMI",
                            "id": "#main/AnnotateReads/AbSeq_UMI"
                        },
                        {
                            "source": "#main/CheckReference/Extra_Seqs",
                            "id": "#main/AnnotateReads/Extra_Seqs"
                        },
                        {
                            "source": "#main/QualityFilter/Filter_Metrics",
                            "id": "#main/AnnotateReads/Filter_Metrics"
                        },
                        {
                            "source": "#main/CheckReference/Index",
                            "id": "#main/AnnotateReads/Index"
                        },
                        {
                            "source": "#main/Internal_Settings/Label_Version",
                            "id": "#main/AnnotateReads/Label_Version"
                        },
                        {
                            "source": "#main/Internal_Settings/Putative_Cell_Call",
                            "id": "#main/AnnotateReads/Putative_Cell_Call"
                        },
                        {
                            "source": "#main/AnnotateR1/Annotation_R1",
                            "id": "#main/AnnotateReads/R1_Annotation"
                        },
                        {
                            "source": "#main/AnnotateR2/Annot_R2",
                            "id": "#main/AnnotateReads/R2_Annotation"
                        },
                        {
                            "source": "#main/AnnotateR2/R2_Quality_Metrics",
                            "id": "#main/AnnotateReads/R2_Quality_Metrics"
                        },
                        {
                            "source": "#main/CheckReference/Reference_Panel_Names",
                            "id": "#main/AnnotateReads/Reference_Panel_Names"
                        },
                        {
                            "source": "#main/Multiplexing_Settings/Sample_Tags_Version",
                            "id": "#main/AnnotateReads/Sample_Tags_Version"
                        },
                        {
                            "source": "#main/Multiplexing_Settings/Subsample_Tags",
                            "id": "#main/AnnotateReads/Subsample_Tags"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/AnnotateReads/VDJ_Version"
                        }
                    ],
                    "out": [
                        "#main/AnnotateReads/Seq_Metrics",
                        "#main/AnnotateReads/Valid_Reads",
                        "#main/AnnotateReads/Annotation_Read",
                        "#main/AnnotateReads/Is_Trueno",
                        "#main/AnnotateReads/Sample_Name",
                        "#main/AnnotateReads/output",
                        "#main/AnnotateReads/validTcrReads",
                        "#main/AnnotateReads/validIgReads",
                        "#main/AnnotateReads/metadata"
                    ],
                    "id": "#main/AnnotateReads"
                },
                {
                    "run": "#VDJ_Annotate_Molecules.cwl",
                    "in": [
                        {
                            "source": "#main/AnnotateReads/Sample_Name",
                            "id": "#main/AnnotateVDJResults/Sample_Name"
                        },
                        {
                            "source": "#main/CellClassifier/cellTypePredictions",
                            "id": "#main/AnnotateVDJResults/cellTypeMapping"
                        },
                        {
                            "valueFrom": "$([])",
                            "id": "#main/AnnotateVDJResults/chainsToIgnore"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_JGene_Evalue",
                            "id": "#main/AnnotateVDJResults/evalueJgene"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_VGene_Evalue",
                            "id": "#main/AnnotateVDJResults/evalueVgene"
                        },
                        {
                            "source": "#main/VDJ_GatherIGCalls/gatheredCalls",
                            "id": "#main/AnnotateVDJResults/igCalls"
                        },
                        {
                            "source": "#main/AnnotateReads/metadata",
                            "id": "#main/AnnotateVDJResults/metadata"
                        },
                        {
                            "source": "#main/GetDataTable/Cell_Order",
                            "id": "#main/AnnotateVDJResults/putativeCells"
                        },
                        {
                            "source": "#main/VDJ_GatherTCRCalls/gatheredCalls",
                            "id": "#main/AnnotateVDJResults/tcrCalls"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/AnnotateVDJResults/vdjVersion"
                        }
                    ],
                    "out": [
                        "#main/AnnotateVDJResults/vdjCellsDatatable",
                        "#main/AnnotateVDJResults/vdjCellsDatatableUnfiltered",
                        "#main/AnnotateVDJResults/vdjCellsDatatableCellCorrected",
                        "#main/AnnotateVDJResults/vdjCellsDatatableDBECCellCorrected",
                        "#main/AnnotateVDJResults/vdjCellChainDatatableUnfiltered",
                        "#main/AnnotateVDJResults/vdjValidReadsDatatable",
                        "#main/AnnotateVDJResults/vdjInvalidReadsDatatable",
                        "#main/AnnotateVDJResults/vdjMetricsJson",
                        "#main/AnnotateVDJResults/vdjMetricsCsv",
                        "#main/AnnotateVDJResults/vdjReadsAndMoleculesPerCellFigure",
                        "#main/AnnotateVDJResults/vdjReadsPerCellByChainTypeFigure"
                    ],
                    "id": "#main/AnnotateVDJResults"
                },
                {
                    "run": "#BundleLogs.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/AnnotateReads/output",
                                "#main/AnnotateR1/output",
                                "#main/AnnotateR2/output",
                                "#main/CheckReference/output",
                                "#main/GetDataTable/output",
                                "#main/Metrics/output",
                                "#main/AddtoBam/output",
                                "#main/AnnotateMolecules/output",
                                "#main/QualityFilter/output",
                                "#main/CheckFastqs/log",
                                "#main/SplitAndSubsample/log",
                                "#main/MergeBAM/log",
                                "#main/Sparse_to_Dense_Datatable/output",
                                "#main/Sparse_to_Dense_Datatable_Unfiltered/output",
                                "#main/IndexBAM/log",
                                "#main/CellClassifier/log"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/BundleLogs/log_files"
                        }
                    ],
                    "out": [
                        "#main/BundleLogs/logs_dir"
                    ],
                    "id": "#main/BundleLogs"
                },
                {
                    "run": "#Cell_Classifier.cwl",
                    "in": [
                        {
                            "source": "#main/FindDataTableForCellClassifier/molsPerCellMatrixForCellClassifier",
                            "id": "#main/CellClassifier/molsPerCellMatrix"
                        }
                    ],
                    "out": [
                        "#main/CellClassifier/cellTypePredictions",
                        "#main/CellClassifier/log"
                    ],
                    "id": "#main/CellClassifier"
                },
                {
                    "run": "#CheckFastqs.cwl",
                    "in": [
                        {
                            "source": "#main/Internal_Settings/MinChunkSize",
                            "id": "#main/CheckFastqs/MinChunkSize"
                        },
                        {
                            "source": "#main/Reads",
                            "id": "#main/CheckFastqs/Reads"
                        },
                        {
                            "source": "#main/Subsample_Settings/Subsample_Reads",
                            "id": "#main/CheckFastqs/Subsample"
                        },
                        {
                            "source": "#main/Subsample_Settings/Subsample_Seed",
                            "id": "#main/CheckFastqs/UserInputSubsampleSeed"
                        }
                    ],
                    "out": [
                        "#main/CheckFastqs/SubsampleSeed",
                        "#main/CheckFastqs/SubsamplingRatio",
                        "#main/CheckFastqs/FilesToSkipSplitAndSubsample",
                        "#main/CheckFastqs/log"
                    ],
                    "id": "#main/CheckFastqs"
                },
                {
                    "run": "#CheckReference.cwl",
                    "in": [
                        {
                            "source": "#main/AbSeq_Reference",
                            "id": "#main/CheckReference/AbSeq_Reference"
                        },
                        {
                            "source": "#main/Internal_Settings/Label_Version",
                            "id": "#main/CheckReference/Label_Version"
                        },
                        {
                            "source": "#main/Internal_Settings/Putative_Cell_Call",
                            "id": "#main/CheckReference/Putative_Cell_Call"
                        },
                        {
                            "source": "#main/Reference",
                            "id": "#main/CheckReference/Reference"
                        },
                        {
                            "source": "#main/Multiplexing_Settings/Sample_Tags_Version",
                            "id": "#main/CheckReference/Sample_Tags_Version"
                        },
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/CheckReference/VDJ_Version"
                        }
                    ],
                    "out": [
                        "#main/CheckReference/Index",
                        "#main/CheckReference/Extra_Seqs",
                        "#main/CheckReference/Reference_Panel_Names",
                        "#main/CheckReference/Full_Genes",
                        "#main/CheckReference/output"
                    ],
                    "id": "#main/CheckReference"
                },
                {
                    "run": "#FilteredDataTables.cwl",
                    "in": [
                        {
                            "source": "#main/Sparse_to_Dense_Datatable/Data_Tables",
                            "id": "#main/FilteredDataTables/Dense_DataTables"
                        },
                        {
                            "source": "#main/Sparse_to_Dense_Datatable_Unfiltered/Data_Tables",
                            "id": "#main/FilteredDataTables/Dense_DataTables_Unfiltered"
                        }
                    ],
                    "out": [
                        "#main/FilteredDataTables/Data_Tables"
                    ],
                    "id": "#main/FilteredDataTables"
                },
                {
                    "run": {
                        "cwlVersion": "v1.0",
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#main/FindDataTableForCellClassifier/0aefe96a-ba82-4090-8a4b-26a20dfbe44b/dataTables"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/FindDataTableForCellClassifier/0aefe96a-ba82-4090-8a4b-26a20dfbe44b/molsPerCellMatrixForCellClassifier"
                            }
                        ],
                        "expression": "${\n  for (var i = 0; i < inputs.dataTables.length; i++) {\n    var dataTable = inputs.dataTables[i];\n    if (dataTable.basename.indexOf(\"_RSEC_MolsPerCell.csv\") >= 0) {\n      return({molsPerCellMatrixForCellClassifier: dataTable});\n    }\n  }\n  return({molsPerCellMatrixForCellClassifier: null});\n}",
                        "id": "#main/FindDataTableForCellClassifier/0aefe96a-ba82-4090-8a4b-26a20dfbe44b"
                    },
                    "in": [
                        {
                            "source": "#main/Sparse_to_Dense_Datatable/Data_Tables",
                            "id": "#main/FindDataTableForCellClassifier/dataTables"
                        }
                    ],
                    "out": [
                        "#main/FindDataTableForCellClassifier/molsPerCellMatrixForCellClassifier"
                    ],
                    "id": "#main/FindDataTableForCellClassifier"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 32000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#GetDataTable.cwl",
                    "in": [
                        {
                            "source": "#main/Putative_Cell_Calling_Settings/Basic_Algo_Only",
                            "id": "#main/GetDataTable/Basic_Algo_Only"
                        },
                        {
                            "source": "#main/Putative_Cell_Calling_Settings/Exact_Cell_Count",
                            "id": "#main/GetDataTable/Exact_Cell_Count"
                        },
                        {
                            "source": "#main/CheckReference/Full_Genes",
                            "id": "#main/GetDataTable/Full_Genes"
                        },
                        {
                            "source": "#main/AnnotateMolecules/Gene_Status_List",
                            "id": "#main/GetDataTable/Gene_Status_List"
                        },
                        {
                            "source": "#main/AnnotateMolecules/Mol_Annot_List",
                            "id": "#main/GetDataTable/Molecule_Annotation_List"
                        },
                        {
                            "source": "#main/Internal_Settings/Putative_Cell_Call",
                            "id": "#main/GetDataTable/Putative_Cell_Call"
                        },
                        {
                            "source": "#main/AnnotateReads/Seq_Metrics",
                            "id": "#main/GetDataTable/Seq_Metrics"
                        },
                        {
                            "source": "#main/Multiplexing_Settings/Tag_Sample_Names",
                            "id": "#main/GetDataTable/Tag_Names"
                        }
                    ],
                    "out": [
                        "#main/GetDataTable/Tag_Calls",
                        "#main/GetDataTable/Molecular_Annotation",
                        "#main/GetDataTable/Tag_Annotation",
                        "#main/GetDataTable/Annot_Files",
                        "#main/GetDataTable/Cell_Label_Filter",
                        "#main/GetDataTable/Sparse_Data_Tables",
                        "#main/GetDataTable/Sparse_Data_Tables_Unfiltered",
                        "#main/GetDataTable/Expression_Data",
                        "#main/GetDataTable/Expression_Data_Unfiltered",
                        "#main/GetDataTable/UMI_Adjusted_Stats",
                        "#main/GetDataTable/UMI_Adjusted_CellLabel_Stats",
                        "#main/GetDataTable/Putative_Cells_Origin",
                        "#main/GetDataTable/Trueno_out",
                        "#main/GetDataTable/output",
                        "#main/GetDataTable/Cell_Order",
                        "#main/GetDataTable/Gene_List"
                    ],
                    "id": "#main/GetDataTable"
                },
                {
                    "run": "#IndexBAM.cwl",
                    "in": [
                        {
                            "source": "#main/MergeBAM/Final_Bam",
                            "id": "#main/IndexBAM/BamFile"
                        }
                    ],
                    "out": [
                        "#main/IndexBAM/Index",
                        "#main/IndexBAM/log"
                    ],
                    "id": "#main/IndexBAM"
                },
                {
                    "label": "Internal Settings",
                    "run": "#InternalSettings.cwl",
                    "in": [],
                    "out": [
                        "#main/Internal_Settings/Label_Version",
                        "#main/Internal_Settings/Read_Filter_Off",
                        "#main/Internal_Settings/Barcode_Num",
                        "#main/Internal_Settings/Seq_Run",
                        "#main/Internal_Settings/AbSeq_UMI",
                        "#main/Internal_Settings/Putative_Cell_Call",
                        "#main/Internal_Settings/Use_DBEC",
                        "#main/Internal_Settings/Extra_Seqs",
                        "#main/Internal_Settings/MinChunkSize",
                        "#main/Internal_Settings/NumRecordsPerSplit"
                    ],
                    "id": "#main/Internal_Settings"
                },
                {
                    "run": "#MergeBAM.cwl",
                    "in": [
                        {
                            "source": "#main/AddtoBam/Annotated_Bam",
                            "id": "#main/MergeBAM/BamFiles"
                        },
                        {
                            "source": "#main/AnnotateReads/Is_Trueno",
                            "id": "#main/MergeBAM/Is_Trueno"
                        },
                        {
                            "source": "#main/AnnotateReads/Sample_Name",
                            "id": "#main/MergeBAM/Sample_Name"
                        }
                    ],
                    "out": [
                        "#main/MergeBAM/Final_Bam",
                        "#main/MergeBAM/log"
                    ],
                    "id": "#main/MergeBAM"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 64000,
                            "tmpdirMin": 65536,
                            "outdirMin": 65536,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#Metrics.cwl",
                    "in": [
                        {
                            "source": "#main/GetDataTable/Annot_Files",
                            "id": "#main/Metrics/Annot_Files"
                        },
                        {
                            "source": "#main/Sparse_to_Dense_Datatable/Data_Tables",
                            "id": "#main/Metrics/Data_Tables"
                        },
                        {
                            "source": "#main/GetDataTable/Molecular_Annotation",
                            "id": "#main/Metrics/Molecular_Annotation"
                        },
                        {
                            "source": "#main/AnnotateReads/Seq_Metrics",
                            "id": "#main/Metrics/Seq_Metrics"
                        },
                        {
                            "source": "#main/Internal_Settings/Seq_Run",
                            "id": "#main/Metrics/Seq_Run"
                        },
                        {
                            "source": "#main/GetDataTable/Tag_Annotation",
                            "id": "#main/Metrics/Tag_Annotation"
                        },
                        {
                            "source": "#main/GetDataTable/UMI_Adjusted_CellLabel_Stats",
                            "id": "#main/Metrics/UMI_Adjusted_Stats"
                        },
                        {
                            "source": "#main/AnnotateVDJResults/vdjMetricsJson",
                            "id": "#main/Metrics/vdjMetricsJson"
                        }
                    ],
                    "out": [
                        "#main/Metrics/Metrics_Summary",
                        "#main/Metrics/Metrics_Archive",
                        "#main/Metrics/output"
                    ],
                    "id": "#main/Metrics"
                },
                {
                    "label": "Multiplexing Settings",
                    "run": "#MultiplexingSettings.cwl",
                    "in": [
                        {
                            "source": "#main/Sample_Tags_Version",
                            "id": "#main/Multiplexing_Settings/_Sample_Tags_Version"
                        },
                        {
                            "source": "#main/Subsample_Tags",
                            "id": "#main/Multiplexing_Settings/_Subsample_Tags"
                        },
                        {
                            "source": "#main/Tag_Names",
                            "id": "#main/Multiplexing_Settings/_Tag_Sample_Names"
                        }
                    ],
                    "out": [
                        "#main/Multiplexing_Settings/Subsample_Tags",
                        "#main/Multiplexing_Settings/Tag_Sample_Names",
                        "#main/Multiplexing_Settings/Sample_Tags_Version"
                    ],
                    "id": "#main/Multiplexing_Settings"
                },
                {
                    "run": "#PairReadFiles.cwl",
                    "in": [
                        {
                            "source": "#main/SplitAndSubsample/SplitAndSubsampledFastqs",
                            "id": "#main/PairReadFiles/Reads"
                        }
                    ],
                    "out": [
                        "#main/PairReadFiles/ReadPairs"
                    ],
                    "id": "#main/PairReadFiles"
                },
                {
                    "label": "Putative Cell Calling Settings",
                    "run": "#PutativeCellSettings.cwl",
                    "in": [
                        {
                            "source": "#main/Basic_Algo_Only",
                            "id": "#main/Putative_Cell_Calling_Settings/_Basic_Algo_Only"
                        },
                        {
                            "source": "#main/Exact_Cell_Count",
                            "id": "#main/Putative_Cell_Calling_Settings/_Exact_Cell_Count"
                        }
                    ],
                    "out": [
                        "#main/Putative_Cell_Calling_Settings/Exact_Cell_Count",
                        "#main/Putative_Cell_Calling_Settings/Basic_Algo_Only"
                    ],
                    "id": "#main/Putative_Cell_Calling_Settings"
                },
                {
                    "run": "#QualityFilter.cwl",
                    "in": [
                        {
                            "source": "#main/Internal_Settings/Label_Version",
                            "id": "#main/QualityFilter/Label_Version"
                        },
                        {
                            "source": "#main/Internal_Settings/Read_Filter_Off",
                            "id": "#main/QualityFilter/Read_Filter_Off"
                        },
                        {
                            "source": "#main/PairReadFiles/ReadPairs",
                            "id": "#main/QualityFilter/Split_Read_Pairs"
                        }
                    ],
                    "scatter": [
                        "#main/QualityFilter/Split_Read_Pairs"
                    ],
                    "scatterMethod": "dotproduct",
                    "out": [
                        "#main/QualityFilter/Filter_Metrics",
                        "#main/QualityFilter/R1",
                        "#main/QualityFilter/R2",
                        "#main/QualityFilter/output"
                    ],
                    "id": "#main/QualityFilter"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 4000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#SparsetoDense.cwl",
                    "in": [
                        {
                            "source": "#main/Sparse_to_Dense_File/Cell_Order",
                            "id": "#main/Sparse_to_Dense_Datatable/Cell_Order"
                        },
                        {
                            "source": "#main/GetDataTable/Gene_List",
                            "id": "#main/Sparse_to_Dense_Datatable/Gene_List"
                        },
                        {
                            "source": "#main/GetDataTable/Sparse_Data_Tables",
                            "id": "#main/Sparse_to_Dense_Datatable/Sparse_Data_Table"
                        }
                    ],
                    "out": [
                        "#main/Sparse_to_Dense_Datatable/Data_Tables",
                        "#main/Sparse_to_Dense_Datatable/output"
                    ],
                    "scatter": [
                        "#main/Sparse_to_Dense_Datatable/Sparse_Data_Table"
                    ],
                    "id": "#main/Sparse_to_Dense_Datatable"
                },
                {
                    "requirements": [
                        {
                            "ramMin": 4000,
                            "class": "ResourceRequirement"
                        }
                    ],
                    "run": "#SparsetoDense.cwl",
                    "in": [
                        {
                            "source": "#main/GetDataTable/Cell_Order",
                            "id": "#main/Sparse_to_Dense_Datatable_Unfiltered/Cell_Order"
                        },
                        {
                            "source": "#main/GetDataTable/Gene_List",
                            "id": "#main/Sparse_to_Dense_Datatable_Unfiltered/Gene_List"
                        },
                        {
                            "source": "#main/GetDataTable/Sparse_Data_Tables_Unfiltered",
                            "id": "#main/Sparse_to_Dense_Datatable_Unfiltered/Sparse_Data_Table"
                        }
                    ],
                    "out": [
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/Data_Tables",
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/output"
                    ],
                    "scatter": [
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/Sparse_Data_Table"
                    ],
                    "id": "#main/Sparse_to_Dense_Datatable_Unfiltered"
                },
                {
                    "run": "#SparsetoDenseFile.cwl",
                    "in": [
                        {
                            "source": "#main/GetDataTable/Cell_Order",
                            "id": "#main/Sparse_to_Dense_File/GDT_cell_order"
                        }
                    ],
                    "out": [
                        "#main/Sparse_to_Dense_File/Cell_Order"
                    ],
                    "id": "#main/Sparse_to_Dense_File"
                },
                {
                    "run": "#SplitAndSubsample.cwl",
                    "in": [
                        {
                            "source": "#main/Reads",
                            "id": "#main/SplitAndSubsample/Fastqs"
                        },
                        {
                            "source": "#main/CheckFastqs/FilesToSkipSplitAndSubsample",
                            "id": "#main/SplitAndSubsample/FilesToSkipSplitAndSubsample"
                        },
                        {
                            "source": "#main/Internal_Settings/NumRecordsPerSplit",
                            "id": "#main/SplitAndSubsample/NumRecordsPerSplit"
                        },
                        {
                            "source": "#main/CheckFastqs/SubsamplingRatio",
                            "id": "#main/SplitAndSubsample/SubsampleRatio"
                        },
                        {
                            "source": "#main/CheckFastqs/SubsampleSeed",
                            "id": "#main/SplitAndSubsample/SubsampleSeed"
                        }
                    ],
                    "out": [
                        "#main/SplitAndSubsample/SplitAndSubsampledFastqs",
                        "#main/SplitAndSubsample/log"
                    ],
                    "id": "#main/SplitAndSubsample"
                },
                {
                    "label": "Subsample Settings",
                    "run": "#SubsampleSettings.cwl",
                    "in": [
                        {
                            "source": "#main/Subsample",
                            "id": "#main/Subsample_Settings/_Subsample_Reads"
                        },
                        {
                            "source": "#main/Subsample_seed",
                            "id": "#main/Subsample_Settings/_Subsample_Seed"
                        }
                    ],
                    "out": [
                        "#main/Subsample_Settings/Subsample_Reads",
                        "#main/Subsample_Settings/Subsample_Seed"
                    ],
                    "id": "#main/Subsample_Settings"
                },
                {
                    "run": "#UncompressDatatables.cwl",
                    "in": [
                        {
                            "source": "#main/FilteredDataTables/Data_Tables",
                            "id": "#main/Uncompress_Datatables/Compressed_Data_Table"
                        },
                        {
                            "source": "#main/GetDataTable/Expression_Data",
                            "id": "#main/Uncompress_Datatables/Compressed_Expression_Matrix"
                        }
                    ],
                    "out": [
                        "#main/Uncompress_Datatables/Uncompressed_Data_Tables",
                        "#main/Uncompress_Datatables/Uncompressed_Expression_Matrix"
                    ],
                    "id": "#main/Uncompress_Datatables"
                },
                {
                    "run": "#VDJ_GatherCalls.cwl",
                    "in": [
                        {
                            "source": "#main/VDJ_ig/igCalls",
                            "id": "#main/VDJ_GatherIGCalls/theCalls"
                        }
                    ],
                    "out": [
                        "#main/VDJ_GatherIGCalls/gatheredCalls"
                    ],
                    "id": "#main/VDJ_GatherIGCalls"
                },
                {
                    "run": "#VDJ_GatherCalls.cwl",
                    "in": [
                        {
                            "source": "#main/VDJ_tcr/tcrCalls",
                            "id": "#main/VDJ_GatherTCRCalls/theCalls"
                        }
                    ],
                    "out": [
                        "#main/VDJ_GatherTCRCalls/gatheredCalls"
                    ],
                    "id": "#main/VDJ_GatherTCRCalls"
                },
                {
                    "label": "VDJ Settings",
                    "run": "#VDJ_Settings.cwl",
                    "in": [
                        {
                            "source": "#main/VDJ_JGene_Evalue",
                            "id": "#main/VDJ_Settings/_VDJ_JGene_Evalue"
                        },
                        {
                            "source": "#main/VDJ_VGene_Evalue",
                            "id": "#main/VDJ_Settings/_VDJ_VGene_Evalue"
                        },
                        {
                            "source": "#main/VDJ_Version",
                            "id": "#main/VDJ_Settings/_VDJ_Version"
                        }
                    ],
                    "out": [
                        "#main/VDJ_Settings/VDJ_Version",
                        "#main/VDJ_Settings/VDJ_VGene_Evalue",
                        "#main/VDJ_Settings/VDJ_JGene_Evalue"
                    ],
                    "id": "#main/VDJ_Settings"
                },
                {
                    "run": "#VDJ_SplitValidReads.cwl",
                    "in": [
                        {
                            "source": "#main/AnnotateReads/validIgReads",
                            "id": "#main/VDJ_SplitValidReadsIg/validReads"
                        }
                    ],
                    "out": [
                        "#main/VDJ_SplitValidReadsIg/SplitFastaList",
                        "#main/VDJ_SplitValidReadsIg/numFiles",
                        "#main/VDJ_SplitValidReadsIg/log"
                    ],
                    "id": "#main/VDJ_SplitValidReadsIg"
                },
                {
                    "run": "#VDJ_SplitValidReads.cwl",
                    "in": [
                        {
                            "source": "#main/AnnotateReads/validTcrReads",
                            "id": "#main/VDJ_SplitValidReadsTcr/validReads"
                        }
                    ],
                    "out": [
                        "#main/VDJ_SplitValidReadsTcr/SplitFastaList",
                        "#main/VDJ_SplitValidReadsTcr/numFiles",
                        "#main/VDJ_SplitValidReadsTcr/log"
                    ],
                    "id": "#main/VDJ_SplitValidReadsTcr"
                },
                {
                    "run": "#VDJ_ig.cwl",
                    "in": [
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/VDJ_ig/VDJ_Version"
                        },
                        {
                            "source": "#main/VDJ_SplitValidReadsIg/numFiles",
                            "id": "#main/VDJ_ig/numFiles"
                        },
                        {
                            "source": "#main/VDJ_SplitValidReadsIg/SplitFastaList",
                            "id": "#main/VDJ_ig/validReadsIg"
                        }
                    ],
                    "out": [
                        "#main/VDJ_ig/igCalls"
                    ],
                    "scatter": [
                        "#main/VDJ_ig/validReadsIg"
                    ],
                    "id": "#main/VDJ_ig"
                },
                {
                    "run": "#VDJ_tcr.cwl",
                    "in": [
                        {
                            "source": "#main/VDJ_Settings/VDJ_Version",
                            "id": "#main/VDJ_tcr/VDJ_Version"
                        },
                        {
                            "source": "#main/VDJ_SplitValidReadsTcr/numFiles",
                            "id": "#main/VDJ_tcr/numFiles"
                        },
                        {
                            "source": "#main/VDJ_SplitValidReadsTcr/SplitFastaList",
                            "id": "#main/VDJ_tcr/validReadsTcr"
                        }
                    ],
                    "out": [
                        "#main/VDJ_tcr/tcrCalls"
                    ],
                    "scatter": [
                        "#main/VDJ_tcr/validReadsTcr"
                    ],
                    "id": "#main/VDJ_tcr"
                }
            ],
            "id": "#main"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "coresMin": 4,
                    "class": "ResourceRequirement"
                },
                {
                    "outputDirType": "keep_output_dir",
                    "keep_cache": 8000,
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "samtools",
                "merge"
            ],
            "stdout": "samtools_merge.log",
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#MergeBAM.cwl/BamFiles"
                },
                {
                    "type": "boolean",
                    "id": "#MergeBAM.cwl/Is_Trueno"
                },
                {
                    "type": "string",
                    "id": "#MergeBAM.cwl/Sample_Name"
                }
            ],
            "arguments": [
                {
                    "prefix": "-@",
                    "valueFrom": "$(runtime.cores)"
                },
                {
                    "position": 0,
                    "valueFrom": "${\n    if (inputs.Is_Trueno) {\n        return \"Combined_\" + inputs.Sample_Name + \"_final.BAM\"\n    } else {\n        return inputs.Sample_Name + \"_final.BAM\"\n    }\n}"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_final.BAM"
                    },
                    "id": "#MergeBAM.cwl/Final_Bam"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#MergeBAM.cwl/log"
                }
            ],
            "id": "#MergeBAM.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "hints": [
                {
                    "class": "http://arvados.org/cwl#APIRequirement"
                },
                {
                    "class": "http://arvados.org/cwl#RuntimeConstraints",
                    "keep_cache": 512
                },
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "r5.4xlarge"
                }
            ],
            "baseCommand": [
                "mist_metrics.py"
            ],
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--annot-files"
                    },
                    "id": "#Metrics.cwl/Annot_Files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "itemSeparator": ",",
                        "prefix": "--data-tables"
                    },
                    "id": "#Metrics.cwl/Data_Tables"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--annot-mol-file"
                    },
                    "id": "#Metrics.cwl/Molecular_Annotation"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    },
                    "id": "#Metrics.cwl/Seq_Metrics"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--seq-run"
                    },
                    "id": "#Metrics.cwl/Seq_Run"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--tag-annot"
                    },
                    "id": "#Metrics.cwl/Tag_Annotation"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--umi-adjusted-stats"
                    },
                    "id": "#Metrics.cwl/UMI_Adjusted_Stats"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--vdj-metrics-fp"
                    },
                    "id": "#Metrics.cwl/vdjMetricsJson"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "internal-metrics-archive.tar.gz"
                    },
                    "id": "#Metrics.cwl/Metrics_Archive"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_Metrics_Summary.csv"
                    },
                    "id": "#Metrics.cwl/Metrics_Summary"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#Metrics.cwl/output"
                }
            ],
            "id": "#Metrics.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "default": "Targeted",
                    "id": "#MultiplexingSettings.cwl/Assay"
                },
                {
                    "type": [
                        "null",
                        "Any"
                    ],
                    "id": "#MultiplexingSettings.cwl/_Sample_Tags_Version"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#MultiplexingSettings.cwl/_Subsample_Tags"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "id": "#MultiplexingSettings.cwl/_Tag_Sample_Names"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "id": "#MultiplexingSettings.cwl/Sample_Tags_Version"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#MultiplexingSettings.cwl/Subsample_Tags"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "id": "#MultiplexingSettings.cwl/Tag_Sample_Names"
                }
            ],
            "expression": "${\n  var enumifiedSampleTagsVersion = null;\n  if (inputs._Sample_Tags_Version) {\n  var _Sample_Tags_Version = inputs._Sample_Tags_Version.toLowerCase();\n  if (_Sample_Tags_Version.indexOf('human') >= 0 || _Sample_Tags_Version === 'hs')\n  {\n    enumifiedSampleTagsVersion = 'hs';\n  }\n  else if (_Sample_Tags_Version.indexOf('mouse') >= 0 || _Sample_Tags_Version === 'mm')\n  {\n    enumifiedSampleTagsVersion = 'mm';\n  }\n  else if (_Sample_Tags_Version === 'no multiplexing')\n  {\n    enumifiedSampleTagsVersion = null;\n  }\n  else\n  {\n    throw new Error(\"Cannot parse Sample Tag Version: \" + inputs._Sample_Tags_Version);\n  }\n  }\n  return ({\n  Subsample_Tags: inputs._Subsample_Tags,\n  Tag_Sample_Names: inputs._Tag_Sample_Names,\n  Sample_Tags_Version: enumifiedSampleTagsVersion\n  });\n}",
            "id": "#MultiplexingSettings.cwl"
        },
        {
            "doc": "PairReadsFiles takes an array of split files and pairs them, such that an R1 file is transferred to a QualityFilter with its corresponding R2 file.\nEach file should be formatted as illumina outputs it from basespace: e.g. sample_L001_R1_001.fastq.gz. After being split, that sample file would be an array files named sample_L001_R1_001-00.fastq, sample_L001_R1_001-01.fastq, etc\n",
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#PairReadFiles.cwl/Reads"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "name": "#PairReadFiles.cwl/ReadPairs/R1",
                                    "type": "File"
                                },
                                {
                                    "name": "#PairReadFiles.cwl/ReadPairs/R2",
                                    "type": "File"
                                },
                                {
                                    "name": "#PairReadFiles.cwl/ReadPairs/readPairID",
                                    "type": "int"
                                },
                                {
                                    "name": "#PairReadFiles.cwl/ReadPairs/library",
                                    "type": "string"
                                }
                            ]
                        }
                    },
                    "id": "#PairReadFiles.cwl/ReadPairs"
                }
            ],
            "expression": "${\n  // send paired reads to the same key in readPairs\n  var readPairs = {}\n  for (var i = 0; i < inputs.Reads.length; i++) {\n    var f = inputs.Reads[i];\n\n    // This is the illumina basespace regex. More sophisticated file handling is needed for NovaSeq\n    // example: <SAMPLE>[<SAMPLE NUMBER>][<LANE>]_R<READ FLAG>_001.fastq.gz\n    var groups = f.basename.match(/^(.*?)(_S[0-9]*)?(_L[0-9]*)?(_R[1|2])_001(-[0-9]*)?\\.(.*?)$/);\n    var library = groups[1];\n    var sampleNumber = groups[2];\n    var laneNumber = groups[3];\n    var flag = groups[4];\n    var chunkID = 9999; // if there is no scatter id, use an arbitrary number\n    if (groups[5]){\n      chunkID = parseInt(groups[5].slice(1)); // slice off the '-'\n    }\n\n    // double check we have a chunk id\n    if (chunkID === undefined || chunkID === null) {\n          throw new Error(\"chunkID could not be determined!\");\n    }\n\n    // notice, we ignore the flag. This causes the paired reads to share the same key\n    var readPairID = library + sampleNumber + laneNumber + chunkID\n\n    // sort the information from the filename into an object\n    if (!readPairs[readPairID]) {\n      readPairs[readPairID] = {\n        R1: null,\n        R2: null,\n        library: library,\n        readPairID: null,\n      };\n    }\n    // add in the readPair, depending on the flag\n    if (flag === \"_R1\") {\n      readPairs[readPairID].R1 = f\n    } else if (flag === \"_R2\") {\n      readPairs[readPairID].R2 = f\n    }\n\n  }\n  // we are not interested in the keys in readPairs; flatten into an array of objects\n  var readPairsList = []\n  var i = 1;\n  for (var key in readPairs) {\n    if (readPairs.hasOwnProperty(key)) {\n      var readPair = readPairs[key]\n      readPair.readPairID = i\n      readPairsList.push(readPair)\n      i++;\n    }\n  }\n  // pass this array to the record array named \"ReadPairs\" on the CWL layer\n  return {ReadPairs: readPairsList}\n}",
            "id": "#PairReadFiles.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "id": "#PutativeCellSettings.cwl/_Basic_Algo_Only"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#PutativeCellSettings.cwl/_Exact_Cell_Count"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "id": "#PutativeCellSettings.cwl/Basic_Algo_Only"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#PutativeCellSettings.cwl/Exact_Cell_Count"
                }
            ],
            "expression": "${\n  if (inputs._Exact_Cell_Count) {\n    if (inputs._Exact_Cell_Count < 1) {\n      throw(\"Illogical value for exact cell count: \" + inputs._Exact_Cell_Count);\n    }\n  }\n  return ({\n    Exact_Cell_Count: inputs._Exact_Cell_Count,\n    Basic_Algo_Only: inputs._Basic_Algo_Only,\n  });\n}",
            "id": "#PutativeCellSettings.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "hints": [
                {
                    "class": "http://arvados.org/cwl#RuntimeConstraints",
                    "keep_cache": 512
                },
                {
                    "class": "https://sevenbridges.comAWSInstanceType",
                    "value": "c5.18xlarge"
                }
            ],
            "baseCommand": [
                "mist_quality_filter.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--label-version"
                    },
                    "id": "#QualityFilter.cwl/Label_Version"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--read-filter-off"
                    },
                    "id": "#QualityFilter.cwl/Read_Filter_Off"
                },
                {
                    "type": {
                        "type": "record",
                        "fields": [
                            {
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/R1",
                                "type": "File",
                                "inputBinding": {
                                    "prefix": "--r1"
                                }
                            },
                            {
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/R2",
                                "type": "File",
                                "inputBinding": {
                                    "prefix": "--r2"
                                }
                            },
                            {
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/readPairID",
                                "type": "int",
                                "inputBinding": {
                                    "prefix": "--read-pair-id"
                                }
                            },
                            {
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/library",
                                "type": "string",
                                "inputBinding": {
                                    "prefix": "--library"
                                }
                            }
                        ]
                    },
                    "id": "#QualityFilter.cwl/Split_Read_Pairs"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*read_quality.csv.gz"
                    },
                    "id": "#QualityFilter.cwl/Filter_Metrics"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_R1_.fastq.gz"
                    },
                    "id": "#QualityFilter.cwl/R1"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_R2_.fastq.gz"
                    },
                    "id": "#QualityFilter.cwl/R2"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#QualityFilter.cwl/output"
                }
            ],
            "id": "#QualityFilter.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": [
                "mist_sparse_to_dense.py"
            ],
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--cell-order"
                    },
                    "id": "#SparsetoDense.cwl/Cell_Order"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--gene-list"
                    },
                    "id": "#SparsetoDense.cwl/Gene_List"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--sparse-data-table"
                    },
                    "id": "#SparsetoDense.cwl/Sparse_Data_Table"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.csv.gz"
                    },
                    "id": "#SparsetoDense.cwl/Data_Tables"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#SparsetoDense.cwl/output"
                }
            ],
            "id": "#SparsetoDense.cwl"
        },
        {
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                }
            ],
            "class": "CommandLineTool",
            "baseCommand": "cat",
            "stdout": "cell_order.json",
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#SparsetoDenseFile.cwl/GDT_cell_order"
                }
            ],
            "outputs": [
                {
                    "type": "stdout",
                    "id": "#SparsetoDenseFile.cwl/Cell_Order"
                }
            ],
            "id": "#SparsetoDenseFile.cwl"
        },
        {
            "doc": "SplitAndSubsample splits, subsamples and formats read files to be deposited in QualityFilter.\n",
            "class": "Workflow",
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#SplitAndSubsample.cwl/Fastqs"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "id": "#SplitAndSubsample.cwl/FilesToSkipSplitAndSubsample"
                },
                {
                    "type": [
                        "null",
                        "long"
                    ],
                    "id": "#SplitAndSubsample.cwl/NumRecordsPerSplit"
                },
                {
                    "type": "float",
                    "id": "#SplitAndSubsample.cwl/SubsampleRatio"
                },
                {
                    "type": "int",
                    "id": "#SplitAndSubsample.cwl/SubsampleSeed"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#SplitAndSubsample.cwl/FlattenOutput/SplitFastqList",
                    "id": "#SplitAndSubsample.cwl/SplitAndSubsampledFastqs"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#SplitAndSubsample.cwl/SplitAndSubsample/log",
                    "id": "#SplitAndSubsample.cwl/log"
                }
            ],
            "steps": [
                {
                    "doc": "After scattering \"SplitAndSubsample\" on a File array, the output of each node is also an array. Thus, we are left with a nestled list. This JS expression flattens this list to deal with the split reads in PairReadFiles.cwl",
                    "in": [
                        {
                            "source": "#SplitAndSubsample.cwl/SplitAndSubsample/SplitAndSubsampledFastqs",
                            "id": "#SplitAndSubsample.cwl/FlattenOutput/nestledSplitFastqList"
                        }
                    ],
                    "out": [
                        "#SplitAndSubsample.cwl/FlattenOutput/SplitFastqList"
                    ],
                    "run": {
                        "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output",
                        "cwlVersion": "v1.0",
                        "class": "ExpressionTool",
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": {
                                        "type": "array",
                                        "items": "File"
                                    }
                                },
                                "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output/nestledSplitFastqList"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output/SplitFastqList"
                            }
                        ],
                        "expression": "${\n  return {SplitFastqList: [].concat.apply([], inputs.nestledSplitFastqList)}\n}\n"
                    },
                    "id": "#SplitAndSubsample.cwl/FlattenOutput"
                },
                {
                    "doc": "Allocate one docker/python process per file to do the actual file splitting.",
                    "in": [
                        {
                            "source": "#SplitAndSubsample.cwl/Fastqs",
                            "id": "#SplitAndSubsample.cwl/SplitAndSubsample/Fastq"
                        },
                        {
                            "source": "#SplitAndSubsample.cwl/FilesToSkipSplitAndSubsample",
                            "id": "#SplitAndSubsample.cwl/SplitAndSubsample/FilesToSkipSplitAndSubsample"
                        },
                        {
                            "source": "#SplitAndSubsample.cwl/NumRecordsPerSplit",
                            "id": "#SplitAndSubsample.cwl/SplitAndSubsample/NumRecordsPerSplit"
                        },
                        {
                            "source": "#SplitAndSubsample.cwl/SubsampleRatio",
                            "id": "#SplitAndSubsample.cwl/SplitAndSubsample/SubsampleRatio"
                        },
                        {
                            "source": "#SplitAndSubsample.cwl/SubsampleSeed",
                            "id": "#SplitAndSubsample.cwl/SplitAndSubsample/SubsampleSeed"
                        }
                    ],
                    "scatter": [
                        "#SplitAndSubsample.cwl/SplitAndSubsample/Fastq"
                    ],
                    "out": [
                        "#SplitAndSubsample.cwl/SplitAndSubsample/SplitAndSubsampledFastqs",
                        "#SplitAndSubsample.cwl/SplitAndSubsample/log"
                    ],
                    "run": {
                        "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq",
                        "class": "CommandLineTool",
                        "cwlVersion": "v1.0",
                        "hints": [
                            {
                                "outputDirType": "keep_output_dir",
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ],
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            }
                        ],
                        "baseCommand": [
                            "mist_split_fastq.py"
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "inputBinding": {
                                    "prefix": "--fastq-file-path"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/Fastq"
                            },
                            {
                                "type": {
                                    "type": "array",
                                    "items": "string"
                                },
                                "inputBinding": {
                                    "prefix": "--files-to-skip-split-and-subsample",
                                    "itemSeparator": ","
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/FilesToSkipSplitAndSubsample"
                            },
                            {
                                "type": [
                                    "null",
                                    "long"
                                ],
                                "inputBinding": {
                                    "prefix": "--num-records"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/NumRecordsPerSplit"
                            },
                            {
                                "type": "float",
                                "inputBinding": {
                                    "prefix": "--subsample-ratio"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SubsampleRatio"
                            },
                            {
                                "type": "int",
                                "inputBinding": {
                                    "prefix": "--subsample-seed"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SubsampleSeed"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "outputBinding": {
                                    "glob": "*.fastq.gz",
                                    "outputEval": "${ if (self.length === 0) { return [inputs.Fastq]; } else { return self; } }"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SplitAndSubsampledFastqs"
                            },
                            {
                                "type": "File",
                                "outputBinding": {
                                    "glob": "*.log"
                                },
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/log"
                            }
                        ]
                    },
                    "id": "#SplitAndSubsample.cwl/SplitAndSubsample"
                }
            ],
            "id": "#SplitAndSubsample.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#SubsampleSettings.cwl/_Subsample_Reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#SubsampleSettings.cwl/_Subsample_Seed"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#SubsampleSettings.cwl/Subsample_Reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "id": "#SubsampleSettings.cwl/Subsample_Seed"
                }
            ],
            "expression": "${\n  var subsamplingOutputs = {\n    Subsample_Reads: inputs._Subsample_Reads,\n    Subsample_Seed: inputs._Subsample_Seed\n  }\n  return subsamplingOutputs;\n}",
            "id": "#SubsampleSettings.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#UncompressDatatables.cwl/Compressed_Data_Table"
                },
                {
                    "type": "File",
                    "id": "#UncompressDatatables.cwl/Compressed_Expression_Matrix"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompressed_File",
                    "id": "#UncompressDatatables.cwl/Uncompressed_Data_Tables"
                },
                {
                    "type": "File",
                    "outputSource": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompressed_File",
                    "id": "#UncompressDatatables.cwl/Uncompressed_Expression_Matrix"
                }
            ],
            "steps": [
                {
                    "run": {
                        "$namespaces": {
                            "arv": "http://arvados.org/cwl#"
                        },
                        "hints": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            },
                            {
                                "outputDirType": "keep_output_dir",
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ],
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "baseCommand": [
                            "gunzip"
                        ],
                        "arguments": [
                            {
                                "position": 0,
                                "valueFrom": "-c"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "inputBinding": {
                                    "position": 1
                                },
                                "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner/Compressed_File"
                            }
                        ],
                        "stdout": "$(inputs.Compressed_File.nameroot)",
                        "outputs": [
                            {
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.Compressed_File.nameroot)"
                                },
                                "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner/Uncompressed_File"
                            }
                        ],
                        "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner"
                    },
                    "in": [
                        {
                            "source": "#UncompressDatatables.cwl/Compressed_Data_Table",
                            "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Compressed_File"
                        }
                    ],
                    "scatter": [
                        "#UncompressDatatables.cwl/Uncompress_Datatable/Compressed_File"
                    ],
                    "out": [
                        "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompressed_File"
                    ],
                    "id": "#UncompressDatatables.cwl/Uncompress_Datatable"
                },
                {
                    "run": {
                        "$namespaces": {
                            "arv": "http://arvados.org/cwl#"
                        },
                        "hints": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            },
                            {
                                "outputDirType": "keep_output_dir",
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ],
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "baseCommand": [
                            "gunzip"
                        ],
                        "arguments": [
                            {
                                "position": 0,
                                "valueFrom": "-c"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "inputBinding": {
                                    "position": 1
                                },
                                "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner/Compressed_File"
                            }
                        ],
                        "stdout": "$(inputs.Compressed_File.nameroot)",
                        "outputs": [
                            {
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.Compressed_File.nameroot)"
                                },
                                "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner/Uncompressed_File"
                            }
                        ],
                        "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner"
                    },
                    "in": [
                        {
                            "source": "#UncompressDatatables.cwl/Compressed_Expression_Matrix",
                            "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Compressed_File"
                        }
                    ],
                    "out": [
                        "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompressed_File"
                    ],
                    "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix"
                }
            ],
            "id": "#UncompressDatatables.cwl"
        },
        {
            "class": "CommandLineTool",
            "hints": [
                {
                    "ramMin": 64000,
                    "class": "ResourceRequirement"
                }
            ],
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "mist_annotate_molecules_vdj.py"
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "prefix": "--sample-name",
                        "position": 1
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/Sample_Name"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 0,
                        "prefix": "--cell-type-mapping-fp"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/cellTypeMapping"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--ignore",
                        "itemSeparator": ","
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/chainsToIgnore"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "position": 8,
                        "prefix": "--e-value-for-j"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/evalueJgene"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "position": 7,
                        "prefix": "--e-value-for-v"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/evalueVgene"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 5
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/igCalls"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 9,
                        "prefix": "--metadata-fp"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/metadata"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--putative-cells-json-fp",
                        "position": 3
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/putativeCells"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 6
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/tcrCalls"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--vdj-version",
                        "position": 2
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjVersion"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_perCellChain_unfiltered.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjCellChainDatatableUnfiltered"
                },
                {
                    "doc": "VDJ data per cell, with distribution based error correction",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_perCell.csv"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjCellsDatatable"
                },
                {
                    "doc": "VDJ data per cell, cell type error correction",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_perCell_cellType_corrected.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjCellsDatatableCellCorrected"
                },
                {
                    "doc": "VDJ data per cell, DBEC and cell type error correction",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_perCell_DBEC_cellType_corrected.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjCellsDatatableDBECCellCorrected"
                },
                {
                    "doc": "VDJ data per cell, including non-putative cells, no error correction applied",
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_perCell_unfiltered.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjCellsDatatableUnfiltered"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_readsInvalid.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjInvalidReadsDatatable"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_metrics.csv"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjMetricsCsv"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_metrics.json"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjMetricsJson"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_molecules_per_cell_and_chain_summary_boxplot.png"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjReadsAndMoleculesPerCellFigure"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "*_DBEC_cutoff.png"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjReadsPerCellByChainTypeFigure"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_VDJ_readsValid.csv.gz"
                    },
                    "id": "#VDJ_Annotate_Molecules.cwl/vdjValidReadsDatatable"
                }
            ],
            "id": "#VDJ_Annotate_Molecules.cwl"
        },
        {
            "class": "Workflow",
            "hints": [
                {
                    "class": "ResourceRequirement",
                    "coresMax": 1,
                    "ramMax": 2000
                }
            ],
            "inputs": [
                {
                    "doc": ".fasta.gz",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#VDJ_Annotate_Reads.cwl/Cdr3QueryFasta"
                },
                {
                    "type": {
                        "type": "enum",
                        "symbols": [
                            "#VDJ_Annotate_Reads.cwl/vdjType/Ig",
                            "#VDJ_Annotate_Reads.cwl/vdjType/TCR"
                        ]
                    },
                    "id": "#VDJ_Annotate_Reads.cwl/vdjType"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#VDJ_Annotate_Reads.cwl/vdjVersion"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#VDJ_Annotate_Reads.cwl/PrunePyIR/PrunedPyIROutput",
                    "id": "#VDJ_Annotate_Reads.cwl/Cdr3Call"
                }
            ],
            "steps": [
                {
                    "id": "#VDJ_Annotate_Reads.cwl/CallCdr3",
                    "run": {
                        "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner",
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            },
                            {
                                "class": "InlineJavascriptRequirement"
                            },
                            {
                                "class": "ShellCommandRequirement"
                            }
                        ],
                        "baseCommand": [
                            "mist_pyirWrapper.py"
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/Cdr3QueryFasta"
                            },
                            {
                                "type": {
                                    "type": "enum",
                                    "symbols": [
                                        "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/vdjType/Ig",
                                        "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/vdjType/TCR"
                                    ]
                                },
                                "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/vdjType"
                            },
                            {
                                "type": [
                                    "null",
                                    {
                                        "type": "enum",
                                        "symbols": [
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                                        ]
                                    }
                                ],
                                "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/vdjVersion"
                            }
                        ],
                        "arguments": [
                            {
                                "prefix": "-r",
                                "valueFrom": "$(inputs.vdjType)"
                            },
                            {
                                "prefix": "--database",
                                "valueFrom": "/mist/pyir_data"
                            },
                            {
                                "prefix": "-f",
                                "valueFrom": "json"
                            },
                            {
                                "prefix": "-m",
                                "valueFrom": "1"
                            },
                            {
                                "prefix": "-s",
                                "valueFrom": "${\n  if (!inputs.vdjVersion) {\n    return(\"~/deliberatelyNotADirectoryToInduceFailure\");\n  } else if (inputs.vdjVersion === \"human\" || inputs.vdjVersion === \"humanBCR\" || inputs.vdjVersion === \"humanTCR\"){\n    return(\"human\");\n  } else if (inputs.vdjVersion === \"mouse\" || inputs.vdjVersion === \"mouseBCR\" || inputs.vdjVersion === \"mouseTCR\"){\n    return(\"mouse\");\n  } else {\n    throw(\"Unknown VDJ version\");\n  }\n}"
                            },
                            {
                                "prefix": "-o",
                                "valueFrom": "${\n  if(inputs.Cdr3QueryFasta){\n    return(inputs.Cdr3QueryFasta.nameroot.split(\".\")[0]);\n  } else {\n    return(\"NA\");\n  }\n}"
                            },
                            {
                                "prefix": "-winput",
                                "valueFrom": "${\n  if (!inputs.vdjType) {\n    return(\"~/deliberatelyNotAQueryFastaToInduceFailure.fasta\");\n  } else {\n    return(inputs.Cdr3QueryFasta);\n  }\n}"
                            },
                            {
                                "valueFrom": "${\n  if (!inputs.vdjVersion && !inputs.Cdr3QueryFasta) {\n    return(\"&> /dev/null || true ; echo 'Since this is not a VDJ run, we will skip this node...'\");\n  } else if (!inputs.vdjVersion && inputs.Cdr3QueryFasta){\n    throw(\"VDJ disabled but CDR3 calling FASTA specified!\");\n  } else if (inputs.vdjVersion && !inputs.Cdr3QueryFasta) {\n    return(\"&> /dev/null || true ; echo 'VDJ enabled, but no query sequence specified. Assuming none were capture in AnnotateReads!'\");\n  } else if (inputs.vdjVersion && inputs.Cdr3QueryFasta) {\n    return(\"\");\n  }\n}",
                                "shellQuote": false
                            }
                        ],
                        "outputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "outputBinding": {
                                    "glob": "*.json.gz",
                                    "outputEval": "${\n  if (inputs.vdjVersion && inputs.Cdr3QueryFasta && self.size == 0) {\n    throw(\"No outputs from PyIR detected!\");\n  } else {\n    return(self);\n  }\n}"
                                },
                                "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/CallCdr3Inner/Cdr3Call"
                            }
                        ]
                    },
                    "in": [
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/ConstantRegionCall",
                            "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/Cdr3QueryFasta"
                        },
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/vdjType",
                            "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/vdjType"
                        },
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/vdjVersion",
                            "id": "#VDJ_Annotate_Reads.cwl/CallCdr3/vdjVersion"
                        }
                    ],
                    "out": [
                        "#VDJ_Annotate_Reads.cwl/CallCdr3/Cdr3Call"
                    ]
                },
                {
                    "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion",
                    "run": {
                        "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/CallConstantRegionInner",
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            },
                            {
                                "class": "InlineJavascriptRequirement"
                            },
                            {
                                "class": "ShellCommandRequirement"
                            }
                        ],
                        "baseCommand": [
                            "bowtie2"
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/CallConstantRegionInner/Cdr3QueryFasta"
                            },
                            {
                                "type": [
                                    "null",
                                    {
                                        "type": "enum",
                                        "symbols": [
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                            "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                                        ]
                                    }
                                ],
                                "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/CallConstantRegionInner/vdjVersion"
                            }
                        ],
                        "arguments": [
                            "--quiet",
                            "--no-head",
                            "--local",
                            "-p",
                            "1",
                            "-L",
                            "10",
                            "-N",
                            "1",
                            "--ma",
                            "4",
                            {
                                "prefix": "-f",
                                "valueFrom": "$(inputs.Cdr3QueryFasta)"
                            },
                            {
                                "prefix": "-x",
                                "valueFrom": "${\n  if (!inputs.vdjVersion) {\n    return(\"~/deliberatelyNotADirectoryToInduceFailure\");\n  } else if (inputs.vdjVersion === \"human\" || inputs.vdjVersion === \"humanBCR\" || inputs.vdjVersion === \"humanTCR\"){\n    return(\"/mist/vdj_constant_region_reference_index/humanVDJCidx\");\n  } else if (inputs.vdjVersion === \"mouse\" || inputs.vdjVersion === \"mouseBCR\" || inputs.vdjVersion === \"mouseTCR\"){\n    return(\"/mist/vdj_constant_region_reference_index/mouseVDJCidx\");\n  } else {\n    throw(\"Unknown VDJ version\");\n  }\n}"
                            },
                            {
                                "valueFrom": "|",
                                "shellQuote": false
                            },
                            "awk",
                            {
                                "shellQuote": false,
                                "valueFrom": "${\n  if(inputs.Cdr3QueryFasta) {\n    return(\"\\'{print \\\">\\\" $1 \\\",\\\" $3 \\\"\\\\n\\\" $10 |  \\\" gzip >> \" + inputs.Cdr3QueryFasta.nameroot.split(\".\")[0] + \"_constant_region_called.fasta.gz\\\"}\\'\");\n  } else {\n    return(\"\\'{print \\\">\\\" $1 \\\",\\\" $3 \\\"\\\\n\\\" $10}\\'\");\n  }\n}"
                            },
                            {
                                "valueFrom": "${\n  if (!inputs.vdjVersion && !inputs.Cdr3QueryFasta) {\n    return(\"&> /dev/null || true ; echo 'Since this is not a VDJ run, we will skip this node...'\");\n  } else if (!inputs.vdjVersion && inputs.Cdr3QueryFasta){\n    throw(\"VDJ disabled but CDR3 calling FASTA specified!\");\n  } else if (inputs.vdjVersion && !inputs.Cdr3QueryFasta) {\n    return(\"&> /dev/null || true ; echo 'VDJ enabled, but no query sequence specified. Assuming none were capture in AnnotateReads!'\");\n  } else if (inputs.vdjVersion && inputs.Cdr3QueryFasta) {\n    return(\"\");\n  }\n}",
                                "shellQuote": false
                            }
                        ],
                        "outputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "outputBinding": {
                                    "glob": "*_constant_region_called.fasta.gz",
                                    "outputEval": "${\n  if (!inputs.vdjVersion) {\n    return(null);\n  } else {\n    return(self);\n  }\n}"
                                },
                                "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/CallConstantRegionInner/ConstantRegionCall"
                            }
                        ]
                    },
                    "in": [
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/Cdr3QueryFasta",
                            "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/Cdr3QueryFasta"
                        },
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/vdjVersion",
                            "id": "#VDJ_Annotate_Reads.cwl/CallConstantRegion/vdjVersion"
                        }
                    ],
                    "out": [
                        "#VDJ_Annotate_Reads.cwl/CallConstantRegion/ConstantRegionCall"
                    ]
                },
                {
                    "run": {
                        "id": "#VDJ_Annotate_Reads.cwl/PrunePyIR/PrunePyIRInner",
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            }
                        ],
                        "baseCommand": [
                            "mist_prune_pyir.py"
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "inputBinding": {
                                    "position": 0
                                },
                                "id": "#VDJ_Annotate_Reads.cwl/PrunePyIR/PrunePyIRInner/PyIROutput"
                            }
                        ],
                        "outputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "outputBinding": {
                                    "glob": "*_pruned.csv.gz"
                                },
                                "id": "#VDJ_Annotate_Reads.cwl/PrunePyIR/PrunePyIRInner/PrunedPyIROutput"
                            }
                        ]
                    },
                    "in": [
                        {
                            "source": "#VDJ_Annotate_Reads.cwl/CallCdr3/Cdr3Call",
                            "id": "#VDJ_Annotate_Reads.cwl/PrunePyIR/PyIROutput"
                        }
                    ],
                    "out": [
                        "#VDJ_Annotate_Reads.cwl/PrunePyIR/PrunedPyIROutput"
                    ],
                    "id": "#VDJ_Annotate_Reads.cwl/PrunePyIR"
                }
            ],
            "id": "#VDJ_Annotate_Reads.cwl"
        },
        {
            "doc": "VDJ_GatherCalls collect the outputs from the multi-processed VDJ step into one file.\n",
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        {
                            "type": "array",
                            "items": [
                                "null",
                                "File"
                            ]
                        }
                    ],
                    "id": "#VDJ_GatherCalls.cwl/theCalls"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/gatheredCalls",
                    "id": "#VDJ_GatherCalls.cwl/gatheredCalls"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": "#VDJ_GatherCalls.cwl/theCalls",
                            "id": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/theCalls"
                        }
                    ],
                    "out": [
                        "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/gatheredCalls"
                    ],
                    "run": {
                        "id": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/gather_PyIR",
                        "cwlVersion": "v1.0",
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            },
                            {
                                "class": "InlineJavascriptRequirement"
                            },
                            {
                                "class": "ShellCommandRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": [
                                    {
                                        "type": "array",
                                        "items": [
                                            "null",
                                            "File"
                                        ]
                                    }
                                ],
                                "id": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/gather_PyIR/theCalls"
                            }
                        ],
                        "arguments": [
                            {
                                "shellQuote": false,
                                "valueFrom": "${\n  if (!inputs.theCalls[0] ) {\n    return (\"echo \\\"No outputs from PyIR detected in VDJ_GatherCalls\\\"\")\n  }\n  var inputFiles = \"\"\n  if (!inputs.theCalls[0].path.split(\"_PrunePyIR\")[1]){\n    inputFiles = \"zcat\"\n    for (var i = 0; i < inputs.theCalls.length; i++) {\n      inputFiles += \" \" + inputs.theCalls[i].path\n    }\n    inputFiles += \" | \"\n  } else {\n    inputFiles = \"zcat \" + inputs.theCalls[0].path.split(\"VDJ\")[0] + \"*\" + inputs.theCalls[0].path.split(\"_PrunePyIR\")[1].split(\"_Number_\")[0] + \"_Number_*.csv.gz | \"\n  }\n  var outputFileName = \"\\\"gzip > \" + inputs.theCalls[0].nameroot.split(\"_Number_\")[0] + \"_constant_region_called_pruned.csv.gz\" + \"\\\"\"\n  var awkCommand =  \"awk \\'NR==1{F=$1;print | \" + outputFileName + \" } $1!=F { print | \" + outputFileName + \" }\\' \"\n  var outputCommand = inputFiles + awkCommand\n  return (outputCommand)\n}"
                            }
                        ],
                        "outputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "outputBinding": {
                                    "glob": "*_constant_region_called_pruned.csv.gz",
                                    "outputEval": "${\n  if (self.size == 0) {\n    throw(\"No outputs from PyIR detected in VDJ_GatherCalls!\");\n  } else {\n    return(self);\n  }\n}"
                                },
                                "id": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls/gather_PyIR/gatheredCalls"
                            }
                        ]
                    },
                    "id": "#VDJ_GatherCalls.cwl/VDJ_GatherCalls"
                }
            ],
            "id": "#VDJ_GatherCalls.cwl"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#VDJ_Settings.cwl/_VDJ_JGene_Evalue"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#VDJ_Settings.cwl/_VDJ_VGene_Evalue"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#hs",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mm",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version_User_Facing.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#VDJ_Settings.cwl/_VDJ_Version"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#VDJ_Settings.cwl/VDJ_JGene_Evalue"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "id": "#VDJ_Settings.cwl/VDJ_VGene_Evalue"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#VDJ_Settings.cwl/VDJ_Version"
                }
            ],
            "expression": "${\n  var vdjVersion = null;\n  if (!inputs._VDJ_Version) {\n    vdjVersion = null;}\n  else {\n    var _VDJ_Version = inputs._VDJ_Version.toLowerCase();\n    if (_VDJ_Version === \"human\" || _VDJ_Version === \"hs\" || _VDJ_Version === \"human vdj - bcr and tcr\") {\n      vdjVersion = \"human\";\n    } else if (_VDJ_Version === \"humanbcr\" || _VDJ_Version === \"human vdj - bcr only\") {\n      vdjVersion = \"humanBCR\";\n    } else if (_VDJ_Version === \"humantcr\" || _VDJ_Version === \"human vdj - tcr only\") {\n      vdjVersion = \"humanTCR\";\n    } else if (_VDJ_Version === \"mouse\" || _VDJ_Version === \"mm\" || _VDJ_Version === \"mouse vdj - bcr and tcr\") {\n      vdjVersion = \"mouse\";\n    } else if (_VDJ_Version === \"mousebcr\" || _VDJ_Version === \"mouse vdj - bcr only\") {\n      vdjVersion = \"mouseBCR\";\n    } else if (_VDJ_Version === \"humantcr\" || _VDJ_Version === \"mouse vdj - tcr only\") {\n      vdjVersion = \"mouseTCR\";\n    } else {\n      vdjVersion = inputs._VDJ_Version;\n    }\n  }\n\n  return ({\n  VDJ_VGene_Evalue: inputs._VDJ_VGene_Evalue,\n  VDJ_JGene_Evalue: inputs._VDJ_JGene_Evalue,\n  VDJ_Version: vdjVersion,\n\n  })\n}",
            "id": "#VDJ_Settings.cwl"
        },
        {
            "doc": "VDJ_SplitValidReads splits fasta files to be multi-processed in the VDJ step.\n",
            "class": "Workflow",
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 36,
                    "id": "#VDJ_SplitValidReads.cwl/num_fasta"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#VDJ_SplitValidReads.cwl/validReads"
                }
            ],
            "outputs": [
                {
                    "type": [
                        {
                            "type": "array",
                            "items": [
                                "null",
                                "File"
                            ]
                        }
                    ],
                    "outputSource": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/fastaList",
                    "id": "#VDJ_SplitValidReads.cwl/SplitFastaList"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/log",
                    "id": "#VDJ_SplitValidReads.cwl/log"
                },
                {
                    "type": "int",
                    "outputSource": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/numFiles",
                    "id": "#VDJ_SplitValidReads.cwl/numFiles"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": "#VDJ_SplitValidReads.cwl/num_fasta",
                            "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/num_fasta"
                        },
                        {
                            "source": "#VDJ_SplitValidReads.cwl/validReads",
                            "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/validReads"
                        }
                    ],
                    "out": [
                        "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/fastaList",
                        "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/numFiles",
                        "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/log"
                    ],
                    "run": {
                        "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta",
                        "class": "CommandLineTool",
                        "cwlVersion": "v1.0",
                        "hints": [
                            {
                                "outputDirType": "keep_output_dir",
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ],
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.9-beta",
                                "class": "DockerRequirement"
                            }
                        ],
                        "baseCommand": [
                            "mist_split_fasta.py"
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "int"
                                ],
                                "inputBinding": {
                                    "prefix": "--num-fasta"
                                },
                                "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta/num_fasta"
                            },
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "inputBinding": {
                                    "prefix": "--fasta-file-path"
                                },
                                "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta/validReads"
                            }
                        ],
                        "outputs": [
                            {
                                "type": [
                                    {
                                        "type": "array",
                                        "items": [
                                            "null",
                                            "File"
                                        ]
                                    }
                                ],
                                "outputBinding": {
                                    "glob": "*_split.fasta.gz",
                                    "outputEval": "${ if (self.length === 0) { return [inputs.validReads]; } else { return self; } }"
                                },
                                "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta/fastaList"
                            },
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "outputBinding": {
                                    "glob": "*.log"
                                },
                                "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta/log"
                            },
                            {
                                "type": "int",
                                "outputBinding": {
                                    "glob": "*_split.fasta.gz",
                                    "outputEval": "${ return(parseInt(self.length)); }"
                                },
                                "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads/split_fasta/numFiles"
                            }
                        ]
                    },
                    "id": "#VDJ_SplitValidReads.cwl/VDJ_SplitValidReads"
                }
            ],
            "id": "#VDJ_SplitValidReads.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#VDJ_ig.cwl/VDJ_Version"
                },
                {
                    "type": "int",
                    "id": "#VDJ_ig.cwl/numFiles"
                },
                {
                    "doc": ".fasta.gz",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#VDJ_ig.cwl/validReadsIg"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#VDJ_ig.cwl/CallCdr3ForIgs/Cdr3Call",
                    "id": "#VDJ_ig.cwl/igCalls"
                }
            ],
            "steps": [
                {
                    "hints": [
                        {
                            "class": "ResourceRequirement",
                            "coresMin": "$(inputs.numFiles)"
                        }
                    ],
                    "run": "#VDJ_Annotate_Reads.cwl",
                    "in": [
                        {
                            "source": "#VDJ_ig.cwl/validReadsIg",
                            "id": "#VDJ_ig.cwl/CallCdr3ForIgs/Cdr3QueryFasta"
                        },
                        {
                            "valueFrom": "Ig",
                            "id": "#VDJ_ig.cwl/CallCdr3ForIgs/vdjType"
                        },
                        {
                            "source": "#VDJ_ig.cwl/VDJ_Version",
                            "id": "#VDJ_ig.cwl/CallCdr3ForIgs/vdjVersion"
                        }
                    ],
                    "out": [
                        "#VDJ_ig.cwl/CallCdr3ForIgs/Cdr3Call"
                    ],
                    "id": "#VDJ_ig.cwl/CallCdr3ForIgs"
                }
            ],
            "id": "#VDJ_ig.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#human",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#humanTCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouse",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseBCR",
                                "file:///Users/aronlau/PycharmProjects/mist/dist/local_Targeted/VDJ_Version.enum#mouseTCR"
                            ]
                        }
                    ],
                    "id": "#VDJ_tcr.cwl/VDJ_Version"
                },
                {
                    "type": "int",
                    "id": "#VDJ_tcr.cwl/numFiles"
                },
                {
                    "doc": ".fasta.gz",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#VDJ_tcr.cwl/validReadsTcr"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#VDJ_tcr.cwl/CallCdr3ForTcrs/Cdr3Call",
                    "id": "#VDJ_tcr.cwl/tcrCalls"
                }
            ],
            "steps": [
                {
                    "hints": [
                        {
                            "class": "ResourceRequirement",
                            "coresMin": "$(inputs.numFiles)"
                        }
                    ],
                    "run": "#VDJ_Annotate_Reads.cwl",
                    "in": [
                        {
                            "source": "#VDJ_tcr.cwl/validReadsTcr",
                            "id": "#VDJ_tcr.cwl/CallCdr3ForTcrs/Cdr3QueryFasta"
                        },
                        {
                            "valueFrom": "TCR",
                            "id": "#VDJ_tcr.cwl/CallCdr3ForTcrs/vdjType"
                        },
                        {
                            "source": "#VDJ_tcr.cwl/VDJ_Version",
                            "id": "#VDJ_tcr.cwl/CallCdr3ForTcrs/vdjVersion"
                        }
                    ],
                    "out": [
                        "#VDJ_tcr.cwl/CallCdr3ForTcrs/Cdr3Call"
                    ],
                    "id": "#VDJ_tcr.cwl/CallCdr3ForTcrs"
                }
            ],
            "id": "#VDJ_tcr.cwl"
        }
    ],
    "cwlVersion": "v1.0",
    "$namespaces": {
        "sbg": "https://sevenbridges.com#",
        "arv": "http://arvados.org/cwl#"
    }
}