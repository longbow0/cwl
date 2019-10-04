#!/usr/bin/env cwl-runner
{
    "cwlVersion": "v1.0", 
    "$namespaces": {
        "sbg": "https://sevenbridges.com#", 
        "arv": "http://arvados.org/cwl#"
    }, 
    "$graph": [
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--annot-r1", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AddtoBam.cwl/Annotation_R1"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--data-tables", 
                        "itemSeparator": ","
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#AddtoBam.cwl/Data_Tables"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--annot-mol-file"
                    }, 
                    "type": "File", 
                    "id": "#AddtoBam.cwl/Molecular_Annotation"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--r2-bam"
                    }, 
                    "type": "File", 
                    "id": "#AddtoBam.cwl/R2_Bam"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    }, 
                    "type": "File", 
                    "id": "#AddtoBam.cwl/Seq_Metrics"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--tag-calls"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#AddtoBam.cwl/Tag_Calls"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "Annotated_mapping_R2.BAM"
                    }, 
                    "type": "File", 
                    "id": "#AddtoBam.cwl/Annotated_Bam"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#AddtoBam.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_add_to_bam.py"
            ], 
            "class": "CommandLineTool", 
            "$namespaces": {
                "sbg": "https://sevenbridges.com"
            }, 
            "id": "#AddtoBam.cwl", 
            "hints": [
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "r4.16xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--umi-option"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateMolecules.cwl/AbSeq_UMI"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--num-bc"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateMolecules.cwl/Barcode_Num"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--use-dbec"
                    }, 
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "id": "#AnnotateMolecules.cwl/Use_DBEC"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--valid-annot"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateMolecules.cwl/Valids"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*_GeneStatus.csv.*"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateMolecules.cwl/Gene_Status_List"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_Annotation_Molecule.csv.*"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateMolecules.cwl/Mol_Annot_List"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateMolecules.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_annotate_molecules.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#AnnotateMolecules.cwl", 
            "hints": [
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--label-version"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateR1.cwl/Label_Version"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--R1"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR1.cwl/R1"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*_Annotation_R1.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR1.cwl/Annotation_R1"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR1.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_annotate_R1.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#AnnotateR1.cwl", 
            "hints": [
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }, 
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "c5.18xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--extra-seqs"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#AnnotateR2.cwl/Extra_Seqs"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--index", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateR2.cwl/Index"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--R2"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR2.cwl/R2"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "envDef": [
                        {
                            "envName": "CORES_ALLOCATED_PER_CWL_PROCESS", 
                            "envValue": "$(String(runtime.cores))"
                        }
                    ], 
                    "class": "EnvVarRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*Annotation_R2.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR2.cwl/Annot_R2"
                }, 
                {
                    "outputBinding": {
                        "glob": "*-annot.gtf"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#AnnotateR2.cwl/GTF"
                }, 
                {
                    "outputBinding": {
                        "glob": "*mapping_R2.BAM"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR2.cwl/R2_Bam"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_picard_quality_metrics.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR2.cwl/R2_Quality_Metrics"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateR2.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_annotate_R2.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#AnnotateR2.cwl", 
            "hints": [
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }, 
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "r4.16xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--umi-option"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateReads.cwl/AbSeq_UMI"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--bam-input"
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#AnnotateReads.cwl/Bam_Input"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--extra-seqs", 
                        "itemSeparator": ","
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#AnnotateReads.cwl/Extra_Seqs"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--filtering-stats", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": [
                            "null", 
                            "File"
                        ], 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/Filter_Metrics"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--index", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/Index"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--label-version"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateReads.cwl/Label_Version"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#AnnotateReads.cwl/Putative_Cell_Call"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--annotR1", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/R1_Annotation"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--annotR2", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/R2_Annotation"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--r2-quality-metrics", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/R2_Quality_Metrics"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--reference-panel-names"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateReads.cwl/Reference_Panel_Names"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--sample-tags-version"
                    }, 
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "id": "#AnnotateReads.cwl/Sample_Tags_Version"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--subsample-tags"
                    }, 
                    "type": [
                        "null", 
                        "float"
                    ], 
                    "id": "#AnnotateReads.cwl/Subsample_Tags"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*_Annotation_Read.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateReads.cwl/Annotation_Read"
                }, 
                {
                    "outputBinding": {
                        "glob": "metadata.json", 
                        "loadContents": true, 
                        "outputEval": "$(JSON.parse(self[0].contents).is_trueno)"
                    }, 
                    "type": "boolean", 
                    "id": "#AnnotateReads.cwl/Is_Trueno"
                }, 
                {
                    "outputBinding": {
                        "glob": "metadata.json", 
                        "loadContents": true, 
                        "outputEval": "$(JSON.parse(self[0].contents).sample)"
                    }, 
                    "type": "string", 
                    "id": "#AnnotateReads.cwl/Sample_Name"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_SeqMetrics.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateReads.cwl/Seq_Metrics"
                }, 
                {
                    "outputBinding": {
                        "glob": "*Sorted_Valid_Reads.csv.*"
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#AnnotateReads.cwl/Valid_Reads"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#AnnotateReads.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_annotate_reads.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#AnnotateReads.cwl", 
            "hints": [
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#BundleLogs.cwl/log_files"
                }
            ], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }, 
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ], 
            "outputs": [
                {
                    "type": "Directory", 
                    "id": "#BundleLogs.cwl/logs_dir"
                }
            ], 
            "class": "ExpressionTool", 
            "expression": "${\n  /* shamelly cribbed from https://gist.github.com/jcxplorer/823878 */\n  function uuid() {\n    var uuid = \"\", i, random;\n    for (i = 0; i < 32; i++) {\n      random = Math.random() * 16 | 0;\n      if (i == 8 || i == 12 || i == 16 || i == 20) {\n        uuid += \"-\";\n      }\n      uuid += (i == 12 ? 4 : (i == 16 ? (random & 3 | 8) : random)).toString(16);\n    }\n    return uuid;\n  }\n  var listing = [];\n  for (var i = 0; i < inputs.log_files.length; i++) {\n    var log_file = inputs.log_files[i];\n    log_file.basename = uuid() + \"-\" + log_file.basename;\n    listing.push(log_file);\n  }\n  return ({\n    logs_dir: {\n      class: \"Directory\",\n      basename: \"Logs\",\n      listing: listing\n    }\n  });\n}", 
            "id": "#BundleLogs.cwl"
        }, 
        {
            "inputs": [
                {
                    "doc": "The minimum size (megabytes) of a file that should get split into chunks of a size designated in NumRecordsPerSplit\n", 
                    "inputBinding": {
                        "prefix": "--min-split-size"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#CheckFastqs.cwl/MinChunkSize"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--reads", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#CheckFastqs.cwl/Reads"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--subsample"
                    }, 
                    "type": [
                        "null", 
                        "float"
                    ], 
                    "id": "#CheckFastqs.cwl/Subsample"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--subsample-seed"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#CheckFastqs.cwl/UserInputSubsampleSeed"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "files_to_skip_split_and_subsample.json", 
                        "loadContents": true, 
                        "outputEval": "$(JSON.parse(self[0].contents).files_to_skip_split_and_subsample)\n"
                    }, 
                    "type": {
                        "items": "string", 
                        "type": "array"
                    }, 
                    "id": "#CheckFastqs.cwl/FilesToSkipSplitAndSubsample"
                }, 
                {
                    "outputBinding": {
                        "glob": "subsampling_info.json", 
                        "loadContents": true, 
                        "outputEval": "$(JSON.parse(self[0].contents).subsampling_seed)\n"
                    }, 
                    "type": "int", 
                    "id": "#CheckFastqs.cwl/SubsampleSeed"
                }, 
                {
                    "outputBinding": {
                        "glob": "subsampling_info.json", 
                        "loadContents": true, 
                        "outputEval": "$(JSON.parse(self[0].contents).subsampling_ratio)\n"
                    }, 
                    "type": "float", 
                    "id": "#CheckFastqs.cwl/SubsamplingRatio"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#CheckFastqs.cwl/log"
                }
            ], 
            "baseCommand": [
                "mist_check_fastqs.py"
            ], 
            "class": "CommandLineTool", 
            "doc": "CheckFastqs does several quality control routines including: (1) ensuring that read pair file names are formatted correctly and contain a read pair mate; (2) disambiguating the \"Subsample Reads\" input and; (3) if not provided, generating a subsampling seed that the downstream instances can use.\n", 
            "id": "#CheckFastqs.cwl"
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--abseq-reference"
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#CheckReference.cwl/AbSeq_Reference"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--label-version"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#CheckReference.cwl/Label_Version"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#CheckReference.cwl/Putative_Cell_Call"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--reference", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#CheckReference.cwl/Reference"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--sample-tags-version"
                    }, 
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "id": "#CheckReference.cwl/Sample_Tags_Version"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "combined_extra_seq.fasta"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#CheckReference.cwl/Extra_Seqs"
                }, 
                {
                    "outputBinding": {
                        "glob": "full-gene-list.json"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#CheckReference.cwl/Full_Genes"
                }, 
                {
                    "outputBinding": {
                        "glob": "*-annot.*", 
                        "outputEval": "${\n    if (self.length == 1) { // Targeted\n        return self;\n    } else if (self.length == 0){ // WTA\n        return inputs.Reference;\n    }\n}\n"
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#CheckReference.cwl/Index"
                }, 
                {
                    "outputBinding": {
                        "glob": "reference_panel_names.json"
                    }, 
                    "type": "File", 
                    "id": "#CheckReference.cwl/Reference_Panel_Names"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#CheckReference.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_check_references.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#CheckReference.cwl"
        }, 
        {
            "inputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#FilteredDataTables.cwl/Dense_DataTables"
                }, 
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#FilteredDataTables.cwl/Dense_DataTables_Unfiltered"
                }
            ], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#FilteredDataTables.cwl/Data_Tables"
                }
            ], 
            "class": "ExpressionTool", 
            "expression": "${\n  var keep_datatable = [];\n  if (inputs.Dense_DataTables_Unfiltered.length > 2) {\n    return {'Data_Tables': inputs.Dense_DataTables};\n  }\n  for (var i = 0; i < inputs.Dense_DataTables.length; i++) {\n    if (inputs.Dense_DataTables[i].basename.indexOf('RSEC') !== -1) {\n      keep_datatable.push(inputs.Dense_DataTables[i]);\n    }\n  }\n  return {'Data_Tables': keep_datatable};\n}", 
            "id": "#FilteredDataTables.cwl"
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--basic-algo-only"
                    }, 
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "id": "#GetDataTable.cwl/Basic_Algo_Only"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--exact-cell-count"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#GetDataTable.cwl/Exact_Cell_Count"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--full-gene-list"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/Full_Genes"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--gene-status", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#GetDataTable.cwl/Gene_Status_List"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--mol-annot", 
                        "itemSeparator": ","
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#GetDataTable.cwl/Molecule_Annotation_List"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--putative-cell-call"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#GetDataTable.cwl/Putative_Cell_Call"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Seq_Metrics"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--tag-names", 
                        "itemSeparator": ","
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "string", 
                            "type": "array"
                        }
                    ], 
                    "id": "#GetDataTable.cwl/Tag_Names"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "metrics-files.tar.gz"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Annot_Files"
                }, 
                {
                    "outputBinding": {
                        "glob": "Cell_Label_Filtering/*.png"
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#GetDataTable.cwl/Cell_Label_Filter"
                }, 
                {
                    "outputBinding": {
                        "glob": "cell_order.json"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Cell_Order"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_Expression_Data.st.gz"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Expression_Data"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_Expression_Data_Unfiltered.st.gz"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/Expression_Data_Unfiltered"
                }, 
                {
                    "outputBinding": {
                        "glob": "gene_list.json"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Gene_List"
                }, 
                {
                    "outputBinding": {
                        "glob": "Annotations/*_Annotation_Molecule.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/Molecular_Annotation"
                }, 
                {
                    "outputBinding": {
                        "glob": "Cell_Label_Filtering/*_Putative_Cells_Origin.csv"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/Putative_Cells_Origin"
                }, 
                {
                    "outputBinding": {
                        "glob": "*PerCell_Sparse.csv.gz"
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#GetDataTable.cwl/Sparse_Data_Tables"
                }, 
                {
                    "outputBinding": {
                        "glob": "*RSEC*PerCell_Unfiltered_Sparse.csv.gz"
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#GetDataTable.cwl/Sparse_Data_Tables_Unfiltered"
                }, 
                {
                    "outputBinding": {
                        "glob": "Annotations/*_Annotation_Molecule_Trueno.csv"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/Tag_Annotation"
                }, 
                {
                    "outputBinding": {
                        "glob": "Trueno/*_Calls.csv"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/Tag_Calls"
                }, 
                {
                    "outputBinding": {
                        "glob": "Trueno/*"
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#GetDataTable.cwl/Trueno_out"
                }, 
                {
                    "outputBinding": {
                        "glob": "Annotations/*_UMI_Adjusted_CellLabel_Stats.csv"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/UMI_Adjusted_CellLabel_Stats"
                }, 
                {
                    "outputBinding": {
                        "glob": "Annotations/*_UMI_Adjusted_Stats.csv"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#GetDataTable.cwl/UMI_Adjusted_Stats"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#GetDataTable.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_get_datatables.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#GetDataTable.cwl", 
            "hints": [
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "r5.2xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "position": 1
                    }, 
                    "type": "File", 
                    "id": "#IndexBAM.cwl/BamFile"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "stdout": "samtools_index.log", 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*.bai"
                    }, 
                    "type": "File", 
                    "id": "#IndexBAM.cwl/Index"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#IndexBAM.cwl/log"
                }
            ], 
            "baseCommand": [
                "samtools", 
                "index"
            ], 
            "class": "CommandLineTool", 
            "arguments": [
                {
                    "position": 2, 
                    "valueFrom": "${\n    return inputs.BamFile.basename + \".bai\"\n}"
                }
            ], 
            "id": "#IndexBAM.cwl", 
            "hints": [
                {
                    "outputDirType": "keep_output_dir", 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }
            ]
        }, 
        {
            "inputs": [], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
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
            "class": "ExpressionTool", 
            "expression": "${\n  var internalInputs = [\n    '_Label_Version',\n    '_Read_Filter_Off',\n    '_Barcode_Num',\n    '_Seq_Run',\n    '_AbSeq_UMI',\n    '_Putative_Cell_Call',\n    '_Use_DBEC',\n    '_Extra_Seqs',\n    '_MinChunkSize',\n    '_NumRecordsPerSplit',\n  ];\n  var internalOutputs = {}\n  for (var i = 0; i < internalInputs.length; i++) {\n    var internalInput = internalInputs[i];\n    var internalOutput = internalInput.slice(1); // remove leading underscore\n    if (inputs.hasOwnProperty(internalInput)) {\n      internalOutputs[internalOutput] = inputs[internalInput]; // if input specified, redirect to output\n    } else {\n      internalOutputs[internalOutput] = null; // if input not specified, provide a null\n    }\n  }\n  return internalOutputs;\n}", 
            "id": "#InternalSettings.cwl"
        }, 
        {
            "inputs": [
                {
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#main/AbSeq_Reference", 
                    "label": "AbSeq Reference"
                }, 
                {
                    "doc": "Determine putative cells using only the basic algorithm (minimum second derivative along the cumulative reads curve).  The refined algorithm attempts to remove false positives and recover false negatives, but may not be ideal for certain complex mixtures of cell types.  Does not apply if Exact Cell Count is set.", 
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "id": "#main/Basic_Algo_Only", 
                    "label": "Disable Refined Putative Cell Calling"
                }, 
                {
                    "doc": "Set a specific number (>=1) of cells as putative, based on those with the highest error-corrected read count", 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#main/Exact_Cell_Count", 
                    "label": "Exact Cell Count"
                }, 
                {
                    "label": "Reads", 
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "https://sevenbridges.comfileTypes": "FASTQ.GZ, FQ.GZ", 
                    "id": "#main/Reads"
                }, 
                {
                    "label": "Reference Genome", 
                    "type": "File", 
                    "https://sevenbridges.comfileTypes": "TAR.GZ", 
                    "id": "#main/Reference_Genome"
                }, 
                {
                    "doc": "The sample multiplexing kit version.  This option should only be set for a multiplexed experiment.", 
                    "type": [
                        "null", 
                        {
                            "symbols": [
                                "#main/Sample_Tags_Version/Sample_Tags_Version/human", 
                                "#main/Sample_Tags_Version/Sample_Tags_Version/hs", 
                                "#main/Sample_Tags_Version/Sample_Tags_Version/mouse", 
                                "#main/Sample_Tags_Version/Sample_Tags_Version/mm", 
                                "#main/Sample_Tags_Version/Sample_Tags_Version/custom"
                            ], 
                            "type": "enum", 
                            "name": "#main/Sample_Tags_Version/Sample_Tags_Version"
                        }
                    ], 
                    "id": "#main/Sample_Tags_Version", 
                    "label": "Sample Tags Version"
                }, 
                {
                    "doc": "Any number of reads >1 or a fraction between 0 < n < 1 to indicate the percentage of reads to subsample.\n", 
                    "type": [
                        "null", 
                        "float"
                    ], 
                    "id": "#main/Subsample", 
                    "label": "Subsample Reads"
                }, 
                {
                    "doc": "Any number of reads > 1 or a fraction between 0 < n < 1 to indicate the percentage of tag reads to subsample.\n", 
                    "type": [
                        "null", 
                        "float"
                    ], 
                    "id": "#main/Subsample_Tags", 
                    "label": "Subsample Sample Tags"
                }, 
                {
                    "doc": "For use when replicating a previous subsampling run only. Obtain the seed generated from the log file for the SplitFastQ node.\n", 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#main/Subsample_seed", 
                    "label": "Subsample Seed"
                }, 
                {
                    "doc": "Specify the Sample Tag number followed by - (hyphen) and a sample name to appear in the output files. For example: 4-Ramos. Do not use the special characters: &, (), [], {}, <>, ?, |\n", 
                    "type": [
                        "null", 
                        {
                            "items": "string", 
                            "type": "array"
                        }
                    ], 
                    "id": "#main/Tag_Names", 
                    "label": "Tag Names"
                }, 
                {
                    "label": "Transcriptome Annotation", 
                    "type": "File", 
                    "https://sevenbridges.comfileTypes": "GTF", 
                    "id": "#main/Transcriptome_Annotation"
                }
            ], 
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
                }
            ], 
            "outputs": [
                {
                    "type": "File", 
                    "outputSource": "#main/IndexBAM/Index", 
                    "id": "#main/Bam_Index", 
                    "label": "Bam Index"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "outputSource": "#main/GetDataTable/Cell_Label_Filter", 
                    "id": "#main/Cell_Label_Filter", 
                    "label": "Cell Label Filter"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "outputSource": "#main/Uncompress_Datatables/Uncompressed_Data_Tables", 
                    "id": "#main/Data_Tables", 
                    "label": "Data Tables"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "outputSource": "#main/Sparse_to_Dense_Datatable_Unfiltered/Data_Tables", 
                    "id": "#main/Data_Tables_Unfiltered", 
                    "label": "Unfiltered Data Tables"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputSource": "#main/Uncompress_Datatables/Uncompressed_Expression_Matrix", 
                    "id": "#main/Expression_Data", 
                    "label": "Expression Matrix"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputSource": "#main/GetDataTable/Expression_Data_Unfiltered", 
                    "id": "#main/Expression_Data_Unfiltered", 
                    "label": "Unfiltered Expression Matrix"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/MergeBAM/Final_Bam", 
                    "id": "#main/Final_Bam", 
                    "label": "Final BAM File"
                }, 
                {
                    "type": "Directory", 
                    "outputSource": "#main/BundleLogs/logs_dir", 
                    "id": "#main/Logs", 
                    "label": "Pipeline Logs"
                }, 
                {
                    "type": "File", 
                    "outputSource": "#main/Metrics/Metrics_Summary", 
                    "id": "#main/Metrics_Summary", 
                    "label": "Metrics Summary"
                }, 
                {
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "outputSource": "#main/GetDataTable/Trueno_out", 
                    "id": "#main/Multiplex"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputSource": "#main/GetDataTable/Putative_Cells_Origin", 
                    "id": "#main/Putative_Cells_Origin", 
                    "label": "Putative Cells Origin"
                }, 
                {
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "outputSource": "#main/GetDataTable/UMI_Adjusted_Stats", 
                    "id": "#main/UMI_Adjusted_Stats", 
                    "label": "UMI Adjusted Statistics"
                }
            ], 
            "class": "Workflow", 
            "label": "BD Rhapsody\u2122 WTA Analysis Pipeline", 
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
                    "scatter": [
                        "#main/AddtoBam/R2_Bam"
                    ], 
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
                    "run": "#AddtoBam.cwl", 
                    "id": "#main/AddtoBam", 
                    "out": [
                        "#main/AddtoBam/Annotated_Bam", 
                        "#main/AddtoBam/output"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 32000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
                    "scatter": [
                        "#main/AnnotateMolecules/Valids"
                    ], 
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
                    "run": "#AnnotateMolecules.cwl", 
                    "id": "#main/AnnotateMolecules", 
                    "out": [
                        "#main/AnnotateMolecules/Mol_Annot_List", 
                        "#main/AnnotateMolecules/Gene_Status_List", 
                        "#main/AnnotateMolecules/output"
                    ]
                }, 
                {
                    "scatter": [
                        "#main/AnnotateR1/R1"
                    ], 
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
                    "run": "#AnnotateR1.cwl", 
                    "id": "#main/AnnotateR1", 
                    "out": [
                        "#main/AnnotateR1/Annotation_R1", 
                        "#main/AnnotateR1/output"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "coresMin": 6, 
                            "ramMin": 48000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
                    "scatter": [
                        "#main/AnnotateR2/R2"
                    ], 
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
                        }
                    ], 
                    "run": "#AnnotateR2.cwl", 
                    "id": "#main/AnnotateR2", 
                    "out": [
                        "#main/AnnotateR2/Annot_R2", 
                        "#main/AnnotateR2/R2_Bam", 
                        "#main/AnnotateR2/GTF", 
                        "#main/AnnotateR2/output", 
                        "#main/AnnotateR2/R2_Quality_Metrics"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 32000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
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
                        }
                    ], 
                    "run": "#AnnotateReads.cwl", 
                    "id": "#main/AnnotateReads", 
                    "out": [
                        "#main/AnnotateReads/Seq_Metrics", 
                        "#main/AnnotateReads/Valid_Reads", 
                        "#main/AnnotateReads/Annotation_Read", 
                        "#main/AnnotateReads/Is_Trueno", 
                        "#main/AnnotateReads/Sample_Name", 
                        "#main/AnnotateReads/output"
                    ]
                }, 
                {
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
                                "#main/IndexBAM/log"
                            ], 
                            "linkMerge": "merge_flattened", 
                            "id": "#main/BundleLogs/log_files"
                        }
                    ], 
                    "run": "#BundleLogs.cwl", 
                    "id": "#main/BundleLogs", 
                    "out": [
                        "#main/BundleLogs/logs_dir"
                    ]
                }, 
                {
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
                    "run": "#CheckFastqs.cwl", 
                    "id": "#main/CheckFastqs", 
                    "out": [
                        "#main/CheckFastqs/SubsampleSeed", 
                        "#main/CheckFastqs/SubsamplingRatio", 
                        "#main/CheckFastqs/FilesToSkipSplitAndSubsample", 
                        "#main/CheckFastqs/log"
                    ]
                }, 
                {
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
                            "source": [
                                "#main/Transcriptome_Annotation", 
                                "#main/Reference_Genome"
                            ], 
                            "id": "#main/CheckReference/Reference"
                        }, 
                        {
                            "source": "#main/Multiplexing_Settings/Sample_Tags_Version", 
                            "id": "#main/CheckReference/Sample_Tags_Version"
                        }
                    ], 
                    "run": "#CheckReference.cwl", 
                    "id": "#main/CheckReference", 
                    "out": [
                        "#main/CheckReference/Index", 
                        "#main/CheckReference/Extra_Seqs", 
                        "#main/CheckReference/Reference_Panel_Names", 
                        "#main/CheckReference/Full_Genes", 
                        "#main/CheckReference/output"
                    ]
                }, 
                {
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
                    "run": "#FilteredDataTables.cwl", 
                    "id": "#main/FilteredDataTables", 
                    "out": [
                        "#main/FilteredDataTables/Data_Tables"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 64000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
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
                    "run": "#GetDataTable.cwl", 
                    "id": "#main/GetDataTable", 
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
                    ]
                }, 
                {
                    "in": [
                        {
                            "source": "#main/MergeBAM/Final_Bam", 
                            "id": "#main/IndexBAM/BamFile"
                        }
                    ], 
                    "run": "#IndexBAM.cwl", 
                    "id": "#main/IndexBAM", 
                    "out": [
                        "#main/IndexBAM/Index", 
                        "#main/IndexBAM/log"
                    ]
                }, 
                {
                    "label": "Internal Settings", 
                    "in": [], 
                    "run": "#InternalSettings.cwl", 
                    "id": "#main/Internal_Settings", 
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
                    ]
                }, 
                {
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
                    "run": "#MergeBAM.cwl", 
                    "id": "#main/MergeBAM", 
                    "out": [
                        "#main/MergeBAM/Final_Bam", 
                        "#main/MergeBAM/log"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 96000, 
                            "tmpdirMin": 65536, 
                            "outdirMin": 65536, 
                            "class": "ResourceRequirement"
                        }
                    ], 
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
                        }
                    ], 
                    "run": "#Metrics.cwl", 
                    "id": "#main/Metrics", 
                    "out": [
                        "#main/Metrics/Metrics_Summary", 
                        "#main/Metrics/Metrics_Archive", 
                        "#main/Metrics/output"
                    ]
                }, 
                {
                    "label": "Multiplexing Settings", 
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
                    "run": "#MultiplexingSettings.cwl", 
                    "id": "#main/Multiplexing_Settings", 
                    "out": [
                        "#main/Multiplexing_Settings/Subsample_Tags", 
                        "#main/Multiplexing_Settings/Tag_Sample_Names", 
                        "#main/Multiplexing_Settings/Sample_Tags_Version"
                    ]
                }, 
                {
                    "in": [
                        {
                            "source": "#main/SplitAndSubsample/SplitAndSubsampledFastqs", 
                            "id": "#main/PairReadFiles/Reads"
                        }
                    ], 
                    "run": "#PairReadFiles.cwl", 
                    "id": "#main/PairReadFiles", 
                    "out": [
                        "#main/PairReadFiles/ReadPairs"
                    ]
                }, 
                {
                    "label": "Putative Cell Calling Settings", 
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
                    "run": "#PutativeCellSettings.cwl", 
                    "id": "#main/Putative_Cell_Calling_Settings", 
                    "out": [
                        "#main/Putative_Cell_Calling_Settings/Exact_Cell_Count", 
                        "#main/Putative_Cell_Calling_Settings/Basic_Algo_Only"
                    ]
                }, 
                {
                    "run": "#QualityFilter.cwl", 
                    "scatter": [
                        "#main/QualityFilter/Split_Read_Pairs"
                    ], 
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
                    "scatterMethod": "dotproduct", 
                    "id": "#main/QualityFilter", 
                    "out": [
                        "#main/QualityFilter/Filter_Metrics", 
                        "#main/QualityFilter/R1", 
                        "#main/QualityFilter/R2", 
                        "#main/QualityFilter/output"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 4000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
                    "scatter": [
                        "#main/Sparse_to_Dense_Datatable/Sparse_Data_Table"
                    ], 
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
                    "run": "#SparsetoDense.cwl", 
                    "id": "#main/Sparse_to_Dense_Datatable", 
                    "out": [
                        "#main/Sparse_to_Dense_Datatable/Data_Tables", 
                        "#main/Sparse_to_Dense_Datatable/output"
                    ]
                }, 
                {
                    "requirements": [
                        {
                            "ramMin": 4000, 
                            "class": "ResourceRequirement"
                        }
                    ], 
                    "scatter": [
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/Sparse_Data_Table"
                    ], 
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
                    "run": "#SparsetoDense.cwl", 
                    "id": "#main/Sparse_to_Dense_Datatable_Unfiltered", 
                    "out": [
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/Data_Tables", 
                        "#main/Sparse_to_Dense_Datatable_Unfiltered/output"
                    ]
                }, 
                {
                    "in": [
                        {
                            "source": "#main/GetDataTable/Cell_Order", 
                            "id": "#main/Sparse_to_Dense_File/GDT_cell_order"
                        }
                    ], 
                    "run": "#SparsetoDenseFile.cwl", 
                    "id": "#main/Sparse_to_Dense_File", 
                    "out": [
                        "#main/Sparse_to_Dense_File/Cell_Order"
                    ]
                }, 
                {
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
                    "run": "#SplitAndSubsample.cwl", 
                    "id": "#main/SplitAndSubsample", 
                    "out": [
                        "#main/SplitAndSubsample/SplitAndSubsampledFastqs", 
                        "#main/SplitAndSubsample/log"
                    ]
                }, 
                {
                    "label": "Subsample Settings", 
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
                    "run": "#SubsampleSettings.cwl", 
                    "id": "#main/Subsample_Settings", 
                    "out": [
                        "#main/Subsample_Settings/Subsample_Reads", 
                        "#main/Subsample_Settings/Subsample_Seed"
                    ]
                }, 
                {
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
                    "run": "#UncompressDatatables.cwl", 
                    "id": "#main/Uncompress_Datatables", 
                    "out": [
                        "#main/Uncompress_Datatables/Uncompressed_Data_Tables", 
                        "#main/Uncompress_Datatables/Uncompressed_Expression_Matrix"
                    ]
                }
            ], 
            "doc": "The BD Rhapsody\u2122 WTA Analysis Pipeline is used to create sequencing libraries from single cell transcriptomes without having to specify a targeted panel.\n\nAfter sequencing, the analysis pipeline takes the FASTQ files, a reference genome file and a transcriptome annotation file for gene alignment. The pipeline generates molecular counts per cell, read counts per cell, metrics, and an alignment file.", 
            "id": "#main"
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "position": 1
                    }, 
                    "type": {
                        "items": "File", 
                        "type": "array"
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
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "stdout": "samtools_merge.log", 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*_final.BAM"
                    }, 
                    "type": "File", 
                    "id": "#MergeBAM.cwl/Final_Bam"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#MergeBAM.cwl/log"
                }
            ], 
            "baseCommand": [
                "samtools", 
                "merge"
            ], 
            "class": "CommandLineTool", 
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
            "id": "#MergeBAM.cwl", 
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
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--annot-files"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/Annot_Files"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--data-tables", 
                        "itemSeparator": ","
                    }, 
                    "type": [
                        "null", 
                        {
                            "items": "File", 
                            "type": "array"
                        }
                    ], 
                    "id": "#Metrics.cwl/Data_Tables"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--annot-mol-file"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/Molecular_Annotation"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--seq-stats"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/Seq_Metrics"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--seq-run"
                    }, 
                    "type": [
                        "null", 
                        "string"
                    ], 
                    "id": "#Metrics.cwl/Seq_Run"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--tag-annot"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#Metrics.cwl/Tag_Annotation"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--umi-adjusted-stats"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#Metrics.cwl/UMI_Adjusted_Stats"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "internal-metrics-archive.tar.gz"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/Metrics_Archive"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_Metrics_Summary.csv"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/Metrics_Summary"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#Metrics.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_metrics.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#Metrics.cwl", 
            "hints": [
                {
                    "class": "http://arvados.org/cwl#APIRequirement"
                }, 
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }, 
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "r5.4xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "default": "Targeted", 
                    "type": "string", 
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
                            "items": "string", 
                            "type": "array"
                        }
                    ], 
                    "id": "#MultiplexingSettings.cwl/_Tag_Sample_Names"
                }
            ], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
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
                            "items": "string", 
                            "type": "array"
                        }
                    ], 
                    "id": "#MultiplexingSettings.cwl/Tag_Sample_Names"
                }
            ], 
            "class": "ExpressionTool", 
            "expression": "${\n  var enumifiedSampleTagsVersion = null;\n  if (inputs._Sample_Tags_Version) {\n  var _Sample_Tags_Version = inputs._Sample_Tags_Version.toLowerCase();\n  if (_Sample_Tags_Version.indexOf('human') >= 0 || _Sample_Tags_Version === 'hs')\n  {\n    enumifiedSampleTagsVersion = 'hs';\n  }\n  else if (_Sample_Tags_Version.indexOf('mouse') >= 0 || _Sample_Tags_Version === 'mm')\n  {\n    enumifiedSampleTagsVersion = 'mm';\n  }\n  else if (_Sample_Tags_Version === 'no multiplexing')\n  {\n    enumifiedSampleTagsVersion = null;\n  }\n  else\n  {\n    throw new Error(\"Cannot parse Sample Tag Version: \" + inputs._Sample_Tags_Version);\n  }\n  }\n  return ({\n  Subsample_Tags: inputs._Subsample_Tags,\n  Tag_Sample_Names: inputs._Tag_Sample_Names,\n  Sample_Tags_Version: enumifiedSampleTagsVersion\n  });\n}", 
            "id": "#MultiplexingSettings.cwl"
        }, 
        {
            "inputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#PairReadFiles.cwl/Reads"
                }
            ], 
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "items": {
                            "fields": [
                                {
                                    "type": "File", 
                                    "name": "#PairReadFiles.cwl/ReadPairs/R1"
                                }, 
                                {
                                    "type": "File", 
                                    "name": "#PairReadFiles.cwl/ReadPairs/R2"
                                }, 
                                {
                                    "type": "int", 
                                    "name": "#PairReadFiles.cwl/ReadPairs/readPairID"
                                }, 
                                {
                                    "type": "string", 
                                    "name": "#PairReadFiles.cwl/ReadPairs/library"
                                }
                            ], 
                            "type": "record"
                        }, 
                        "type": "array"
                    }, 
                    "id": "#PairReadFiles.cwl/ReadPairs"
                }
            ], 
            "class": "ExpressionTool", 
            "doc": "PairReadsFiles takes an array of split files and pairs them, such that an R1 file is transferred to a QualityFilter with its corresponding R2 file.\nEach file should be formatted as illumina outputs it from basespace: e.g. sample_L001_R1_001.fastq.gz. After being split, that sample file would be an array files named sample_L001_R1_001-00.fastq, sample_L001_R1_001-01.fastq, etc\n", 
            "expression": "${\n  // send paired reads to the same key in readPairs\n  var readPairs = {}\n  for (var i = 0; i < inputs.Reads.length; i++) {\n    var f = inputs.Reads[i];\n\n    // This is the illumina basespace regex. More sophisticated file handling is needed for NovaSeq\n    // example: <SAMPLE>[<SAMPLE NUMBER>][<LANE>]_R<READ FLAG>_001.fastq.gz\n    var groups = f.basename.match(/^(.*?)(_S[0-9]*)?(_L[0-9]*)?(_R[1|2])_001(-[0-9]*)?\\.(.*?)$/);\n    var library = groups[1];\n    var sampleNumber = groups[2];\n    var laneNumber = groups[3];\n    var flag = groups[4];\n    var chunkID = 9999; // if there is no scatter id, use an arbitrary number\n    if (groups[5]){\n      chunkID = parseInt(groups[5].slice(1)); // slice off the '-'\n    }\n\n    // double check we have a chunk id\n    if (chunkID === undefined || chunkID === null) {\n          throw new Error(\"chunkID could not be determined!\");\n    }\n\n    // notice, we ignore the flag. This causes the paired reads to share the same key\n    var readPairID = library + sampleNumber + laneNumber + chunkID\n\n    // sort the information from the filename into an object\n    if (!readPairs[readPairID]) {\n      readPairs[readPairID] = {\n        R1: null,\n        R2: null,\n        library: library,\n        readPairID: null,\n      };\n    }\n    // add in the readPair, depending on the flag\n    if (flag === \"_R1\") {\n      readPairs[readPairID].R1 = f\n    } else if (flag === \"_R2\") {\n      readPairs[readPairID].R2 = f\n    }\n\n  }\n  // we are not interested in the keys in readPairs; flatten into an array of objects\n  var readPairsList = []\n  var i = 1;\n  for (var key in readPairs) {\n    if (readPairs.hasOwnProperty(key)) {\n      var readPair = readPairs[key]\n      readPair.readPairID = i\n      readPairsList.push(readPair)\n      i++;\n    }\n  }\n  // pass this array to the record array named \"ReadPairs\" on the CWL layer\n  return {ReadPairs: readPairsList}\n}", 
            "id": "#PairReadFiles.cwl"
        }, 
        {
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
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
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
            "class": "ExpressionTool", 
            "expression": "${\n  if (inputs._Exact_Cell_Count) {\n    if (inputs._Exact_Cell_Count < 1) {\n      throw(\"Illogical value for exact cell count: \" + inputs._Exact_Cell_Count);\n    }\n  }\n  return ({\n    Exact_Cell_Count: inputs._Exact_Cell_Count,\n    Basic_Algo_Only: inputs._Basic_Algo_Only,\n  });\n}", 
            "id": "#PutativeCellSettings.cwl"
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--label-version"
                    }, 
                    "type": [
                        "null", 
                        "int"
                    ], 
                    "id": "#QualityFilter.cwl/Label_Version"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--read-filter-off"
                    }, 
                    "type": [
                        "null", 
                        "boolean"
                    ], 
                    "id": "#QualityFilter.cwl/Read_Filter_Off"
                }, 
                {
                    "type": {
                        "fields": [
                            {
                                "inputBinding": {
                                    "prefix": "--r1"
                                }, 
                                "type": "File", 
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/R1"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--r2"
                                }, 
                                "type": "File", 
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/R2"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--read-pair-id"
                                }, 
                                "type": "int", 
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/readPairID"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--library"
                                }, 
                                "type": "string", 
                                "name": "#QualityFilter.cwl/Split_Read_Pairs/library"
                            }
                        ], 
                        "type": "record"
                    }, 
                    "id": "#QualityFilter.cwl/Split_Read_Pairs"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*read_quality.csv.gz"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#QualityFilter.cwl/Filter_Metrics"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_R1_.fastq.gz"
                    }, 
                    "type": "File", 
                    "id": "#QualityFilter.cwl/R1"
                }, 
                {
                    "outputBinding": {
                        "glob": "*_R2_.fastq.gz"
                    }, 
                    "type": "File", 
                    "id": "#QualityFilter.cwl/R2"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#QualityFilter.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_quality_filter.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#QualityFilter.cwl", 
            "hints": [
                {
                    "keep_cache": 512, 
                    "class": "http://arvados.org/cwl#RuntimeConstraints"
                }, 
                {
                    "class": "https://sevenbridges.comAWSInstanceType", 
                    "value": "c5.18xlarge"
                }
            ]
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "prefix": "--cell-order"
                    }, 
                    "type": "File", 
                    "id": "#SparsetoDense.cwl/Cell_Order"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--gene-list"
                    }, 
                    "type": "File", 
                    "id": "#SparsetoDense.cwl/Gene_List"
                }, 
                {
                    "inputBinding": {
                        "prefix": "--sparse-data-table"
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#SparsetoDense.cwl/Sparse_Data_Table"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "outputs": [
                {
                    "outputBinding": {
                        "glob": "*.csv.gz"
                    }, 
                    "type": "File", 
                    "id": "#SparsetoDense.cwl/Data_Tables"
                }, 
                {
                    "outputBinding": {
                        "glob": "*.log"
                    }, 
                    "type": "File", 
                    "id": "#SparsetoDense.cwl/output"
                }
            ], 
            "baseCommand": [
                "mist_sparse_to_dense.py"
            ], 
            "class": "CommandLineTool", 
            "id": "#SparsetoDense.cwl"
        }, 
        {
            "inputs": [
                {
                    "inputBinding": {
                        "position": 1
                    }, 
                    "type": [
                        "null", 
                        "File"
                    ], 
                    "id": "#SparsetoDenseFile.cwl/GDT_cell_order"
                }
            ], 
            "requirements": [
                {
                    "dockerPull": "bdgenomics/rhapsody:1.8", 
                    "class": "DockerRequirement"
                }
            ], 
            "stdout": "cell_order.json", 
            "outputs": [
                {
                    "type": "stdout", 
                    "id": "#SparsetoDenseFile.cwl/Cell_Order"
                }
            ], 
            "baseCommand": "cat", 
            "class": "CommandLineTool", 
            "id": "#SparsetoDenseFile.cwl"
        }, 
        {
            "inputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#SplitAndSubsample.cwl/Fastqs"
                }, 
                {
                    "type": {
                        "items": "string", 
                        "type": "array"
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
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }, 
                {
                    "class": "InlineJavascriptRequirement"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "outputSource": "#SplitAndSubsample.cwl/FlattenOutput/SplitFastqList", 
                    "id": "#SplitAndSubsample.cwl/SplitAndSubsampledFastqs"
                }, 
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "outputSource": "#SplitAndSubsample.cwl/SplitAndSubsample/log", 
                    "id": "#SplitAndSubsample.cwl/log"
                }
            ], 
            "class": "Workflow", 
            "steps": [
                {
                    "doc": "After scattering \"SplitAndSubsample\" on a File array, the output of each node is also an array. Thus, we are left with a nestled list. This JS expression flattens this list to deal with the split reads in PairReadFiles.cwl", 
                    "in": [
                        {
                            "source": "#SplitAndSubsample.cwl/SplitAndSubsample/SplitAndSubsampledFastqs", 
                            "id": "#SplitAndSubsample.cwl/FlattenOutput/nestledSplitFastqList"
                        }
                    ], 
                    "run": {
                        "cwlVersion": "v1.0", 
                        "inputs": [
                            {
                                "type": {
                                    "items": {
                                        "items": "File", 
                                        "type": "array"
                                    }, 
                                    "type": "array"
                                }, 
                                "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output/nestledSplitFastqList"
                            }
                        ], 
                        "outputs": [
                            {
                                "type": {
                                    "items": "File", 
                                    "type": "array"
                                }, 
                                "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output/SplitFastqList"
                            }
                        ], 
                        "class": "ExpressionTool", 
                        "expression": "${\n  return {SplitFastqList: [].concat.apply([], inputs.nestledSplitFastqList)}\n}\n", 
                        "id": "#SplitAndSubsample.cwl/FlattenOutput/flatten_output"
                    }, 
                    "id": "#SplitAndSubsample.cwl/FlattenOutput", 
                    "out": [
                        "#SplitAndSubsample.cwl/FlattenOutput/SplitFastqList"
                    ]
                }, 
                {
                    "run": {
                        "cwlVersion": "v1.0", 
                        "inputs": [
                            {
                                "inputBinding": {
                                    "prefix": "--fastq-file-path"
                                }, 
                                "type": "File", 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/Fastq"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--files-to-skip-split-and-subsample", 
                                    "itemSeparator": ","
                                }, 
                                "type": {
                                    "items": "string", 
                                    "type": "array"
                                }, 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/FilesToSkipSplitAndSubsample"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--num-records"
                                }, 
                                "type": [
                                    "null", 
                                    "long"
                                ], 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/NumRecordsPerSplit"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--subsample-ratio"
                                }, 
                                "type": "float", 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SubsampleRatio"
                            }, 
                            {
                                "inputBinding": {
                                    "prefix": "--subsample-seed"
                                }, 
                                "type": "int", 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SubsampleSeed"
                            }
                        ], 
                        "requirements": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.8", 
                                "class": "DockerRequirement"
                            }
                        ], 
                        "outputs": [
                            {
                                "outputBinding": {
                                    "glob": "*.fastq.gz", 
                                    "outputEval": "${ if (self.length === 0) { return [inputs.Fastq]; } else { return self; } }"
                                }, 
                                "type": {
                                    "items": "File", 
                                    "type": "array"
                                }, 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/SplitAndSubsampledFastqs"
                            }, 
                            {
                                "outputBinding": {
                                    "glob": "*.log"
                                }, 
                                "type": "File", 
                                "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq/log"
                            }
                        ], 
                        "baseCommand": [
                            "mist_split_fastq.py"
                        ], 
                        "id": "#SplitAndSubsample.cwl/SplitAndSubsample/split_fastq", 
                        "class": "CommandLineTool", 
                        "hints": [
                            {
                                "outputDirType": "keep_output_dir", 
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ]
                    }, 
                    "doc": "Allocate one docker/python process per file to do the actual file splitting.", 
                    "scatter": [
                        "#SplitAndSubsample.cwl/SplitAndSubsample/Fastq"
                    ], 
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
                    "id": "#SplitAndSubsample.cwl/SplitAndSubsample", 
                    "out": [
                        "#SplitAndSubsample.cwl/SplitAndSubsample/SplitAndSubsampledFastqs", 
                        "#SplitAndSubsample.cwl/SplitAndSubsample/log"
                    ]
                }
            ], 
            "doc": "SplitAndSubsample splits, subsamples and formats read files to be deposited in QualityFilter.\n", 
            "id": "#SplitAndSubsample.cwl"
        }, 
        {
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
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
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
            "class": "ExpressionTool", 
            "expression": "${\n  var subsamplingOutputs = {\n    Subsample_Reads: inputs._Subsample_Reads,\n    Subsample_Seed: inputs._Subsample_Seed\n  }\n  return subsamplingOutputs;\n}", 
            "id": "#SubsampleSettings.cwl"
        }, 
        {
            "inputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
                    }, 
                    "id": "#UncompressDatatables.cwl/Compressed_Data_Table"
                }, 
                {
                    "type": "File", 
                    "id": "#UncompressDatatables.cwl/Compressed_Expression_Matrix"
                }
            ], 
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                }
            ], 
            "outputs": [
                {
                    "type": {
                        "items": "File", 
                        "type": "array"
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
            "class": "Workflow", 
            "steps": [
                {
                    "scatter": [
                        "#UncompressDatatables.cwl/Uncompress_Datatable/Compressed_File"
                    ], 
                    "in": [
                        {
                            "source": "#UncompressDatatables.cwl/Compressed_Data_Table", 
                            "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Compressed_File"
                        }
                    ], 
                    "run": {
                        "cwlVersion": "v1.0", 
                        "inputs": [
                            {
                                "inputBinding": {
                                    "position": 1
                                }, 
                                "type": "File", 
                                "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner/Compressed_File"
                            }
                        ], 
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ], 
                        "stdout": "$(inputs.Compressed_File.nameroot)", 
                        "outputs": [
                            {
                                "outputBinding": {
                                    "glob": "$(inputs.Compressed_File.nameroot)"
                                }, 
                                "type": "File", 
                                "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner/Uncompressed_File"
                            }
                        ], 
                        "baseCommand": [
                            "gunzip"
                        ], 
                        "class": "CommandLineTool", 
                        "arguments": [
                            {
                                "position": 0, 
                                "valueFrom": "-c"
                            }
                        ], 
                        "$namespaces": {
                            "arv": "http://arvados.org/cwl#"
                        }, 
                        "id": "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompress_Datatable_Inner", 
                        "hints": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.8", 
                                "class": "DockerRequirement"
                            }, 
                            {
                                "outputDirType": "keep_output_dir", 
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ]
                    }, 
                    "id": "#UncompressDatatables.cwl/Uncompress_Datatable", 
                    "out": [
                        "#UncompressDatatables.cwl/Uncompress_Datatable/Uncompressed_File"
                    ]
                }, 
                {
                    "in": [
                        {
                            "source": "#UncompressDatatables.cwl/Compressed_Expression_Matrix", 
                            "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Compressed_File"
                        }
                    ], 
                    "run": {
                        "cwlVersion": "v1.0", 
                        "inputs": [
                            {
                                "inputBinding": {
                                    "position": 1
                                }, 
                                "type": "File", 
                                "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner/Compressed_File"
                            }
                        ], 
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ], 
                        "stdout": "$(inputs.Compressed_File.nameroot)", 
                        "outputs": [
                            {
                                "outputBinding": {
                                    "glob": "$(inputs.Compressed_File.nameroot)"
                                }, 
                                "type": "File", 
                                "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner/Uncompressed_File"
                            }
                        ], 
                        "baseCommand": [
                            "gunzip"
                        ], 
                        "class": "CommandLineTool", 
                        "arguments": [
                            {
                                "position": 0, 
                                "valueFrom": "-c"
                            }
                        ], 
                        "$namespaces": {
                            "arv": "http://arvados.org/cwl#"
                        }, 
                        "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompress_Expression_Matrix_Inner", 
                        "hints": [
                            {
                                "dockerPull": "bdgenomics/rhapsody:1.8", 
                                "class": "DockerRequirement"
                            }, 
                            {
                                "outputDirType": "keep_output_dir", 
                                "class": "http://arvados.org/cwl#RuntimeConstraints"
                            }
                        ]
                    }, 
                    "id": "#UncompressDatatables.cwl/Uncompress_Expression_Matrix", 
                    "out": [
                        "#UncompressDatatables.cwl/Uncompress_Expression_Matrix/Uncompressed_File"
                    ]
                }
            ], 
            "id": "#UncompressDatatables.cwl"
        }
    ]
}