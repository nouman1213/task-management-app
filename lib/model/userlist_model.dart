class UserListModel {
  final int? uSID;
  final String? lOGINID;
  final String? uSPW;
  final int? fKCOID;
  final String? fKROLE;
  final String? aST;
  final dynamic sMCO;
  final List<dynamic>? tASKS;

  UserListModel({
    this.uSID,
    this.lOGINID,
    this.uSPW,
    this.fKCOID,
    this.fKROLE,
    this.aST,
    this.sMCO,
    this.tASKS,
  });

  UserListModel.fromJson(Map<String, dynamic> json)
      : uSID = json['USID'] as int?,
        lOGINID = json['LOGINID'] as String?,
        uSPW = json['USPW'] as String?,
        fKCOID = json['FKCOID'] as int?,
        fKROLE = json['FKROLE'] as String?,
        aST = json['AST'] as String?,
        sMCO = json['SMCO'],
        tASKS = json['TASKS'] as List?;

  Map<String, dynamic> toJson() => {
        'USID': uSID,
        'LOGINID': lOGINID,
        'USPW': uSPW,
        'FKCOID': fKCOID,
        'FKROLE': fKROLE,
        'AST': aST,
        'SMCO': sMCO,
        'TASKS': tASKS
      };
}
