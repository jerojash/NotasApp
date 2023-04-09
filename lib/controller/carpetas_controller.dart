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
}