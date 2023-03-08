// ignore_for_file: camel_case_types, non_constant_identifier_names

//HTTP SONUC MODELİ KULLANILAN SİSTEME GÖRE DEĞİŞTİRİLEBİLİR.
class detailSonucModel {
  // dynamic data;
  bool? success;
  String? message;
  dynamic detail;

  detailSonucModel({
    required this.success,
    required this.message,
    this.detail,
  });

  detailSonucModel.fromJsonData(Map<String, dynamic> detail)
      : detail = detail['detail'],
        success = detail['result'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detail = <String, dynamic>{};
    detail['detail'] = detail;
    detail['result'] = success;
    return detail;
  }
}
