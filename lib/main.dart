import 'package:flutter/material.dart';
import 'package:prueba/tarea.dart';
import 'package:prueba/fichatarea.dart';
import 'package:prueba/nuevatarea.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lista de tarea",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      // For simplicity, we'll just print the username and password
      print('Username: $_username');
      print('Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(
        top: 200,
      ),
      child: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/grafo.png"),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Correo:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor escriba el correo';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contraseña:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor escriba la contraseña';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListaTareas(),
                      ));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black26)),
                    child: const Text('Iniciar sesión')),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class ListaTareas extends StatefulWidget {
  const ListaTareas({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListaTareasState();
  }
}

class ListaTareasState extends State<ListaTareas> {
  late List<Tarea> listaTareas = [];

  @override
  Widget build(BuildContext context) {
    if (listaTareas == null) listaTareas = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("LISTA DE TAREAS"),
      ),
      body: ListView.builder(
          itemCount: listaTareas.length,
          itemBuilder: (BuildContext context, int posicion) {
            final item = listaTareas[posicion];
            return GestureDetector(
                onTap: () {
                  _editaTarea(listaTareas[posicion], this, posicion);
                },
                child: Dismissible(
                  key: Key(item.nombre),
                  onDismissed: (direction) {
                    eliminar(posicion);
                  },
                  child: Card(
                      margin: const EdgeInsets.all(1.0),
                      elevation: 2.0,
                      child: FichaTarea(
                        titulo: item.nombre,
                        estado: item.estado,
                      )),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Añadir tarea",
        child: Icon(Icons.add),
        onPressed: () {
          _crearTarea(this);
        },
      ),
    );
  }

  void _crearTarea(ListaTareasState obj) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                nuevaTarea(Tarea("", ""), "Añadir tarea", obj)));
    actualizarListView();
  }

  void _editaTarea(Tarea tarea, ListaTareasState obj, int posicion) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                nuevaTarea(tarea, 'editar tarea', obj, posicion)));
    actualizarListView();
  }

  void eliminar(int posicion) {
    listaTareas.removeAt(posicion);

    actualizarListView();
  }

  void actualizarListView() {
    setState(() {
      listaTareas = listaTareas;
    });
  }
}
