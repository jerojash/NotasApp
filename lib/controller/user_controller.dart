import 'package:notes_app/model/carpeta.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';
import 'dart:convert';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAll() async {
    final query = Query<User>(context);
    final users = await query.fetch();
    return Response.ok(users);
  }

  @Operation.get("id")
  Future<Response> getUser(@Bind.path("id") int id) async {
    final query = Query<User>(context)..where((o) => o.id).equalTo(id);
    final u = await query.fetchOne();
    if (u == null) {
      return Response.notFound();
    }
    final carpetaQuery = Query<Carpeta>(context)
      ..where((c) => c.user?.id).equalTo(id)
      ..join(set: (c) => c.notes);
    final carpetas = await carpetaQuery.fetch();
    final carpetasResponse = [];
    carpetas.forEach((element) => carpetasResponse.add(element.asMap()));
    return Response.ok({'user': u.asMap(), 'carpetas': carpetasResponse});
  }

  @Operation.put("id")
  Future<Response> updateUser(
      @Bind.path("id") int id, @Bind.body() User user) async {
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
    final query = Query<User>(context)
      ..where((o) => o.id).equalTo(id);
    final userAux = await query.fetchOne();
    if (userAux == null){
      return Response.notFound();
    }
    await query.delete();
    return Response.ok('Usuario eliminado correctamente');
  }
}
