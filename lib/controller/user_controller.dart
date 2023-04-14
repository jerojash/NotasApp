import 'package:notes_app/model/carpeta.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';

class UserController extends ResourceController {
  UserController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

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
    final query = Query<User>(context)
      ..where((o) => o.id).equalTo(id)
      ..join(set: (u) => u.folders);
    //query.join(set: (u) => u.notes);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }
    return Response.ok(u);
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
    await authServer.revokeAllGrantsForResourceOwner(id);
    await query.delete();
    return Response.ok(null);
  }
}
