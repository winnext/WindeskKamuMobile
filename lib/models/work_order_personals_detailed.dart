import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generator/work_order_personals_detailed.g.dart';

@JsonSerializable()
class WorkOrderPersonalsDetailed extends Equatable {
  final String? module;
  final String? modulecode;
  final String? name;
  final String? vardiya;

  const WorkOrderPersonalsDetailed({
    this.module,
    this.modulecode,
    this.name,
    this.vardiya,
  });

  factory WorkOrderPersonalsDetailed.fromJson(Map<String, dynamic> json) {
    return _$WorkOrderPersonalsDetailedFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkOrderPersonalsDetailedToJson(this);
  }

  @override
  List<Object?> get props => [
        module,
        modulecode,
        name,
        vardiya,
      ];
}
