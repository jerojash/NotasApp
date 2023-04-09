import 'package:conduit_core/conduit_core.dart';
import 'package:notes_app/notes_app.dart';
import 'package:notes_app/model/usuario.dart';

class UsuarioContoller extends ResourceController {
  usuarioContoller(this.context);
  //
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllUsuarios() async {
    final usuarioQuery = Query<Usuario>(context);
    return Response.ok(await usuarioQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getUsuarioByID(@Bind.path("id") int id) async {
    final usuarioQuery = Query<Usuario>(context)
      ..where((u) => u.u_clave).equalTo(id);
    final usuario = await usuarioQuery.fetchOne();
    if (usuario == null) {
      return Response.notFound();
    }
    return Response.ok(usuario);
  }

  @Operation.post()
  Future<Response> createUsuario(@Bind.body() Usuario body) async {
    final query = Query<Usuario>(context)..values = body;
    final insertedUsuario = await query.insert();
    return Response.ok(insertedUsuario);
  }

  @Operation.put('id')
  Future<Response> updateUsuario(
      @Bind.path("id") int id, @Bind.body() Usuario body) async {
    final query = Query<Usuario>(context)
      ..values = body
      ..where((u) => u.u_clave).equalTo(id);
    final updatedUsuario = await query.updateOne();
    if (updatedUsuario == null) {
      return Response.notFound();
    }
    return Response.ok(updatedUsuario);
  }

  @Operation.delete('id')
  Future<Response> deleteUsuario(@Bind.path("id") int id) async {
    final query = Query<Usuario>(context)..where((u) => u.u_clave).equalTo(id);
    final deletedUsuario = await query.delete();
    if (deletedUsuario == null) {
      return Response.notFound();
    }
    return Response.ok(deletedUsuario);
  }
}
