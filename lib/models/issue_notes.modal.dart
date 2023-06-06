class IssueNotesModal {
  String? ID;
  String? NAME;
  String? IDATE;
  String? IUSER;
  String? BODY;
  String? IUSERNAME;
  String? ADDITIONALTIME;


  IssueNotesModal(
      {
      this.ID,
      this.NAME,
      this.IDATE,
      this.BODY,
      this.IUSER,
      this.IUSERNAME,
      this.ADDITIONALTIME,

      });
  IssueNotesModal.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    NAME = json['NAME'];
    IDATE = json['IDATE'];
    BODY = json['BODY'];
    IUSER = json['IUSER'];
    IUSERNAME = json['IUSERNAME'];
    ADDITIONALTIME = json['ADDITIONALTIME'];

  }
}
