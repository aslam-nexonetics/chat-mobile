import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/repositories/collection_repository.dart';
import 'package:dartz/dartz.dart';

class AddUserToCollectionUsecase {
  final CollectionsRepository repository;
  AddUserToCollectionUsecase({required this.repository});

  Future<Either<Failure, bool>> call({
    required String userId,
    required String collectionId,
  }) {
    return repository.addUserToCollection(
      userId: userId,
      collectionId: collectionId,
    );
  }
}
