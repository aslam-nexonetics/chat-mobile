import 'package:chat_mobile/core/errors/exceptions.dart';
import 'package:chat_mobile/core/storage/hive_storage.dart';
import 'package:chat_mobile/fetures/collections/data/models/collection_model.dart';

abstract class CollectionsLocalDatasource {
  Future<void> cacheMyCollections(List<CollectionModel> collectionsToCache);

  Future<List<CollectionModel>> getLastCollections();
}

class CollectionsLocalDatasourceImpl extends CollectionsLocalDatasource {
  final HiveStorage hiveStorage;
  static const String collectionBoxName = 'collection_box';

  // Cache keys
  static const String _cachedCollectionsKey = 'CACHED_USER_Collections';
  CollectionsLocalDatasourceImpl({required this.hiveStorage});

  @override
  Future<List<CollectionModel>> getLastCollections() async {
    try {
      final List<CollectionModel> collections = await hiveStorage
          .getList<CollectionModel>(collectionBoxName, _cachedCollectionsKey);

      if (collections.isEmpty) {
        throw CacheException(message: "Filed to get cached collections");
      }

      return collections;
    } catch (e) {
      throw CacheException(message: "Filed to get cached collections");
    }
  }

  @override
  Future<void> cacheMyCollections(
    List<CollectionModel> collectionsToCache,
  ) async {
    await hiveStorage.putList(
      collectionBoxName,
      _cachedCollectionsKey,
      collectionsToCache,
    );
  }
}
