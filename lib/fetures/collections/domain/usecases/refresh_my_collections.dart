import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:chat_mobile/fetures/collections/domain/repositories/collection_repository.dart';
import 'package:dartz/dartz.dart';

class RefreshMyCollectionUsecase {
  final CollectionsRepository repository;
  RefreshMyCollectionUsecase({required this.repository});

  Future<Either<Failure, List<Collection>>> call() {
    return repository.refreshMyCollections();
  }
}
