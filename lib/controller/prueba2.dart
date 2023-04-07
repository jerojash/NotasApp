import 'package:conduit_core/conduit_core.dart';
import 'package:prueba/prueba.dart';
import 'package:prueba/model/usuario.dart';

class pruebaContoller extends ResourceController {
  pruebaContoller(this.context);
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
}
