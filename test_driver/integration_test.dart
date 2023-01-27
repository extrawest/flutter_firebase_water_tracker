import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  await integrationDriver(
    responseDataCallback: (reportData) async {
      if (reportData != null) {
        for (final entry in reportData.entries) {
          await writeResponseData(
            entry.value as Map<String, dynamic>,
            testOutputFilename: entry.key,
            destinationDirectory: 'integration_test_output',
          );
        }
      }
    },
  );
}