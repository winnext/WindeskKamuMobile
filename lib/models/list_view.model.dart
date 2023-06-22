class ListViewModel {
  String? ID;
  String? CODE;
  String? RELATEDCODE;
  String? TARGET_FDATE;
  String? TARGET_RDATE;
  String? SUMDESC1;
  String? CAT1;
  String? STATUSNAME;
  String? STATUSCODE;
  String? IDATE;
  String? RESPONDED_IDATE;
  String? LOCATION;
  String? DESCRIPTION;
  String? FIXED_IDATE;
  String? PLANNEDDATE;
  Object? response_timer;
  Object? fixed_timer;
  String? SPACE;

  ListViewModel(
      {this.ID = '0',
      this.CODE,
      this.RELATEDCODE,
      this.TARGET_FDATE,
      this.TARGET_RDATE,
      this.SUMDESC1,
      this.CAT1,
      this.STATUSNAME,
      this.STATUSCODE,
      this.IDATE,
      this.FIXED_IDATE,
      this.PLANNEDDATE,
      this.RESPONDED_IDATE,
      this.fixed_timer,
      this.response_timer,
      this.LOCATION,
      this.DESCRIPTION,
      this.SPACE});
  ListViewModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CODE = json['CODE'];
    RELATEDCODE = json['RELATEDCODE'];
    TARGET_FDATE = json['TARGET_FDATE'];
    TARGET_RDATE = json['TARGET_RDATE'];
    SUMDESC1 = json['SUMDESC1'];
    CAT1 = json['CAT1'];
    STATUSNAME = json['STATUSNAME'];
    STATUSCODE = json['STATUSCODE'];
    IDATE = json['IDATE'];
    FIXED_IDATE = json['FIXED_IDATE'];
    PLANNEDDATE = json['PLANNEDDATE'];
    RESPONDED_IDATE = json['RESPONDED_IDATE'];
    fixed_timer = json['fixed_timer'];
    response_timer = json['response_timer'];
    LOCATION = json['LOCATION'];
    DESCRIPTION = json['DESCRIPTION'];
    SPACE = json['SPACE'];
  }
}
