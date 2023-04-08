import '../carpetas_crud.dart';

class Carpeta extends ManagedObject<_Carpeta> implements _Carpeta {
  get name => null;
}

class _Carpeta {
  @primaryKey
  late int? c_clave;

  @Column()
  late String? c_nombre;

  @Column()
  late String? c_tipo;

  @Column()
  late String? fk_usuario;

}