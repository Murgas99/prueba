import 'package:flutter/material.dart';
import 'package:prueba/main.dart';
import 'package:prueba/tarea.dart';

class nuevaTarea extends StatefulWidget {
  final Tarea tarea;
  final String appBarTitle;
  ListaTareasState listaTareasState;
  int posicion;

  nuevaTarea(this.tarea, this.appBarTitle, this.listaTareasState,
      [this.posicion = -1]);

  @override
  State<StatefulWidget> createState() {
    return new NuevaTareaState(tarea, appBarTitle, listaTareasState, posicion);
  }
}

class NuevaTareaState extends State<nuevaTarea> {
  ListaTareasState listaTareasState;
  Tarea tarea;
  String titulo;
  int posicion;
  bool marcado = false;

  NuevaTareaState(
      this.tarea, this.titulo, this.listaTareasState, this.posicion);

  TextEditingController tareaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    tareaController.text = tarea.nombre;
    return Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
            leading: new GestureDetector(
                child: Icon(Icons.close),
                onTap: () {
                  Navigator.pop(context);
                  listaTareasState.actualizarListView();
                }),
            title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: _estaEditando()
                    ? CheckboxListTile(
                        title: const Text("completada"),
                        value: marcado,
                        onChanged: (bool? valor) {
                          setState(() {
                            marcado = valor!;
                          });
                        },
                      )
                    : Container(
                        height: 2,
                      )),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: tareaController,
                  decoration: const InputDecoration(
                    labelText: "tarea",
                    hintText: "Ej. Aprender Flutter",
                  ),
                  onChanged: (value) {
                    actualizaTarea();
                  },
                )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: const Text("guardar"),
                onPressed: () {
                  setState(() {
                    _guardar();
                  });
                },
              ),
            )
          ],
        ));
  }

  void _guardar() {
    if (_estaEditando()) {
      if (marcado) {
        tarea.estado = "completada";
      }
    }
    tarea.nombre = tareaController.text;
    if (_comprobarNoNull()) {
      if (!_estaEditando())
        listaTareasState.listaTareas.add(tarea);
      else
        listaTareasState.listaTareas[posicion] = tarea;

      listaTareasState.actualizarListView();
      Navigator.pop(context); //cierra el dialogo de edición o creación
      mostrarSnackBar("Tarea guardada correctamente");
    }
  }

  bool _comprobarNoNull() {
    bool res = true;
    if (tareaController.text.isEmpty) {
      mostrarSnackBar("LA TAREA ES OBLIGARORIA");
      res = false;
    }
    return res;
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 1, milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void actualizaTarea() {
    tarea.nombre = tareaController.text;
  }

  bool _estaEditando() {
    bool editanto = true;
    if (this.posicion == -1) editanto = false;
    return editanto;
  }
}
