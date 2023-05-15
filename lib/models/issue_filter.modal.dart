class IssueFilterModel {
  String? CODE;
  String? STATUSNAME;
  String? NAME;
  String? FULLNAME;

  IssueFilterModel({this.CODE, this.STATUSNAME, this.NAME, this.FULLNAME});
  IssueFilterModel.fromJson(Map<String, dynamic> json) {
    CODE = json['CODE'];
    STATUSNAME = json['STATUSNAME'];
    NAME = json['NAME'];
    FULLNAME = json['FULLNAME'];
  }
}
