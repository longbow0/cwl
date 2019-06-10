# BD Genomics Rhapsody Analysis Pipeline CWL

This repository contains the CWL and YML files necessary to run the BD Genomics Rhapsody Analysis Pipeline locally.

To obtain the files, click on _Downloads_ in the left navigation panel, and then _Download repository_.

For more details on how to use these files, see the BD Genomics Analysis Setup User Guide (Doc ID: 47383).

## v1.02 Release notes - Nov 27, 2017
- Added support for BD Single-cell multiplexing kit - Human
- Improved pipeline speed by deleting large temp files
- Removed network requirement when running locally
- bug fix for the wrong docker image name - Dec 13, 2017

## v1.3 Release notes - July 31, 2018
- Added support for BD™ AbSeq assay
- Added support for BD™ single-cell multiplexing kit - Mouse Immune
- New pipeline input - AbSeq Reference
- New pipeline outputs - Unfiltered cell-gene data tables
- Updated Metrics_Summary.csv to support metrics from multiple sequencing libraries
- Updated Recursive Substitution Error Correction (RSEC) algorithm (minor molecule count changes expected)
- Optimized pipeline to run faster

## v1.5 Release notes - March 14, 2019
- Added support for BD Single-cell multiplexing kit – Mouse Immune
- Updated various filtering thresholds to support sequencing runs with shorter read length
- Deprecated pipeline input – BAM input
- Fixed bug in Quality Filter (minor metrics changes expected)
- Optimized pipeline (computationally faster, more scalable to support larger input data size, and better logging)

## v1.6   June 10, 2019
- Added new options for putative cell determination
- Exact Cell Count - Set a specific number of cells as putative, based on those with the highest error-corrected read count
- Disable Refined Putative Cell Calling - Determine putative cells using only the basic algorithm
- Updated to Python3
- Updated alignment defaults (minor molecule count changes expected)
- Local install only - CWL files are bundled into one file

