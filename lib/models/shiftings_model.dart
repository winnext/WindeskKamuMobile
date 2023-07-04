import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generator/shiftings_model.g.dart';

@JsonSerializable()
class ShiftingsModel extends Equatable {
  final String? code;
  final String? name;

  const ShiftingsModel({
    this.code,
    this.name,
  });

  factory ShiftingsModel.fromJson(Map<String, dynamic> json) {
    return _$ShiftingsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShiftingsModelToJson(this);
  }

  @override
  List<Object?> get props => [
        code,
        name,
      ];
}
