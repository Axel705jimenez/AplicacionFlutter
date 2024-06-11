import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ActualizarCategoria.dart';
import 'AgregarCategoria.dart';

class Categorias extends StatefulWidget {
  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  List<dynamic> categorias = [];

  @override
  void initState() {
    super.initState();
    fetchCategorias();
  }

  Future<void> fetchCategorias() async {
    final response = await http.get(Uri.parse('https://192.168.1.19:7019/api/Categoria'));

    if (response.statusCode == 200) {
      setState(() {
        categorias = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> deleteCategoria(int id) async {
    final response = await http.put(Uri.parse('https://192.168.1.19:7019/api/Categoria/$id/CambiarEstatus'));

    if (response.statusCode == 204) {
      setState(() {
        final index = categorias.indexWhere((categoria) => categoria['idCategoria'] == id);
        categorias[index]['estatus'] = 0;
      });
    } else {
      throw Exception('Failed to delete category');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de categorías'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AgregarCategoria()),
              ).then((value) => fetchCategorias());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          final categoria = categorias[index];
          if (categoria['estatus'] == 0) {
            return SizedBox.shrink();
          }
          return Column(
            children: [
              ListTile(
                title: Text(' ${categoria['idCategoria']}  ${categoria['nombre']}'),
               
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ActualizarCategoria(categoria: categoria),
                          ),
                        ).then((value) => fetchCategorias());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteCategoria(categoria['idCategoria']),
                    ),
                  ],
                ),
              ),
              if (categoria['estatus'] == 1)
                Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 163, 163, 165),
                ),
            ],
          );
        },
      ),
    );
  }
}
