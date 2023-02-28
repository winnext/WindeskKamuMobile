// ignore_for_file: camel_case_types, non_constant_identifier_names

//HTTP SONUC MODELİ KULLANILAN SİSTEME GÖRE DEĞİŞTİRİLEBİLİR.
class httpSonucModel {
  // dynamic data;
  bool? success;
  String? message;
  dynamic records;

  httpSonucModel({
    required this.success,
    required this.message,
    this.records,
  });

  httpSonucModel.fromJsonData(Map<String, dynamic> records)
      : records = records['records'],
        success = records['success'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> records = <String, dynamic>{};
    records['records'] = records;
    records['success'] = success;
    return records;
  }
}
