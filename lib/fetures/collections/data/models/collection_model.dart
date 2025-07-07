import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_model.g.dart';

/// Collection model for data layer with Hive adapter
/// This model should be placed in the data layer
@HiveType(typeId: 0)
@JsonSerializable()
class CollectionModel extends HiveObject {
  CollectionModel({
    required this.id,
    required this.collectionName,
    required this.collectionType,
    required this.properties,
    required this.description,
    required this.status,
    required this.collectionTables,
    required this.createdAt,
    required this.updatedAt,
  });

  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  @JsonKey(name: 'collection_name')
  final String collectionName;

  @HiveField(2)
  @JsonKey(name: 'collection_type')
  final String collectionType;

  @HiveField(3)
  @JsonKey(name: 'properties')
  final List<String> properties;

  @HiveField(4)
  @JsonKey(name: 'description')
  final String description;

  @HiveField(5)
  @JsonKey(name: 'status')
  final String status;

  @HiveField(6)
  @JsonKey(name: 'collection_tables')
  final List<String> collectionTables;

  @HiveField(7)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(8)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Factory constructor for creating CollectionModel from JSON
  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);

  /// Method to convert CollectionModel to JSON
  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);

  /// Convert model to domain entity
  Collection toEntity() {
    return Collection(
      id: id,
      collectionName: collectionName,
      collectionType: collectionType,
      properties: List<String>.from(properties),
      description: description,
      status: status,
      collectionTables: List<String>.from(collectionTables),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create model from domain entity
  factory CollectionModel.fromEntity(Collection entity) {
    return CollectionModel(
      id: entity.id,
      collectionName: entity.collectionName,
      collectionType: entity.collectionType,
      properties: List<String>.from(entity.properties),
      description: entity.description,
      status: entity.status,
      collectionTables: List<String>.from(entity.collectionTables),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Copy with method for creating modified copies
  CollectionModel copyWith({
    int? id,
    String? collectionName,
    String? collectionType,
    List<String>? properties,
    String? description,
    String? status,
    List<String>? collectionTables,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      collectionName: collectionName ?? this.collectionName,
      collectionType: collectionType ?? this.collectionType,
      properties: properties ?? this.properties,
      description: description ?? this.description,
      status: status ?? this.status,
      collectionTables: collectionTables ?? this.collectionTables,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CollectionModel &&
        other.id == id &&
        other.collectionName == collectionName &&
        other.collectionType == collectionType &&
        _listEquals(other.properties, properties) &&
        other.description == description &&
        other.status == status &&
        _listEquals(other.collectionTables, collectionTables) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      collectionName,
      collectionType,
      Object.hashAll(properties),
      description,
      status,
      Object.hashAll(collectionTables),
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'CollectionModel('
        'id: $id, '
        'collectionName: $collectionName, '
        'collectionType: $collectionType, '
        'properties: $properties, '
        'description: $description, '
        'status: $status, '
        'collectionTables: $collectionTables, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        ')';
  }

  /// Helper method to compare lists
  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}