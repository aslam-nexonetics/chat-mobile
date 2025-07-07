import 'package:equatable/equatable.dart';
class Collection extends Equatable {
  const Collection({
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

  final int id;
  final String collectionName;
  final String collectionType;
  final List<String> properties;
  final String description;
  final String status;
  final List<String> collectionTables;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        collectionName,
        collectionType,
        properties,
        description,
        status,
        collectionTables,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Collection('
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
}