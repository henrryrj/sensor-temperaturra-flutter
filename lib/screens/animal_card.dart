import 'package:flutter/material.dart';
import 'package:lista_app/models/animal_model.dart';

class AnimalCard extends StatelessWidget {
  final Color color;
  final Animal animal;
  const AnimalCard({Key? key, required this.color, required this.animal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //border: Border.all(color: const Color.fromRGBO(164, 164, 166, 1.0)),
          color: color),
      child: Column(
        children: <Widget>[
        titulo(animal.nombre!), 
        propiedades("Sexo: ", animal.sexo!),
        tipoEdad(animal.tipo!, animal.edad!)
        ],
      ),
    );
  }

  Widget titulo(String nombre) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              nombre,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )));
  }

  Widget propiedades(String prefijo, String dato) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '$prefijo $dato',
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            )));
  }

  Widget tipoEdad(String tipo, String edad) {
    return Row(
      children: [
        propiedades("Tipo: ", tipo),
        Expanded(child: Container()),
        propiedades("Edad: ", edad)
      ],
    );
  }
}
