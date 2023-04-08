import 'package:conduit_core/conduit_core.dart';
import 'package:notes_app/notes_app.dart';
import 'package:notes_app/model/note.dart';

class NotesController extends ResourceController{

  NotesController(this.context);

  final ManagedContext context;  

 @Operation.get()
  Future<Response> getAllNote() async {
    final noteQuery = Query<Note>(context);
    return Response.ok(await noteQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getNoteByID(@Bind.path("id") int id) async {
    final noteQuery = Query<Note>(context)
      ..where((n) => n.n_clave).equalTo(id);
    final note = await noteQuery.fetchOne();
    if (note == null) {
      return Response.notFound();
    }
    return Response.ok(note);
  }
}