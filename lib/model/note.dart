import 'package:notes_app/model/carpeta.dart';
import 'package:notes_app/notes_app.dart';

class Note extends ManagedObject<_Note> implements _Note {
  get name => null;
}

@Table(name: "notes")
class _Note {
  @primaryKey
  late int? n_clave;

  @Column()
  late String? n_contenido;

  @Column()
  late DateTime? n_fecha_creada;

  @Column(nullable: true)
  late DateTime? n_fecha_borrada;

  @Column()
  late String? n_tipo;

  @Relate(#notes, isRequired: false, onDelete: DeleteRule.cascade)
  late Carpeta folder;
}
