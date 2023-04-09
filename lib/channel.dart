import 'package:conduit_core/conduit_core.dart';
import 'package:conduit_core/managed_auth.dart';

import 'package:notes_app/notes_app.dart';
import 'package:notes_app/config.dart';
import 'package:notes_app/controller/usuario.dart';
import 'package:notes_app/model/usuario.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://conduit.io/docs/http/channel/.
class NotesAppChannel extends ApplicationChannel {
  /// Initialize services in this method.
  late ManagedContext context;

  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = AppConfig(options?.configurationFilePath ?? '../config.yaml');

    final dataModel = new ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName
    );

    context = new ManagedContext(dataModel, psc);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/usuario/[:id]')
      .link(() => usuarioContoller(context));

    return router;
  }

  // Prefer to use `link` instead of `linkFunction`.
  // See: https://conduit.io/docs/http/request_controller/
  // ignore: unnecessary_lambdas*/
}
