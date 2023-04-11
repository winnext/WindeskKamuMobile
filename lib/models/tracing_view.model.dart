class TracingViewModal {
  String? name;
  String? code;
  String? count;

  TracingViewModal({
    this.count,
    this.code,
    this.name,
  });
  TracingViewModal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    count = json['count'].toString();
  }
}
