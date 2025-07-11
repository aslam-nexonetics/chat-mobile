import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CollectionsRepository {
  Future<Either<Failure, List<Collection>>> getAllCollections();
  Future<Either<Failure, List<Collection>>> getMyCollections();
  Future<Either<Failure, List<Collection>>> refreshMyCollections();
  Future<Either<Failure, bool>> addUserToCollection({
    required String userId,
    required String collectionId,
  });
}
