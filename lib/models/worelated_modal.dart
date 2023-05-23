class WoRelatedViewModel {
  int? ID;
  String? STATUS;
  String? BUSINESS_CODE;
  String? BUSINESS_NAME;
  String? SINIF;
  String? BUILDING;
  String? FLOOR;
  String? WING;

  WoRelatedViewModel({
    this.ID = 0,
    this.STATUS,
    this.BUSINESS_CODE,
    this.BUSINESS_NAME,
    this.SINIF,
    this.BUILDING,
    this.FLOOR,
    this.WING,

  });
  WoRelatedViewModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    STATUS = json['STATUS'];
    BUSINESS_CODE = json['BUSINESS_CODE'];
    BUSINESS_NAME = json['BUSINESS_NAME'];
    SINIF = json['SINIF'];
    BUILDING = json['BUILDING'];
    FLOOR = json['FLOOR'];
    WING = json['WING'];
  }
}
