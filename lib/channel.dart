import 'package:conduit_postgresql/src/postgresql_persistent_store.dart';
import 'notes_app.dart';
import 'controller/carpetas_controller.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://conduit.io/docs/http/channel/.
class CarpetasCrudChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  late ManagedContext context;
  
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo("postgres", "admin", "localhost", 5432, "postgres");
  
    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint =>
    Router()..route('/carpeta/[:id]').link(() => CarpetasController(context));
}
