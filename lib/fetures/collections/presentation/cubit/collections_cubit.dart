import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/usecases/get_all_collections.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  final GetAllCOllectionUsecase getAllCollectionsUsecase;

  CollectionsCubit({required this.getAllCollectionsUsecase})
    : super(CollectionsInitial());

  Future<void> getAllCollections() async {
    emit(CollectionsLoading());

    final result = await getAllCollectionsUsecase();

    result.fold(
      (failure) =>
          emit(CollectionsError(message: _mapFailureToMessage(failure))),
      (collections) => emit(
        CollectionsLoaded(
          collections: collections,
          filteredCollections: collections,
        ),
      ),
    );
  }

  void searchCollections(String query) {
    if (state is CollectionsLoaded) {
      final currentState = state as CollectionsLoaded;
      final filteredCollections =
          query.isEmpty
              ? currentState.collections
              : currentState.collections
                  .where(
                    (collection) =>
                        collection.collectionName?.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ??
                        false,
                  )
                  .toList();

      emit(
        currentState.copyWith(
          filteredCollections: filteredCollections,
          searchQuery: query,
        ),
      );
    }
  }

  void refreshCollections() {
    getAllCollections();
  }

  String _mapFailureToMessage(failure) {
    // Map your failure types to user-friendly messages
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again.';
      case NetworkFailure:
        return 'Network error. Please check your connection.';
      case CacheFailure:
        return 'Cache error occurred.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
