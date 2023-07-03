import 'package:json_annotation/json_annotation.dart';

part 'generator/shiftings_model.g.dart';

@JsonSerializable()
class ShiftingsModel {
  final String? code;
  final String? name;

  ShiftingsModel({
    this.code,
    this.name,
  });

  factory ShiftingsModel.fromJson(Map<String, dynamic> json) {
    return _$ShiftingsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShiftingsModelToJson(this);
  }
}
