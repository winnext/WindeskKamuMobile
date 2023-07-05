import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'generator/documants_model.g.dart';

@JsonSerializable()
class DocumantsModel extends Equatable {
  final int? id;
  final String? name;
  final String? filename;
  final String? dispfilename;
  final String? atchtype;
  final String? filepath;
  final String? idate;

  const DocumantsModel({
    this.id,
    this.name,
    this.filename,
    this.dispfilename,
    this.atchtype,
    this.filepath,
    this.idate,
  });

  factory DocumantsModel.fromJson(Map<String, dynamic> json) {
    return _$DocumantsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DocumantsModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        filename,
        dispfilename,
        atchtype,
        filepath,
        idate,
      ];
}
