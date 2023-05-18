class WoListViewModel {
  String? ID;
  String? CODE;
  String? SERVICE;
  String? SERVICE_NAME;
  String? MODULELOCATION;
  String? NAME;
  String? RESPONSIBLE;
  String? STATUSNAME;
  String? PLANNED_ENDDATE;

  WoListViewModel({
    this.ID = '0',
    this.CODE,
    this.SERVICE,
    this.SERVICE_NAME,
    this.MODULELOCATION,
    this.NAME,
    this.RESPONSIBLE,
    this.STATUSNAME,
    this.PLANNED_ENDDATE,
  });
  WoListViewModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CODE = json['CODE'];
    SERVICE = json['SERVICE'];
    SERVICE_NAME = json['SERVICE_NAME'];
    MODULELOCATION = json['MODULELOCATION'];
    NAME = json['NAME'];
    RESPONSIBLE = json['RESPONSIBLE'];
    STATUSNAME = json['STATUSNAME'];
    PLANNED_ENDDATE = json['PLANNED_ENDDATE'];
  }
}
