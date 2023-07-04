import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generator/work_order_personals.g.dart';

@JsonSerializable()
class WorkOrderPersonals extends Equatable {
  final String? fullname;
  final String? code;

  const WorkOrderPersonals({
    this.fullname,
    this.code,
  });

  factory WorkOrderPersonals.fromJson(Map<String, dynamic> json) {
    return _$WorkOrderPersonalsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkOrderPersonalsToJson(this);
  }

  @override
  List<Object?> get props => [
        fullname,
        code,
      ];
}
