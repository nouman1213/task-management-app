class GetPriorityList {
  final int? pRTID;
  final String? pRTNAME;
  final List<dynamic>? tASKS;

  GetPriorityList({
    this.pRTID,
    this.pRTNAME,
    this.tASKS,
  });

  GetPriorityList.fromJson(Map<String, dynamic> json)
      : pRTID = json['PRTID'] as int?,
        pRTNAME = json['PRTNAME'] as String?,
        tASKS = json['TASKS'] as List?;

  Map<String, dynamic> toJson() =>
      {'PRTID': pRTID, 'PRTNAME': pRTNAME, 'TASKS': tASKS};
}
