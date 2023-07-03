import 'package:json_annotation/json_annotation.dart';
part 'generator/work_order_personals.g.dart';

@JsonSerializable()
class WorkOrderPersonals {
  final String? module;
  final String? modulecode;
  final String? name;
  final String? vardiya;

  WorkOrderPersonals({
    this.module,
    this.modulecode,
    this.name,
    this.vardiya,
  });

  factory WorkOrderPersonals.fromJson(Map<String, dynamic> json) {
    return _$WorkOrderPersonalsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkOrderPersonalsToJson(this);
  }
}
