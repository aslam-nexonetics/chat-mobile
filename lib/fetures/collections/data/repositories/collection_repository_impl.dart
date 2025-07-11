import 'package:chat_mobile/core/errors/exceptions.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/network_info.dart';
import 'package:chat_mobile/fetures/collections/data/datasources/collection_remote_datasource.dart';
import 'package:chat_mobile/fetures/collections/data/datasources/collections_local_datasource.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:chat_mobile/fetures/collections/domain/repositories/collection_repository.dart';
import 'package:dartz/dartz.dart';

class CollectionsRepositoryImpl extends CollectionsRepository {
  final NetworkInfo networkInfo;
  final CollectionsRemoteDataSource remoteDataSource;
  final CollectionsLocalDatasource localDataSource;
  CollectionsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<Collection>>> getAllCollections() async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getAllCollections();
      return result.fold(
        (l) => Left(l),
        (collections) => Right(collections.map((e) => e.toEntity()).toList()),
      );
    } else {
      return Left(NetworkFailure(message: "Check you internet"));
    }
  }

  @override
  Future<Either<Failure, List<Collection>>> getMyCollections() async {
    try {
      try {
        final cachedCollections = await localDataSource.getLastCollections();
        return Right(cachedCollections.map((e) => e.toEntity()).toList());
      } on CacheException {
        // Continue to remote fetch if cache fails
      }
      if (await networkInfo.isConnected) {
        return refreshMyCollections();
      }

      return Left(NetworkFailure(message: 'No internet connection'));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Collection>>> refreshMyCollections() async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getAllCollections();
      return result.fold((l) => Left(l), (collections) async {
        await localDataSource.cacheMyCollections(collections);
        return Right(collections.map((e) => e.toEntity()).toList());
      });
    } else {
      return Left(NetworkFailure(message: "Check you internet"));
    }
  }

  Future<Either<Failure, bool>> addUserToCollection({
    required String userId,
    required String collectionId,
  }) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.addUserToCollection(
        userId: userId,
        collectionId: collectionId,
      );
      return result.fold((l) => Left(l), (isSuccess) async {
        return Right(isSuccess);
      });
    } else {
      return Left(NetworkFailure(message: "Check you internet"));
    }
  }
}
