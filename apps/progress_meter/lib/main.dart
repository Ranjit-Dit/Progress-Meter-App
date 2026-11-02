import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/progress_controller.dart';
import 'app/progress_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final controller = ProgressController(
      await createProgressRepository(),
    );
    await controller.initialize();
    runApp(ProgressMeterApp(controller: controller));
  } catch (error) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: SelectableText(
                'Your progress could not be opened.\nYour saved file has been preserved.\n\n$error',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
