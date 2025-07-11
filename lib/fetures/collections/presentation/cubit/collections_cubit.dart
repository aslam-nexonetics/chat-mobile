import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/usecases/get_all_collections.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/usecases/get_all_collections.dart';
import 'package:chat_mobile/fetures/collections/domain/usecases/add_user_to_collection.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsCubit extends Cubit<CollectionsState> {
  final GetAllCOllectionUsecase getAllCollectionsUsecase;
  final AddUserToCollectionUsecase addUserToCollectionUsecase;

  CollectionsCubit({
    required this.getAllCollectionsUsecase,
    required this.addUserToCollectionUsecase,
  }) : super(CollectionsInitial());

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

  Future<void> joinCollection({
    required String userId,
    required String collectionId,
  }) async {
    // Show loading state while joining
    if (state is CollectionsLoaded) {
      final currentState = state as CollectionsLoaded;
      emit(currentState.copyWith(isJoining: true));
    }

    final result = await addUserToCollectionUsecase(
      userId: userId,
      collectionId: collectionId,
    );

    result.fold(
      (failure) {
        // Reset loading state and show error
        if (state is CollectionsLoaded) {
          final currentState = state as CollectionsLoaded;
          emit(currentState.copyWith(
            isJoining: false,
            joinError: _mapFailureToMessage(failure),
          ));
        }
      },
      (success) {
        if (success) {
          // Successfully joined - refresh collections to get updated data
          if (state is CollectionsLoaded) {
            final currentState = state as CollectionsLoaded;
            emit(currentState.copyWith(
              isJoining: false,
              joinError: null,
              joinSuccess: true,
            ));
          }
          // Refresh collections to reflect the change
          getAllCollections();
        } else {
          // Join failed
          if (state is CollectionsLoaded) {
            final currentState = state as CollectionsLoaded;
            emit(currentState.copyWith(
              isJoining: false,
              joinError: 'Failed to join collection',
            ));
          }
        }
      },
    );
  }

  void clearJoinStatus() {
    if (state is CollectionsLoaded) {
      final currentState = state as CollectionsLoaded;
      emit(currentState.copyWith(
        joinError: null,
        joinSuccess: false,
      ));
    }
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