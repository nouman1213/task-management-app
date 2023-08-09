class GetStatusList {
  final int? sTSID;
  final dynamic sTSNAME;
  final List<dynamic>? tASKS;

  GetStatusList({
    this.sTSID,
    this.sTSNAME,
    this.tASKS,
  });

  GetStatusList.fromJson(Map<String, dynamic> json)
      : sTSID = json['STSID'] as int?,
        sTSNAME = json['STSNAME'],
        tASKS = json['TASKS'] as List?;

  Map<String, dynamic> toJson() =>
      {'STSID': sTSID, 'STSNAME': sTSNAME, 'TASKS': tASKS};
}
