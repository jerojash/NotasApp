import 'package:notes_app/channel.dart';
import '../test/harness/app.dart';

Future main() async {
  final app = Application<CarpetasCrudChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.port = 8888;

  await app.startOnCurrentIsolate();

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
