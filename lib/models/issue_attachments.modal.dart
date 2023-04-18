class IssueAttachmentModal {
  int? ID;
  String? NAME;
  String? FILENAME;
  String? DISPFILENAME;
  String? ATCHTYPE;
  String? FILEPATH;
  String? IDATE;


  IssueAttachmentModal(
      {
      this.ID,
      this.NAME,
      this.FILENAME,
      this.DISPFILENAME,
      this.ATCHTYPE,
      this.FILEPATH,
      this.IDATE,

      });
  IssueAttachmentModal.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    NAME = json['NAME'];
    FILENAME = json['FILENAME'];
    DISPFILENAME = json['DISPFILENAME'];
    ATCHTYPE = json['ATCHTYPE'];
    FILEPATH = json['FILEPATH'];
    IDATE = json['IDATE'];

  }
}
