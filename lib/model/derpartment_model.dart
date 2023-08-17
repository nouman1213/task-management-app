class GetDepartmentListModel {
  final int? dPID;
  final dynamic dPNAME;
  final int? fKCOID;
  final dynamic sMCO;
  final List<dynamic>? tASKS;

  GetDepartmentListModel({
    this.dPID,
    this.dPNAME,
    this.fKCOID,
    this.sMCO,
    this.tASKS,
  });

  GetDepartmentListModel.fromJson(Map<String, dynamic> json)
      : dPID = json['DPID'] as int?,
        dPNAME = json['DPNAME'],
        fKCOID = json['FKCOID'] as int?,
        sMCO = json['SMCO'],
        tASKS = json['TASKS'] as List?;

  Map<String, dynamic> toJson() => {
        'DPID': dPID,
        'DPNAME': dPNAME,
        'FKCOID': fKCOID,
        'SMCO': sMCO,
        'TASKS': tASKS
      };
}
