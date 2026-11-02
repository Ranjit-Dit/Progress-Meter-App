import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../features/progress/data/progress_repository.dart';

Future<ProgressRepository> createProgressRepository() async {
  final directory = await getApplicationSupportDirectory();
  return JsonProgressRepository(File('${directory.path}/progress_v1.json'));
}
