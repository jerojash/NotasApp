import 'package:notes_app/model/carpeta.dart';
import 'package:notes_app/model/user.dart';
import 'package:notes_app/notes_app.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    if (user.username == null || user.password == null) {
      return Response.badRequest(
          body: {"error": "username and password required."});
    }

    user
      ..salt = generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password!, user.salt!);

    final query = Query<User>(context)..values = user;

    final u = await query.insert();
    final token = await authServer.authenticate(
        user.username,
        user.password,
        request?.authorization?.credentials?.username,
        request?.authorization?.credentials?.password);

    final response = AuthController.tokenResponse(token);
    final newBody = u.asMap()..["authorization"] = response.body;


    //CODIGO PARA INSERTAR UNA CARPETA POR DEFAULT
    //BY JAVIER ROJAS
    Map<String, dynamic> bodyCarpeta ={
        'c_nombre': "default",
        'c_tipo': 'default'
    };

    //OBTENGO EL USUARIO CON EL username QUE SE inserto
    final queryGetUser = Query<User>(context)..where((o) => o.username).equalTo(user.username);
    
 
    final userAux = await queryGetUser.fetchOne();

    if(userAux !=null){
      // print('No es nulo');
      // print(userAux.id);

      final queryCarpeta = Query<Carpeta>(context)
      ..values.c_nombre = bodyCarpeta['c_nombre'] as String
      ..values.c_tipo = bodyCarpeta['c_tipo'] as String
      ..values.user = userAux;

      //INSERTO CARPETA
      final insertedCarpeta = await queryCarpeta.insert();
    }
    


    return response..body = newBody;
  }

  @override
  Map<String, APIResponse> documentOperationResponses(
      APIDocumentContext context, Operation operation) {
    return {
      "200": APIResponse.schema("User successfully registered.",
          context.schema.getObject("UserRegistration")),
      "400": APIResponse.schema("Error response", APISchemaObject.freeForm())
    };
  }

  @override
  void documentComponents(APIDocumentContext context) {
    super.documentComponents(context);

    final userSchemaRef = context.schema.getObjectWithType(User);
    final userRegistration = APISchemaObject.object({
      "authorization": APISchemaObject.object({
        "access_token": APISchemaObject.string(),
        "token_type": APISchemaObject.string(),
        "expires_in": APISchemaObject.integer(),
        "refresh_token": APISchemaObject.string(),
        "scope": APISchemaObject.string()
      })
    });

    context.schema.register("UserRegistration", userRegistration);

    context.defer(() {
      final userSchema = context.document.components!.resolve(userSchemaRef);
      userRegistration.properties!.addAll(userSchema!.properties!);
    });
  }
}
