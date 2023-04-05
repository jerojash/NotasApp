import 'package:conduit_core/conduit_core.dart';
import 'package:notes_app/notes_app.dart';

class NotesController extends ResourceController{
  final _notes = [
    {'id': 11, 'name': 'Mr. Nice'},
    {'id': 12, 'name': 'Narco'},
    {'id': 13, 'name': 'Bombasto'},
    {'id': 14, 'name': 'Celeritas'},
    {'id': 15, 'name': 'Magneta'},
    {'id': 122, 'name': 'Null'}    
  ];


  @Operation.get()
  Future<Response> getAllNotes() async {
      return Response.ok(_notes);
  }


  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int id) async {
    final note = _notes.firstWhere((note) => note['id'] == id);
    
    if (note == false) {
      return Response.notFound();
    }

    return Response.ok(note);
  }
}