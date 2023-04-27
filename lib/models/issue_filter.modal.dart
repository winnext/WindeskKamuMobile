class IssueFilterModel {
  String? CODE;
  String? STATUSNAME;
  String? NAME;

  IssueFilterModel({this.CODE, this.STATUSNAME, this.NAME});
  IssueFilterModel.fromJson(Map<String, dynamic> json) {
    CODE = json['CODE'];
    STATUSNAME = json['STATUSNAME'];
    NAME = json['NAME'];
  }
}
