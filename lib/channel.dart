import 'package:notes_app/controller/carpetas_controller.dart';
import 'package:notes_app/controller/identity_controller.dart';
import 'package:notes_app/controller/notas_controller.dart';
import 'package:notes_app/controller/register_controller.dart';
import 'package:notes_app/controller/user_controller.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';

class NotesAppChannel extends ApplicationChannel {
  AuthServer? authServer;
  ManagedContext? context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = AppConfiguration(options!.configurationFilePath!);

    context = contextWithConnectionInfo(config.database!);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/files/*").link(() => FileController("public/"));

    router.route("/auth/token").link(() => AuthController(authServer));
    router
        .route("/register")
        .link(() => Authorizer.basic(authServer!))!
        .link(() => RegisterController(context!, authServer!));
    router
        .route("/me")
        .link(() => Authorizer.bearer(authServer!))!
        .link(() => IdentityController(context!));

    router.route('/carpeta/[:id]').link(() => CarpetasController(context!));

    router.route("/notes/[:id]").link(() => NotesController(context!));

    router.route("/users/[:id]").link(() => UserController(context!));

    return router;
  }

  ManagedContext contextWithConnectionInfo(
      DatabaseConfiguration connectionInfo) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final psc = PostgreSQLPersistentStore(
        connectionInfo.username,
        connectionInfo.password,
        connectionInfo.host,
        connectionInfo.port,
        connectionInfo.databaseName);

    return ManagedContext(dataModel, psc);
  }
}

class AppConfiguration extends Configuration {
  AppConfiguration(String fileName) : super.fromFile(File(fileName));
  DatabaseConfiguration? database;
}
