import 'package:notes_app/notes_app.dart';
import 'controller/usuario.dart';
import 'package:conduit_postgresql/src/postgresql_persistent_store.dart';

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
  ///
  /// NO SE TOCA
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
        "postgres", "cjmd140102", "localhost", 5432, "Notes");

    context = ManagedContext(dataModel, psc);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint =>
      Router()
       ..route('/usuario/[:id]').link(() => usuarioContoller(context));

  // Prefer to use `link` instead of `linkFunction`.
  // See: https://conduit.io/docs/http/request_controller/
  // ignore: unnecessary_lambdas*/
}
