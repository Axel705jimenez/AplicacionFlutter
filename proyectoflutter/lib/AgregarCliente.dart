import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoflutter/design.dart';
import 'package:proyectoflutter/style.dart';

class AgregarCliente extends StatefulWidget {
  @override
  _AgregarClienteState createState() => _AgregarClienteState();
}

class _AgregarClienteState extends State<AgregarCliente> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String apellido = '';
  String direccion = '';
  String telefono = '';
  String correo = '';

  Future<void> agregarCliente() async {
    try {
      final response = await http.post(
        Uri.parse('https://192.168.1.19:7019/api/Cliente'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre,
          'apellido': apellido,
          'direccion': direccion,
          'telefono': telefono,
          'correo': correo,
          'estatus': 1, 
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        print('Failed to add client. Response: ${response.body}');
        throw Exception('Failed to add client: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo agregar el cliente. Inténtelo de nuevo más tarde.\nError: $e'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool isValidEmail(String email) {
    final validDomains = ['@gmail.com', '@hotmail.com', '@outlook.com', '@icloud.com'];
    return validDomains.any((domain) => email.endsWith(domain));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar un cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: AppStyle.inputDecoratio(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca el nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      nombre = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: AppStyle.inputDecoratio(labelText: 'Apellido'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca el apellido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      apellido = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: AppStyle.inputDecoratio(labelText: 'Dirección'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca la dirección';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      direccion = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: AppStyle.inputDecoratio(labelText: 'Teléfono'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca el teléfono';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      telefono = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: AppStyle.inputDecoratio(labelText: 'Correo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduzca el correo';
                    }
                    if (!isValidEmail(value)) {
                      return 'El correo debe ser @gmail.com, @hotmail.com, @outlook.com o @icloud.com';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      correo = value;
                    });
                  },
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      agregarCliente();
                    }
                  },
                  style: AppStyle.buttonStyle1(context),
                  child: Text('Agregar', style: AppDesign.boton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
