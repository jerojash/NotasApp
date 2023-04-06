import 'package:conduit_core/conduit_core.dart';
import 'package:notes_app/notes_app.dart';
import 'package:notes_app/model/note.dart';

class NotesController extends ResourceController{

  NotesController(this.context);

  final ManagedContext context;  

  @Operation.get()
  Future<Response> getAllHeroes({@Bind.query('n_clave') String? n_clave}) async {
    final heroQuery = Query<Note>(context);
    if (n_clave != null) {
      heroQuery.where((h) => h.n_clave).contains(n_clave, caseSensitive: false);
    }
    final heroes = await heroQuery.fetch();

    return Response.ok(heroes);
}

  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int id) async {
    final noteQuery = Query<Note>(context)
    ..where((h) => h.n_clave).equalTo(id);    

    final note = await noteQuery.fetchOne();
    
    if (note == false) {
      return Response.notFound();
    }

    return Response.ok(note);
  }
}