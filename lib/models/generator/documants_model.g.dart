// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../documants_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumantsModel _$DocumantsModelFromJson(Map<String, dynamic> json) => DocumantsModel(
      id: json['ID'] as int?,
      name: json['NAME'] as String?,
      filename: json['FILENAME'] as String?,
      dispfilename: json['DISPFILENAME'] as String?,
      atchtype: json['ATCHTYPE'] as String?,
      filepath: json['FILEPATH'] as String?,
      idate: json['IDATE'] as String?,
    );

Map<String, dynamic> _$DocumantsModelToJson(DocumantsModel instance) => <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'FILENAME': instance.filename,
      'DISPFILENAME': instance.dispfilename,
      'ATCHTYPE': instance.atchtype,
      'FILEPATH': instance.filepath,
      'IDATE': instance.idate,
    };
