class IssueActivitiesModal {
  String? ID;
  String? NAME;
  String? IDATE;
  String? DESCRIPTION;
  String? IUSER;
  String? IUSERNAME;
  String? ADDITIONALTIME;


  IssueActivitiesModal(
      {
      this.ID,
      this.NAME,
      this.IDATE,
      this.DESCRIPTION,
      this.IUSER,
      this.IUSERNAME,
      this.ADDITIONALTIME,

      });
  IssueActivitiesModal.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    NAME = json['NAME'];
    IDATE = json['IDATE'];
    DESCRIPTION = json['DESCRIPTION'];
    IUSER = json['IUSER'];
    IUSERNAME = json['IUSERNAME'];
    ADDITIONALTIME = json['ADDITIONALTIME'];

  }
}
