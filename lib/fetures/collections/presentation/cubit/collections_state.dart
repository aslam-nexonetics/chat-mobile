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
  final bool isJoining;
  final String? joinError;
  final bool joinSuccess;

  const CollectionsLoaded({
    required this.collections,
    required this.filteredCollections,
    this.searchQuery = '',
    this.isJoining = false,
    this.joinError,
    this.joinSuccess = false,
  });

  CollectionsLoaded copyWith({
    List<Collection>? collections,
    List<Collection>? filteredCollections,
    String? searchQuery,
    bool? isJoining,
    String? joinError,
    bool? joinSuccess,
  }) {
    return CollectionsLoaded(
      collections: collections ?? this.collections,
      filteredCollections: filteredCollections ?? this.filteredCollections,
      searchQuery: searchQuery ?? this.searchQuery,
      isJoining: isJoining ?? this.isJoining,
      joinError: joinError,
      joinSuccess: joinSuccess ?? this.joinSuccess,
    );
  }

  @override
  List<Object?> get props => [
    collections,
    filteredCollections,
    searchQuery,
    isJoining,
    joinError,
    joinSuccess,
  ];
}

class CollectionsError extends CollectionsState {
  final String message;

  const CollectionsError({required this.message});

  @override
  List<Object> get props => [message];
}
