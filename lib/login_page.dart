import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();

  // Estado para mostrar u ocultar el spinner de carga
  bool isLoading = false;

  /// Función que realiza el login con Parse (Back4App)
  void doUserLogin() async {
    setState(() => isLoading = true);

    final username = controllerUser.text.trim();
    final password = controllerPassword.text.trim();

    // Creamos el usuario con Parse y llamamos a login()
    final user = ParseUser(username, password, null);
    final response = await user.login();

    setState(() => isLoading = false);

    if (response.success) {
      // Si el login es exitoso, navegamos al panel principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Si falla, mostramos el error como SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para calcular el 50%
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth * 0.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Imagen del logo ubicada arriba del formulario
              Image.asset(
                'assets/logo3.png',
                height: 120,
              ),
              const SizedBox(height: 32),

              // Contenedor que limita el ancho al 50% de la pantalla
              SizedBox(
                width: formWidth < 400 ? 400 : formWidth, // mínimo 400px para móviles
                child: Column(
                  children: [
                    // Campo de texto para el nombre de usuario
                    TextField(
                      controller: controllerUser,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(color: Color(0xFF000099)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.person,color:Color(0xFF000099)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Campo de texto para la contraseña (oculta)
                    TextField(
                      controller: controllerPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Color(0xFF000099)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.lock,color:Color(0xFF000099)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Botón de login (muestra un spinner si está cargando)
                    isLoading
                        ? CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: doUserLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF000099), // azul corporativo
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Iniciar Sesión',
                                style: TextStyle(fontSize: 16,color: Colors.white,),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
