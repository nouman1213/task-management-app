class CompanyListModel {
  final int? cOID;
  final String? cONAME;
  final List<dynamic>? sMUSERs;
  final List<dynamic>? tASKS;

  CompanyListModel({
    this.cOID,
    this.cONAME,
    this.sMUSERs,
    this.tASKS,
  });

  CompanyListModel.fromJson(Map<String, dynamic> json)
      : cOID = json['COID'] as int?,
        cONAME = json['CONAME'] as String?,
        sMUSERs = json['SMUSERs'] as List?,
        tASKS = json['TASKS'] as List?;

  Map<String, dynamic> toJson() =>
      {'COID': cOID, 'CONAME': cONAME, 'SMUSERs': sMUSERs, 'TASKS': tASKS};
}
