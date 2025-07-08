import 'package:chat_mobile/core/constents/api_constatnts.dart';
import 'package:chat_mobile/core/errors/failures.dart';
import 'package:chat_mobile/core/network/api_client.dart';
import 'package:chat_mobile/fetures/collections/data/models/collection_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class CollectionsRemoteDataSource {
  Future<Either<Failure, List<CollectionModel>>> getAllCollections();
}

class CollectionsRemoteDataSourceImpl extends CollectionsRemoteDataSource {
  final ApiClient apiClient;
  CollectionsRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<Either<Failure, List<CollectionModel>>> getAllCollections() async {
    try {
      final response = await apiClient.get(ApiUrls.getAllCollections);
      if (response.statusCode == 200) {
        final data = response.data["collections"] as List;
        return Right(data.map((e) => CollectionModel.fromJson(e)).toList());
      } else {
        return Left(ServerFailure(message: "Fialed to get collections"));
      }
    } catch (e) {
      debugPrint(
        "[CollectionsRemoteDataSourceImpl] Fialed to get collections : $e",
      );
      return Left(UnknownFailure(message: "Fialed to get collections"));
    }
  }
}
