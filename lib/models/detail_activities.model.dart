class DetailActivitiesModal {
  String? ACTIVITYID;
  String? CODE;
  String? ACTTYPECODE;
  String? NAME;
  String? FILEATTACH;
  String? ADDITIONALTIME;
  String? ASSIGNEECC_TYPE;
  String? ASSIGNEECC_ORG;
  String? ASSIGNEECC_USER;
  String? DESCRIPTION;
  String? STATUS;
  String? ASGGROUP;
  String? ASGGROUPNAME;
  String? STATUSNAME;
  String? MIN_DESC_LENGTH;
  String? MOBILE_PHOTO;
  String? BARCODE_SPACE;
  String? BARCODE_CFG;
  String? ADDITIONALTIME_INPUT;

  DetailActivitiesModal(
      {this.ACTIVITYID = '0',
      this.CODE,
      this.ACTTYPECODE,
      this.NAME,
      this.FILEATTACH,
      this.ADDITIONALTIME,
      this.ASSIGNEECC_TYPE,
      this.ASSIGNEECC_ORG,
      this.STATUS,
      this.ASGGROUP,
      this.ASGGROUPNAME,
      this.MIN_DESC_LENGTH,
      this.ADDITIONALTIME_INPUT,
      this.STATUSNAME,
      this.DESCRIPTION,
      this.BARCODE_SPACE,
      this.MOBILE_PHOTO,
      this.BARCODE_CFG,
      this.ASSIGNEECC_USER});
  DetailActivitiesModal.fromJson(Map<String, dynamic> json) {
    ACTIVITYID = json['ACTIVITYID'];
    CODE = json['CODE'];
    ACTTYPECODE = json['ACTTYPECODE'];
    NAME = json['NAME'];
    FILEATTACH = json['FILEATTACH'];
    ADDITIONALTIME = json['ADDITIONALTIME'];
    ASSIGNEECC_TYPE = json['ASSIGNEECC_TYPE'];
    ASSIGNEECC_USER = json['ASSIGNEECC_USER'];
    ASSIGNEECC_ORG = json['ASSIGNEECC_ORG'];
    STATUS = json['STATUS'];
    ASGGROUP = json['ASGGROUP'];
    ASGGROUPNAME = json['ASGGROUPNAME'];
    MIN_DESC_LENGTH = json['MIN_DESC_LENGTH'];
    ADDITIONALTIME_INPUT = json['ADDITIONALTIME_INPUT'];
    STATUSNAME = json['STATUSNAME'];
    DESCRIPTION = json['DESCRIPTION'];
    BARCODE_SPACE = json['BARCODE_SPACE'];
    MOBILE_PHOTO = json['MOBILE_PHOTO'];
    BARCODE_CFG = json['BARCODE_CFG'];
  }
}
