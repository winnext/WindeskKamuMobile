class IssueFilterModel {
  String? CODE;
  String? NAME;

  IssueFilterModel({
    this.CODE,
    this.NAME,
  });
  IssueFilterModel.fromJson(Map<String, dynamic> json) {
    CODE = json['CODE'];
    NAME = json['NAME'];
  }
}
