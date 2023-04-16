import 'package:notes_app/model/note.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';

class Carpeta extends ManagedObject<_Carpeta> implements _Carpeta {
  get name => null;
}

@Table(name: "folders")
class _Carpeta {
  @primaryKey
  late int? c_clave;

  @Column()
  late String? c_nombre;

  @Column()
  late String? c_tipo;

  @Relate(#folders, isRequired: false, onDelete: DeleteRule.cascade)
  late User? user;

  late ManagedSet<Note> notes;
}
