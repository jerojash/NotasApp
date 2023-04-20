import 'package:conduit_core/conduit_core.dart';
import 'package:notes_app/model/note.dart';

class SinceDateController extends ResourceController {
  SinceDateController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getDaterange(@Bind.body() Map<String, dynamic> body) async {
    var desde = DateTime.parse(body['desde']);
    final daterangeQuery = Query<Note>(context)
      ..predicate = QueryPredicate(
          "folder_c_clave IN (select c_clave from folders where user_id = ${body['id']}) AND n_fecha_creada >= '${desde}' ",
          {});

    final notes = await daterangeQuery.fetch();
    return Response.ok(notes);
  }
}
