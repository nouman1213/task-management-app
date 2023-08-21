class TaskAssignedToMeModel {
  final int? tASKID;
  final int? fKCOID;
  final int? uSID;
  final String? tTITLE;
  final String? tDTL;
  final String? sTDT;
  final String? eNDT;
  final int? fKPRT;
  final String? pRTNAME;
  final int? tOUSID;
  final int? tSTATUS;
  final String? sTSNAME;
  final String? cOMPDT;
  final String? lOGINID;
  final String? assignBy;
  final int? fKDEPT;
  final String? dEPARTMENT;

  TaskAssignedToMeModel({
    this.tASKID,
    this.fKCOID,
    this.uSID,
    this.tTITLE,
    this.tDTL,
    this.sTDT,
    this.eNDT,
    this.fKPRT,
    this.pRTNAME,
    this.tOUSID,
    this.tSTATUS,
    this.sTSNAME,
    this.cOMPDT,
    this.lOGINID,
    this.assignBy,
    this.fKDEPT,
    this.dEPARTMENT,
  });

  TaskAssignedToMeModel.fromJson(Map<String, dynamic> json)
      : tASKID = json['TASKID'] as int?,
        fKCOID = json['FKCOID'] as int?,
        uSID = json['USID'] as int?,
        tTITLE = json['TTITLE'] as String?,
        tDTL = json['TDTL'] as String?,
        sTDT = json['STDT'] as String?,
        eNDT = json['ENDT'] as String?,
        fKPRT = json['FKPRT'] as int?,
        pRTNAME = json['PRTNAME'] as String?,
        tOUSID = json['TOUSID'] as int?,
        tSTATUS = json['TSTATUS'] as int?,
        sTSNAME = json['STSNAME'] as String?,
        cOMPDT = json['COMPDT'] as String?,
        lOGINID = json['LOGINID'] as String?,
        assignBy = json['AssignBy'] as String?,
        fKDEPT = json['FKDEPT'] as int?,
        dEPARTMENT = json['DEPARTMENT'] as String?;

  Map<String, dynamic> toJson() => {
        'TASKID': tASKID,
        'FKCOID': fKCOID,
        'USID': uSID,
        'TTITLE': tTITLE,
        'TDTL': tDTL,
        'STDT': sTDT,
        'ENDT': eNDT,
        'FKPRT': fKPRT,
        'PRTNAME': pRTNAME,
        'TOUSID': tOUSID,
        'TSTATUS': tSTATUS,
        'STSNAME': sTSNAME,
        'COMPDT': cOMPDT,
        'LOGINID': lOGINID,
        'AssignBy': assignBy,
        'FKDEPT': fKDEPT,
        'DEPARTMENT': dEPARTMENT
      };
}
