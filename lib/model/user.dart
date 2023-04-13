import 'package:notes_app/notes_app.dart';
import 'package:notes_app/model/carpeta.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String? password;
}

@Table(name: "users")
class _User extends ResourceOwnerTableDefinition {
  @Column(unique: true, indexed: true)
  late String email;

  @Column()
  late String first_name;

  @Column()
  late String middle_name;

  @Column()
  late String first_surname;

  @Column()
  late String second_surname;

  late ManagedSet<Carpeta> folders;
}
