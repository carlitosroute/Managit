import 'package:flutter/material.dart';
import 'package:managit/home_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// páginas
import 'login_page.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'register_empresa_page.dart';
import 'register_persona_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = '7Lk4bJtx6jxwn5er0ihOQIkRRDdtdjaKeNzOi8U0';
  const keyClientKey = 'YBBk5L5JI1BHoFZ5pGmtJRCwOjPYWtjgmwJPoVwf';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Alquileres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // Página inicial
      home: LoginPage(),

      // Rutas disponibles
      routes: {
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => HomePage(), // O cambia el nombre según uses
        '/registerEmpresa': (context) => RegisterEmpresaPage(),
        '/registerPersona': (context) => RegisterPersonaPage(),
      },
    );
  }
}
