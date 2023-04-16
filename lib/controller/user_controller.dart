import 'package:notes_app/model/carpeta.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<User>(context)..join(set: (u) => u.folders);

    final users = await query.fetch();
    return Response.ok(users);
  }

  @Operation.get("id")
  Future<Response> getUser(@Bind.path("id") int id) async {
    if (request?.authorization?.ownerID != id) {
      return Response.unauthorized();
    }

    /*
    final usuario = Query<User>(context)
      ..where((u) => u.id).equalTo(id);
    final user= await usuario.fetchOne();
    final carpetaQuery = Query<Carpeta>(context)
      ..where((c) => c.user?.id).equalTo(id)
      ..join(set: (c) => c.notes);

    final carpeta = await carpetaQuery.fetch();*/

    // final query = Query<Carpeta>(context)
    //   ..where((c) => c.user?.id).equalTo(id)
    //   ..join(set: (c) => c.notes)
    //   ..join(object: (c) => c.user);

    // final userCompleto = await query.fetch();

    // if (userCompleto == null) {
    //   return Response.notFound();
    // }
    // return Response.ok(userCompleto);
    final query = Query<User>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }
    final carpetaQuery = Query<Carpeta>(context)
      ..where((c) => c.user?.id).equalTo(id)
      ..join(set: (c) => c.notes);
    final carpetas = await carpetaQuery.fetch();
    return Response.ok({
      'user': u,
      'carpetas': carpetas,
    });
  }

  @Operation.put("id")
  Future<Response> updateUser(
      @Bind.path("id") int id, @Bind.body() User user) async {
    if (request?.authorization?.ownerID != id) {
      return Response.unauthorized();
    }
    final query = Query<User>(context)
      ..values = user
      ..where((o) => o.id).equalTo(id);
    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }
    return Response.ok(u);
  }

  @Operation.delete("id")
  Future<Response> deleteUser(@Bind.path("id") int id) async {
    if (request?.authorization?.ownerID != id) {
      return Response.unauthorized();
    }
    final query = Query<User>(context)..where((o) => o.id).equalTo(id);
    await query.delete();
    return Response.ok(null);
  }
}
