import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CollectionsRepository {
  Future<Either<Failure, List<Collection>>> getAllCollections();
}
