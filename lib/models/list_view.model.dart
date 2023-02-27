class ListViewModel {
  int? id;
  int? customerId;
  String? serialNumber;
  String? referenceId;
  int? notificationType;
  String? notificationDate;
  bool? isRead;
  bool? isDelete;
  String? description;

  ListViewModel(
      {this.customerId,
      this.id = 0,
      this.isDelete,
      this.description,
      this.isRead,
      this.notificationDate,
      this.notificationType,
      this.referenceId,
      this.serialNumber});
  ListViewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    serialNumber = json['serialNumber'];
    referenceId = json['referenceId'];
    notificationType = json['notificationType'];
    notificationDate = json['notificationDate'];
    description = json['description'];

    isRead = json['isRead'];
    isDelete = json['isDelete'];
  }
}
