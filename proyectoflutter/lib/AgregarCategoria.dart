import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyectoflutter/design.dart';
import 'package:proyectoflutter/style.dart';

class AgregarCategoria extends StatefulWidget {
  @override
  _AgregarCategoriaState createState() => _AgregarCategoriaState();
}

class _AgregarCategoriaState extends State<AgregarCategoria> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';

  Future<void> agregarCategoria() async {
    final response = await http.post(
      Uri.parse('https://192.168.1.19:7019/api/Categoria'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': nombre,
        'estatus': 1,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      print('Failed to add category. Response: ${response.body}');
      throw Exception('Failed to add category');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar una categoría'),
      ),
      body: Padding(
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
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    agregarCategoria();
                  }
                },
                style: AppStyle.buttonStyle1(context),
              child: Text('Guardar cambios', style: AppDesign.bodyTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
