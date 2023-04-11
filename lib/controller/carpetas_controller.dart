import 'package:conduit_core/conduit_core.dart';

import '../model/carpeta.dart';

class CarpetasController extends ResourceController {
  
  CarpetasController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllCarpetas() async {
    final carpetaQuery = Query<Carpeta>(context);
    return Response.ok(await carpetaQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getCarpetaByID(@Bind.path('id') int id) async {
    final carpetaQuery = Query<Carpeta>(context)
      ..where((c) => c.c_clave).equalTo(id);
    
    final carpeta = await carpetaQuery.fetchOne();
      
    if (carpeta == null) {
      return Response.notFound();
    }

      return Response.ok(carpeta);
  }
  
  @Operation.post()
  Future<Response> createCarpeta(@Bind.body() Carpeta body) async {
    final query = Query<Carpeta>(context)
      ..values = body;
    
    final insertedCarpeta = await query.insert();

    return Response.ok(insertedCarpeta);
  }

  // Start Update File Endpoint
  // ----------------------
    @Operation.put("id")
  Future<Response> updateFile(
    @Bind.path("id") int id, 
		@Bind.body() Carpeta newFile
	) async {
    // if (request?.authorization?.ownerID != id) {
    //   return Response.unauthorized();
    // }
    final query = Query<Carpeta>(context)
      ..values = newFile
      ..where((o) => o.c_clave).equalTo(id);
    final u = await query.updateOne();
    if (u == null) {
      return Response.notFound();
    }
    return Response.ok(u);
  }

// Start Delete File Endpoint
  // ----------------------
  @Operation.delete("id")
  Future<Response> deleteFile(@Bind.path("id") int id) async {
    // if (request?.authorization?.ownerID != id) {
    //   return Response.unauthorized();
    // }
    final query = Query<Carpeta>(context)..where((o) => o.c_clave).equalTo(id);
    await query.delete();
    return Response.ok(null);
  }
}