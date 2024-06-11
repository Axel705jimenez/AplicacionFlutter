import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoflutter/design.dart';
import 'package:proyectoflutter/style.dart';
import 'menu.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  
  Future<void> _login() async {
    final String url = 'https://192.168.1.19:7019/api/Usuario';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);
        final user = users.firstWhere(
          (user) => user['correo'] == _emailController.text && user['contrasena'] == _passwordController.text,
          orElse: () => null,
        );

        if (user != null) {
          Navigator.push( 
            context,
            MaterialPageRoute(builder: (context) => Menu()),
          );
        } else {
          setState(() {
            _message = 'Credenciales incorrectas';
          });
        }
      } else {
        setState(() {
          _message = 'Error del servidor. Código de estado: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error de conexión: $e';
      });
    } finally {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  bool _isEmailValid(String email) {
    final validDomains = ['@gmail.com', '@hotmail.com', '@outlook.com', '@icloud.com'];
    return validDomains.any((domain) => email.endsWith(domain));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAYITO STORE', style: AppDesign.titleTextStyle),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: AppStyle.inputDecoratio(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: AppStyle.inputDecoratio(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _message = '';
                });
                if (_isEmailValid(_emailController.text)) {
                  _login();
                } else {
                  setState(() {
                    _message = 'Correo electrónico no válido. Use @gmail.com, @hotmail.com, @outlook.com, o @icloud.com';
                  });
                }
              },
              style: AppStyle.buttonStyle(context),
              child: Text('Iniciar sesión', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
            Text(_message),
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
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
