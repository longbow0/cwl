cwlVersion: v1.0
class: Workflow
requirements:
- class: ScatterFeatureRequirement
inputs:
  Compressed_Data_Table:
    type: File[]
  Compressed_Expression_Matrix:
    type: File
outputs:
  Uncompressed_Data_Tables:
    type: File[]?
    outputSource: Uncompress_Datatable/Uncompressed_File
  Uncompressed_Expression_Matrix:
    type: File
    outputSource: Uncompress_Expression_Matrix/Uncompressed_File
steps:
  Uncompress_Datatable:
    run: Uncompress.cwl
    in:
      Compressed_File: Compressed_Data_Table
    scatter:
    - Compressed_File
    out:
    - Uncompressed_File
  Uncompress_Expression_Matrix:
    run: Uncompress.cwl
    in:
      Compressed_File: Compressed_Expression_Matrix
    out:
    - Uncompressed_File