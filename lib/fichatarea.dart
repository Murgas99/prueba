import 'package:flutter/material.dart';

class FichaTarea extends StatelessWidget {
  final String titulo;
  final String estado;

  const FichaTarea({
    Key? key,
    required this.titulo,
    required this.estado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titulo,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(estado,
                    style: const TextStyle(fontStyle: FontStyle.italic))
              ],
            )),
          ],
        ));
  }
}
