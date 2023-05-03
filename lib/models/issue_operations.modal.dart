import 'dart:ffi';

class IssueOperationsModal {
  bool? IS_PHOTO;
  bool? IS_TAKE_OVER;
  bool? IS_SPAREPART;
  bool? IS_ACTIVITY;
  bool? IS_CHANGE_CFG;
  bool? IS_PLANNED_CANCEL;


  IssueOperationsModal(
      {
      this.IS_PHOTO,
      this.IS_TAKE_OVER,
      this.IS_SPAREPART,
      this.IS_ACTIVITY,
      this.IS_CHANGE_CFG,
      this.IS_PLANNED_CANCEL,
      });
  IssueOperationsModal.fromJson(Map<String, dynamic> json) {
    IS_PHOTO = json['IS_PHOTO'];
    IS_TAKE_OVER = json['IS_TAKE_OVER'];
    IS_SPAREPART = json['IS_SPAREPART'];
    IS_ACTIVITY = json['IS_ACTIVITY'];
    IS_CHANGE_CFG = json['IS_CHANGE_CFG'];
    IS_PLANNED_CANCEL = json['IS_PLANNED_CANCEL'];

  }
}
