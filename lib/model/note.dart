import 'package:notes_app/notes_app.dart';

class Note extends ManagedObject<_Note> implements _Note {
  get name => null;
}

class _Note {
  @primaryKey
  late int? n_clave;

  @Column()
  late String? n_contenido;

  @Column()
  late DateTime? n_fecha_creada;

  @Column()
  late DateTime? n_fecha_borrada;

  @Column()
  late String? n_tipo;

  // TODO RELATIONS WITH ORM
  @Column()
  late String? fk_carpeta;
}
