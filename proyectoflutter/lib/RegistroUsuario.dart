import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:proyectoflutter/design.dart';
import 'package:proyectoflutter/style.dart';
import 'usuarios.dart'; 

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      home: RegistroUsuario(),
    );
  }
}

class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  final _nombreUsuarioController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _correoController = TextEditingController();
  final _rolController = TextEditingController();

  String _connectionMessage = '';

  Future<void> _registrarUsuario() async {
    final String url = 'https://192.168.1.19:7019/api/Usuario';

    if (_nombreUsuarioController.text.isEmpty ||
        _contrasenaController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _rolController.text.isEmpty) {
      setState(() {
        _connectionMessage = 'Todos los campos son obligatorios';
      });
      return;
    }

    try {
      final Map<String, dynamic> requestBody = {
        'nombreUsuario': _nombreUsuarioController.text,
        'contrasena': _contrasenaController.text,
        'correo': _correoController.text,
        'rol': _rolController.text,
        'estatus': 1,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Usuario()),
        );
      } else {
        setState(() {
          _connectionMessage = 'REGISTRO EXITOSO';
        });
        print('Error en la conexión: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _connectionMessage = 'No se pudo conectar a la API';
      });
      print('Error en la conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAYITO STORE'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nombreUsuarioController,
              decoration: AppStyle.inputDecoratio(labelText: 'Nombre de usuario'),
            ),
            SizedBox(height: 32.0),
             TextField(
              controller: _correoController,
              decoration: AppStyle.inputDecoratio(labelText: 'Correo elctrónico'),
            ),
                        SizedBox(height: 32.0),
            TextField(
              controller: _contrasenaController,
              decoration: AppStyle.inputDecoratio(labelText: 'Contraseña'),
              obscureText: true,
            ),           
            SizedBox(height: 32.0),
            TextField(
              controller: _rolController,
              decoration: AppStyle.inputDecoratio(labelText: 'Rol'),
            ),
            SizedBox(height: 16.0),
            Text(_connectionMessage),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _registrarUsuario,
              style: AppStyle.buttonStyle1(context),
              child: Text('Crear usuario', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) =>
          true;
  }
}
