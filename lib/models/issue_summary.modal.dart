class IssueSummaryModal {
  String? CODE;
  String? TARGET_FDATE;
  String? TARGET_RDATE;
  String? STATUS_CODE;
  String? RESPONDED_DATE;
  String? RESPONDED_TIMER;
  String? FIXED_DATE;
  String? FIX_TIMER;
  String? PLANNED_DATE;

  IssueSummaryModal(
      {
      this.CODE,
      this.TARGET_FDATE,
      this.TARGET_RDATE,
      this.STATUS_CODE,
      this.RESPONDED_DATE,
      this.RESPONDED_TIMER,
      this.FIXED_DATE,
      this.FIX_TIMER,
      this.PLANNED_DATE,
      });
  IssueSummaryModal.fromJson(Map<String, dynamic> json) {
    CODE = json['CODE'];
    TARGET_FDATE = json['TARGET_FDATE'];
    TARGET_RDATE = json['TARGET_RDATE'];
    STATUS_CODE = json['STATUS_CODE'];
    RESPONDED_DATE = json['RESPONDED_DATE'];
    RESPONDED_TIMER = json['RESPONDED_TIMER'];
    FIXED_DATE = json['FIXED_DATE'];
    FIX_TIMER = json['FIX_TIMER'];
    PLANNED_DATE = json['PLANNED_DATE'];

  }
}
