import 'package:flutter/material.dart';
import 'package:proyectoflutter/design.dart';
import 'package:proyectoflutter/style.dart';
import 'Usuarios.dart'; 
import 'producto.dart';
import 'Pedidos.dart';
import 'categoria.dart';
import 'Cliente.dart';
import 'DetallePedido.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Usuario()),
                );
              },
              style: AppStyle.buttonStyle1(context),
              child: Text('Usuarios', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Producto()),
                );
              },
              style: AppStyle.buttonStyle1(context),
              child: Text('Productos', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pedidos()),
                );
              },
              style: AppStyle.buttonStyle1(context),
              child: Text('Pedidos', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
             ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Categorias()),
                );
              },
              style: AppStyle.buttonStyle1(context),
              child: Text('Categorias', style: AppDesign.boton),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Clientes()),
              );
            },
            style: AppStyle.buttonStyle1(context),
            child: Text('Clientes', style: AppDesign.boton),
          ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetallePedido()),
                );
              },
              style: AppStyle.buttonStyle1(context),
              child: Text('Detalle del pedido', ),
            )
          ],
        ),
      ),
    );
  }
}
