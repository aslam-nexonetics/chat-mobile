import 'package:chat_mobile/fetures/collections/data/models/collection_model.dart';
import 'package:chat_mobile/fetures/user/data/models/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HiveStorage {
  static const String appCacheBox = 'app_cache';
  static const String profileBox = 'profile_box';

  // Initialize Hive and register adapters
  Future<void> init() async {
    await Hive.initFlutter();

    // Register your type adapters here
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(CollectionModelAdapter());
  }

  // Open a specific box
  Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  // Put data in a box
  Future<void> put(String boxName, String key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  // Get data from a box
  Future<dynamic> get(String boxName, String key) async {
    final box = await openBox(boxName);
    return box.get(key);
  }

  // Store a list of objects
  Future<void> putList<T>(String boxName, String key, List<T> items) async {
    final box = await openBox(boxName);
    await box.put(key, items);
  }

  // Get a list of objects
  Future<List<T>> getList<T>(String boxName, String key) async {
    final box = await openBox(boxName);
    final data = box.get(key);
    if (data == null) return [];
    return List<T>.from(data);
  }

  // Delete data from a box
  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  // Clear a box
  Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }

  // Close a box
  Future<void> closeBox(String boxName) async {
    final box = await Hive.box(boxName);
    await box.close();
  }

  // Close all boxes
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
