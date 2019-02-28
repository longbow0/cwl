cwlVersion: v1.0
class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
inputs:
  _Subsample_Tags:
    type: float?
  _Tag_Sample_Names:
    type: string[]?
  _Sample_Tags_Version:
    type: Any?
  Assay:
    type: string
    default: "Targeted"
outputs:
  Subsample_Tags:
    type: float?
  Tag_Sample_Names:
    type: string[]?
  Sample_Tags_Version:
    type: string?
expression: |-
  ${
    if (inputs.Assay === "Targeted")
    {
      var enumifiedSampleTagsVersion = null;
      if (inputs._Sample_Tags_Version) {
        var _Sample_Tags_Version = inputs._Sample_Tags_Version.toLowerCase();
        if (_Sample_Tags_Version.indexOf('human') >= 0 || _Sample_Tags_Version === 'hs')
        {
          enumifiedSampleTagsVersion = 'hs';
        }
        else if (_Sample_Tags_Version.indexOf('mouse') >= 0 || _Sample_Tags_Version === 'mm')
        {
          enumifiedSampleTagsVersion = 'mm';
        }
        else if (_Sample_Tags_Version === 'No Multiplexing')
        {
          enumifiedSampleTagsVersion = null;
        }
        else
        {
          throw new Error("Cannot parse Sample Tag Version: " + inputs._Sample_Tags_Version);
        }
      }
      return ({
        Subsample_Tags: inputs._Subsample_Tags,
        Tag_Sample_Names: inputs._Tag_Sample_Names,
        Sample_Tags_Version: enumifiedSampleTagsVersion
      });
    }
    else if (inputs.Assay === "WTA")
    {
      return ({
        Subsample_Tags: null,
        Tag_Sample_Names: null,
        Sample_Tags_Version: null
      });
    }
  }
