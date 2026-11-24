import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';

/// A thin typed view over an untyped Hive box that stores each value as a
/// JSON string.
///
/// Hive can only persist custom classes if a `TypeAdapter` is registered for
/// each of them. Our models are Freezed classes with generated
/// `toJson`/`fromJson`, so instead of hand-writing adapters we serialize to
/// JSON. This keeps the familiar `get` / `put` / `values` API.
class JsonBox<T> {
  JsonBox(this.name, this._fromJson, this._toJson);

  final String name;
  final T Function(Map<String, dynamic> json) _fromJson;
  final Map<String, dynamic> Function(T value) _toJson;

  Box get _box => Hive.box(name);

  T? _decode(dynamic raw) {
    if (raw == null) return null;
    try {
      final map = raw is String
          ? jsonDecode(raw) as Map<String, dynamic>
          : Map<String, dynamic>.from(raw as Map);
      return _fromJson(map);
    } catch (_) {
      // Corrupt or outdated record: ignore it rather than crash the app.
      return null;
    }
  }

  T? get(dynamic key) => _decode(_box.get(key));

  Future<void> put(dynamic key, T value) =>
      _box.put(key, jsonEncode(_toJson(value)));

  Future<void> delete(dynamic key) => _box.delete(key);

  Future<int> clear() => _box.clear();

  bool containsKey(dynamic key) => _box.containsKey(key);

  Iterable<dynamic> get keys => _box.keys;

  int get length => _box.length;

  Iterable<T> get values => _box.values.map(_decode).whereType<T>();

  /// Emits the decoded value every time [key] changes (or `null` on delete).
  Stream<T?> watchKey(dynamic key) =>
      _box.watch(key: key).map((event) => event.deleted ? null : _decode(event.value));

  /// Emits whenever anything in the box changes.
  Stream<BoxEvent> watch() => _box.watch();
}
