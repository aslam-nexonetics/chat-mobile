import 'package:equatable/equatable.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';

abstract class CollectionsState extends Equatable {
  const CollectionsState();

  @override
  List<Object?> get props => [];
}

class CollectionsInitial extends CollectionsState {}

class CollectionsLoading extends CollectionsState {}

class CollectionsLoaded extends CollectionsState {
  final List<Collection> collections;
  final List<Collection> filteredCollections;
  final String searchQuery;

  const CollectionsLoaded({
    required this.collections,
    required this.filteredCollections,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [collections, filteredCollections, searchQuery];

  CollectionsLoaded copyWith({
    List<Collection>? collections,
    List<Collection>? filteredCollections,
    String? searchQuery,
  }) {
    return CollectionsLoaded(
      collections: collections ?? this.collections,
      filteredCollections: filteredCollections ?? this.filteredCollections,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class CollectionsError extends CollectionsState {
  final String message;

  const CollectionsError({required this.message});

  @override
  List<Object?> get props => [message];
}
