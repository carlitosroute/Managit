import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'widgets/campo_texto.dart';

class RegisterEmpresaPage extends StatefulWidget {
  @override
  _RegisterEmpresaPageState createState() => _RegisterEmpresaPageState();
}

class _RegisterEmpresaPageState extends State<RegisterEmpresaPage> {
  // Controladores para los campos de texto
  final controllerRazonSocial = TextEditingController();
  final controllerRuc = TextEditingController();
  final controllerDireccion = TextEditingController();
  final controllerTelefono = TextEditingController();
  final controllerCorreo = TextEditingController();

  bool isLoading = false;

  /// Función para guardar la empresa en Back4App
  void registrarEmpresa() async {
    setState(() => isLoading = true);

    // Validación básica
    if (controllerRazonSocial.text.isEmpty ||
        controllerRuc.text.isEmpty ||
        controllerDireccion.text.isEmpty ||
        controllerTelefono.text.isEmpty ||
        controllerCorreo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      setState(() => isLoading = false);
      return;
    }

    final empresa = ParseObject('Empresa')
      ..set('RazonSocial', controllerRazonSocial.text.trim())
      ..set('Ruc', controllerRuc.text.trim())
      ..set('Direccion', controllerDireccion.text.trim())
      ..set('Telefono', controllerTelefono.text.trim())
      ..set('Correo', controllerCorreo.text.trim());

    final response = await empresa.save();

    setState(() => isLoading = false);

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Empresa registrada con éxito')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error?.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Empresa', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF000099),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width < 400 ? 400 : width,
            child: Column(
              children: [
                campoTexto('Razón Social', controllerRazonSocial, Icons.business),
                campoTexto('RUC', controllerRuc, Icons.badge),
                campoTexto('Dirección', controllerDireccion, Icons.location_on),
                campoTexto('Teléfono', controllerTelefono, Icons.phone),
                campoTexto('Correo', controllerCorreo, Icons.email),
                const SizedBox(height: 24),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: registrarEmpresa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF000099),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: Text('Registrar Empresa', style: TextStyle(color: Colors.white)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
