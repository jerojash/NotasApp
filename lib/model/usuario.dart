import 'package:notes_app/notes_app.dart';

class Usuario extends ManagedObject<_Usuario> implements _Usuario {}

class _Usuario {
  @primaryKey
  late int u_clave;

  @Column(unique: true, indexed: true)
  late String u_user;

  @Column()
  late String u_nombre;

  @Column()
  late String u_apellido;

  @Column(unique: true, indexed: true)
  late String u_email;

  @Column(omitByDefault: true)
  late String u_password;

  @Column()
  late String u_segundonombre;

  @Column()
  late String u_segundoapellido;
}
