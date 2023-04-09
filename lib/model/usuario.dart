import 'package:notes_app/notes_app.dart';

class Usuario extends ManagedObject<_Usuario> implements _Usuario {}

class _Usuario {
  @primaryKey
  int u_clave;

  @Column(unique: true, indexed: true)
  String u_user;

  @Column()
  String u_nombre;

  @Column()
  String u_apellido;

  @Column(unique: true, indexed: true)
  String u_email;

  @Column(omitByDefault: true)
  String u_password;

  @Column(omitByDefault: true)
  String salt;

  @Column()
  String u_segundonombre;

  @Column()
  String u_segundoapellido;
}
