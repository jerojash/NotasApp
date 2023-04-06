import 'package:conduit_postgresql/src/postgresql_persistent_store.dart';
import 'package:notes_app/notes_app.dart';

import 'controllers/notas_controller.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://conduit.io/docs/http/channel/.
class NotesAppChannel extends ApplicationChannel {
  //late ManagedContext context;
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  late ManagedContext context;
  

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      "note_user", "admin", "localhost", 5432, "note_app");

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    // router
    //   .route('/notes')
    //   .link(() => NotesController());

    router
    .route('/notes/[:id]')
    .link(() => NotesController(context));

    router
      .route('/example')
      .linkFunction((request) async {
        return Response.ok({'key': 'value'});
      });

    return router;
  }
}
