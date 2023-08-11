class GetTaskListModel {
  final int? tASKID;
  final int? fKCOID;
  final int? uSID;
  final String? tTITLE;
  final String? tDTL;
  final String? sTDT;
  final String? eNDT;
  final int? fKPRT;
  final int? tOUSID;
  final int? tSTATUS;
  final String? cOMPDT;
  final dynamic sMCO;
  final dynamic sMUSER;
  final dynamic tPRIORITY;
  final dynamic tSTATU;

  GetTaskListModel({
    this.tASKID,
    this.fKCOID,
    this.uSID,
    this.tTITLE,
    this.tDTL,
    this.sTDT,
    this.eNDT,
    this.fKPRT,
    this.tOUSID,
    this.tSTATUS,
    this.cOMPDT,
    this.sMCO,
    this.sMUSER,
    this.tPRIORITY,
    this.tSTATU,
  });

  GetTaskListModel.fromJson(Map<String, dynamic> json)
      : tASKID = json['TASKID'] as int?,
        fKCOID = json['FKCOID'] as int?,
        uSID = json['USID'] as int?,
        tTITLE = json['TTITLE'] as String?,
        tDTL = json['TDTL'] as String?,
        sTDT = json['STDT'] as String?,
        eNDT = json['ENDT'] as String?,
        fKPRT = json['FKPRT'] as int?,
        tOUSID = json['TOUSID'] as int?,
        tSTATUS = json['TSTATUS'] as int?,
        cOMPDT = json['COMPDT'] as String?,
        sMCO = json['SMCO'],
        sMUSER = json['SMUSER'],
        tPRIORITY = json['TPRIORITY'],
        tSTATU = json['TSTATU'];

  Map<String, dynamic> toJson() => {
        'TASKID': tASKID,
        'FKCOID': fKCOID,
        'USID': uSID,
        'TTITLE': tTITLE,
        'TDTL': tDTL,
        'STDT': sTDT,
        'ENDT': eNDT,
        'FKPRT': fKPRT,
        'TOUSID': tOUSID,
        'TSTATUS': tSTATUS,
        'COMPDT': cOMPDT,
        'SMCO': sMCO,
        'SMUSER': sMUSER,
        'TPRIORITY': tPRIORITY,
        'TSTATU': tSTATU
      };
}
