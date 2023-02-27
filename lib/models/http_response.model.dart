// ignore_for_file: camel_case_types, non_constant_identifier_names

//HTTP SONUC MODELİ KULLANILAN SİSTEME GÖRE DEĞİŞTİRİLEBİLİR.
class httpSonucModel {
  // dynamic data;
  // bool? success;
  // String? message;
  String? result;
  String? totalCount;
  dynamic records;

  httpSonucModel({
    // this.data,
    // required this.success,
    // required this.message,
    this.records,
    required this.result,
    required this.totalCount,
  });

  httpSonucModel.fromJsonData(Map<String, dynamic> records)
      : records = records['records'],
        result = records['success'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> records = <String, dynamic>{};
    records['records'] = records;
    records['success'] = result;
    return records;
  }
}
