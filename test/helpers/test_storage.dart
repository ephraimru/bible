import 'dart:io';

import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:hive/hive.dart';

/// Creates a [LocalStorageService] backed by a fresh temporary directory.
Future<LocalStorageService> createTestStorage() async {
  final dir = await Directory.systemTemp.createTemp('faith_mission_test_');
  final storage = LocalStorageService();
  await storage.initialize(path: dir.path);
  return storage;
}

Future<void> disposeTestStorage() async {
  await Hive.deleteFromDisk();
}
