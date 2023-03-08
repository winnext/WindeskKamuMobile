class DetailViewModel {
  String? ID;
  String? CODE;
  String? TARGET_FDATE;
  String? TARGET_RDATE;
  String? STATUSNAME;
  String? STATUSCODE;
  String? IDATE;
  String? DESCRIPTION;
  String? PLANNEDDATE;
  String? CONTACTNAME;
  String? LOCNAME;
  String? LOCTREE;
  String? LOCTREE2;
  String? TITLE;
  String? CMDB;
  String? ANI;
  String? HYS;
  String? HDS;
  String? ASSIGNMENTGROUP;
  String? ASSIGNMENTGROUPNAME;
  String? ASSIGNEENAME;
  String? RELATEDCODE;
  String? SUMDESC1;
  String? CAT1;
  String? CONTACTCODE;
  String? PLANNEDDESC;
  String? SLACODE;
  String? PARENTSTATUS;
  String? WRONGREDIRECT;

  DetailViewModel(
      {this.ID = '0',
      this.CODE,
      this.TARGET_FDATE,
      this.TARGET_RDATE,
      this.STATUSNAME,
      this.STATUSCODE,
      this.IDATE,
      this.DESCRIPTION,
      this.LOCNAME,
      this.LOCTREE,
      this.LOCTREE2,
      this.ANI,
      this.ASSIGNEENAME,
      this.ASSIGNMENTGROUPNAME,
      this.CMDB,
      this.CONTACTNAME,
      this.HDS,
      this.HYS,
      this.TITLE,
      this.ASSIGNMENTGROUP,
      this.CAT1,
      this.CONTACTCODE,
      this.PARENTSTATUS,
      this.PLANNEDDESC,
      this.RELATEDCODE,
      this.SLACODE,
      this.SUMDESC1,
      this.WRONGREDIRECT,
      this.PLANNEDDATE});
  DetailViewModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CODE = json['CODE'];
    TARGET_FDATE = json['TARGET_FDATE'];
    TARGET_RDATE = json['TARGET_RDATE'];
    STATUSNAME = json['STATUSNAME'];
    STATUSCODE = json['STATUSCODE'];
    IDATE = json['IDATE'];
    PLANNEDDATE = json['PLANNEDDATE'];
    DESCRIPTION = json['DESCRIPTION'];
    LOCNAME = json['LOCNAME'];
    LOCTREE = json['LOCTREE'];
    LOCTREE2 = json['LOCTREE2'];
    ANI = json['ANI'];
    ASSIGNEENAME = json['ASSIGNEENAME'];
    ASSIGNMENTGROUPNAME = json['ASSIGNMENTGROUPNAME'];
    CMDB = json['CMDB'];
    CONTACTNAME = json['CONTACTNAME'];
    HDS = json['HDS'];
    HYS = json['HYS'];
    ASSIGNMENTGROUP = json['ASSIGNMENTGROUP'];
    CAT1 = json['CAT1'];
    CONTACTCODE = json['CONTACTCODE'];
    PARENTSTATUS = json['PARENTSTATUS'];
    PLANNEDDESC = json['PLANNEDDESC'];
    RELATEDCODE = json['RELATEDCODE'];
    SLACODE = json['SLACODE'];
    SUMDESC1 = json['SUMDESC1'];
    WRONGREDIRECT = json['WRONGREDIRECT'];
  }
}
