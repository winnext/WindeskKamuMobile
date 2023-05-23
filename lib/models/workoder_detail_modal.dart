class WoDetailViewModel {
  String? ID;
  String? CODE;
  String? NAME;
  String? MODULE;
  String? SERVICE;
  String? MODULECODE;
  String? MODULENAME;
  String? MODULELOCATION;
  String? STATUS;
  String? STATUSNAME;
  String? RESPONSIBLE;
  String? IUSER;
  String? IDATE;
  String? PLANNED_STARTDATE;
  String? PLANNED_ENDDATE;
  String? PLANNED_TIME;
  String? PRIORITY;
  String? ACTUAL_STARTDATE;
  String? ACTUAL_ENDDATE;
  String? ACTUAL_TIME;
  String? DOWNTIME;
  Object? PERMISSIONNEED;
  Object? CLOSENEED;
  String? WORKSAFETYNEED;
  String? ENFECTIONRISK;
  String? DESCRIPTION;

  WoDetailViewModel(
      {this.ID = '0',
      this.CODE,
      this.NAME,
      this.MODULE,
      this.SERVICE,
      this.STATUSNAME,
      this.STATUS,
      this.IDATE,
      this.PLANNED_STARTDATE,
      this.PRIORITY,
      this.ACTUAL_STARTDATE,
      this.ACTUAL_ENDDATE,
      this.IUSER,
      this.ENFECTIONRISK,
      this.DOWNTIME,
      this.PLANNED_TIME,
      this.CLOSENEED,
      this.PERMISSIONNEED,
      this.ACTUAL_TIME,
      this.WORKSAFETYNEED,
      this.MODULENAME,
      this.RESPONSIBLE,
      this.MODULECODE,
      this.MODULELOCATION,
      this.PLANNED_ENDDATE,
      this.DESCRIPTION});
  WoDetailViewModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CODE = json['CODE'];
    NAME = json['NAME'];
    MODULE = json['MODULE'];
    SERVICE = json['SERVICE'];
    STATUSNAME = json['STATUSNAME'];
    STATUS = json['STATUS'];
    IDATE = json['IDATE'];
    PLANNED_ENDDATE = json['PLANNED_ENDDATE'];
    PLANNED_STARTDATE = json['PLANNED_STARTDATE'];
    PRIORITY = json['PRIORITY'];
    ACTUAL_STARTDATE = json['ACTUAL_STARTDATE'];
    ACTUAL_ENDDATE = json['ACTUAL_ENDDATE'];
    IUSER = json['IUSER'];
    ENFECTIONRISK = json['ENFECTIONRISK'];
    DESCRIPTION = json['DESCRIPTION'];
    DOWNTIME = json['DOWNTIME'];
    PLANNED_TIME = json['PLANNED_TIME'];
    CLOSENEED = json['CLOSENEED'];
    PERMISSIONNEED = json['PERMISSIONNEED'];
    WORKSAFETYNEED = json['WORKSAFETYNEED'];
    MODULENAME = json['MODULENAME'];
    RESPONSIBLE = json['RESPONSIBLE'];
    MODULECODE = json['MODULECODE'];
    MODULELOCATION = json['MODULELOCATION'];
  }
}
