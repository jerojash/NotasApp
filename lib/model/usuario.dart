import 'package:prueba/prueba.dart';

class Usuario extends ManagedObject<_Usuario> implements _Usuario {
  get name => null;
}

class _Usuario {
  @primaryKey
  late int? u_clave;

  @Column(unique: true)
  late String? u_user;

  @Column()
  late String? u_nombre;

  @Column()
  late String? u_apellido;

  @Column()
  late String? u_email;

  @Column()
  late String? u_password;

  @Column()
  late String? u_segundonombre;

  @Column()
  late String? u_segundoapellido;
}
