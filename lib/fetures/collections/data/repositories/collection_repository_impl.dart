import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/network_info.dart';
import 'package:chat_mobile/fetures/collections/data/datasources/collection_remote_datasource.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:chat_mobile/fetures/collections/domain/repositories/collection_repository.dart';
import 'package:dartz/dartz.dart';

class CollectionsRepositoryImpl extends CollectionsRepository {
  final NetworkInfo networkInfo;
  final CollectionsRemoteDataSource remoteDataSource;
  CollectionsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
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
}
