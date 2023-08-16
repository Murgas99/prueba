class Tarea {
  String _nombre, _estado;

  Tarea(this._nombre, this._estado);

  String get nombre => _nombre;
  String get estado => _estado;

  set nombre(String nuevoNombre) {
    if (nuevoNombre.length <= 100) {
      _nombre = nuevoNombre;
    }
  }

  set estado(String nuevoEstado) => _estado = nuevoEstado;
}
