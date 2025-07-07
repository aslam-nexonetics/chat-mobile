// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionModelAdapter extends TypeAdapter<CollectionModel> {
  @override
  final int typeId = 0;

  @override
  CollectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionModel(
      id: fields[0] as int,
      collectionName: fields[1] as String,
      collectionType: fields[2] as String,
      properties: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      status: fields[5] as String,
      collectionTables: (fields[6] as List).cast<String>(),
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.collectionName)
      ..writeByte(2)
      ..write(obj.collectionType)
      ..writeByte(3)
      ..write(obj.properties)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.collectionTables)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    CollectionModel(
      id: (json['id'] as num).toInt(),
      collectionName: json['collection_name'] as String,
      collectionType: json['collection_type'] as String,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String,
      status: json['status'] as String,
      collectionTables: (json['collection_tables'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection_name': instance.collectionName,
      'collection_type': instance.collectionType,
      'properties': instance.properties,
      'description': instance.description,
      'status': instance.status,
      'collection_tables': instance.collectionTables,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
