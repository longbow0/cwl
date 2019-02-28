doc: >
  PairReadsFiles takes an array of split files and pairs them, such that an R1 file
  is transferred to a QualityFilter with its corresponding R2 file.

  Each file should be formatted as illumina outputs it from basespace: e.g. sample_L001_R1_001.fastq.gz.
  After being split, that sample file would be an array files named sample_L001_R1_001-00.fastq,
  sample_L001_R1_001-01.fastq, etc
cwlVersion: v1.0
class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
inputs:
  Reads:
    type: File[]
outputs:
  ReadPairs:
    type:
      type: array
      items:
        type: record
        fields:
        - name: R1
          type: File
        - name: R2
          type: File
        - name: readPairID
          type: int
        - name: library
          type: string
expression: |-
  ${
    // send paired reads to the same key in readPairs
    var readPairs = {}
    for (var i = 0; i < inputs.Reads.length; i++) {
      var f = inputs.Reads[i];

      // This is the illumina basespace regex. More sophisticated file handling is needed for NovaSeq
      // example: <SAMPLE>[<SAMPLE NUMBER>][<LANE>]_R<READ FLAG>_001.fastq.gz
      var groups = f.basename.match(/^(.*?)(_S[0-9]*)?(_L[0-9]*)?(_R[1|2])_001(-[0-9]*)?\.(.*?)$/);
      var library = groups[1];
      var sampleNumber = groups[2];
      var laneNumber = groups[3];
      var flag = groups[4];
      var chunkID = 9999; // if there is no scatter id, use an arbitrary number
      if (groups[5]){
        chunkID = parseInt(groups[5].slice(1)); // slice off the '-'
      }

      // double check we have a chunk id
      if (chunkID === undefined || chunkID === null) {
            throw new Error("chunkID could not be determined!");
      }

      // notice, we ignore the flag. This causes the paired reads to share the same key
      var readPairID = library + sampleNumber + laneNumber + chunkID

      // sort the information from the filename into an object
      if (!readPairs[readPairID]) {
        readPairs[readPairID] = {
          R1: null,
          R2: null,
          library: library,
          readPairID: null,
        };
      }
      // add in the readPair, depending on the flag
      if (flag === "_R1") {
        readPairs[readPairID].R1 = f
      } else if (flag === "_R2") {
        readPairs[readPairID].R2 = f
      }

    }
    // we are not interested in the keys in readPairs; flatten into an array of objects
    var readPairsList = []
    var i = 1;
    for (var key in readPairs) {
      if (readPairs.hasOwnProperty(key)) {
        var readPair = readPairs[key]
        readPair.readPairID = i
        readPairsList.push(readPair)
        i++;
      }
    }
    // pass this array to the record array named "ReadPairs" on the CWL layer
    return {ReadPairs: readPairsList}
  }
