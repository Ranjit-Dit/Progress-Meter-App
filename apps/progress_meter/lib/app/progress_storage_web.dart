// Browser localStorage is the web equivalent of native application support storage.
// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:convert';

import 'dart:html' as html;

import '../features/progress/data/progress_repository.dart';
import '../features/progress/domain/models.dart';

/// Browser storage keeps the web workspace local to this browser profile.
/// It intentionally uses the same validated JSON schema as native storage.
class WebProgressRepository implements ProgressRepository {
  static const _storageKey = 'progress_meter.progress_v1';

  @override
  Future<ProgressData?> load() async {
    final raw = html.window.localStorage[_storageKey];
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      return ProgressData.fromJson(Map<String, dynamic>.from(decoded as Map));
    } catch (error) {
      throw FormatException('Saved web progress could not be read: $error');
    }
  }

  @override
  Future<void> save(ProgressData data) async {
    html.window.localStorage[_storageKey] =
        const JsonEncoder.withIndent('  ').convert(data.toJson());
  }
}

Future<ProgressRepository> createProgressRepository() async =>
    WebProgressRepository();
