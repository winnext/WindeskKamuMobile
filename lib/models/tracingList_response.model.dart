// ignore_for_file: camel_case_types, non_constant_identifier_names

//HTTP SONUC MODELİ KULLANILAN SİSTEME GÖRE DEĞİŞTİRİLEBİLİR.
class tracingListModal {
  // dynamic data;
  bool? success;
  String? message;
  dynamic lists;

  tracingListModal({
    required this.success,
    required this.message,
    this.lists,
  });

  tracingListModal.fromJsonData(Map<String, dynamic> lists)
      : lists = lists['lists'],
        success = lists['success'];

  get detail => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> lists = <String, dynamic>{};
    lists['lists'] = lists;
    lists['success'] = success;
    return lists;
  }
}
