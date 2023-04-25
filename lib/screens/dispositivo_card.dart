import 'package:flutter/material.dart';
import 'package:lista_app/models/dispositivo_model.dart';

class DispositivoCard extends StatelessWidget {
  final Dispositivo dispositivo;
  const DispositivoCard({Key? key, required this.dispositivo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.lightBlue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //border: Border.all(color: const Color.fromRGBO(164, 164, 166, 1.0)),
        ),
        child: Column(
          children: [
            titulo(dispositivo.id.toString()),
            listaPropiedades(
                dispositivo.temp.toString(), dispositivo.hum.toString()),
            propiedades("Ultimo Registro: ", dispositivo.ultimoRegistro),
            verGraficaButton(context, dispositivo)
          ],
        ),
      ),
    );
  }

  Widget verGraficaButton(BuildContext context, Dispositivo disp) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0, backgroundColor: const Color.fromRGBO(61, 61, 61, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        onPressed: () async {
          Navigator.pushNamed(context, 'graphScreen', arguments: disp);
/*           Navigator.pushNamed(context, 'encuestaNoRelacional',
              arguments: widget.encuesta);
          final aplicacionService =
              Provider.of<AplicacionService>(context, listen: false);
          aplicacionService.aplicacionMode = false; */
        },
        child: const Center(
          child: Text(
            'Ver Grafica',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    );
  }

  Widget titulo(String nombre) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(nombre,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                Expanded(child: Container()),
                Text(dispositivo.estado == false ? 'Off: ' : 'On: ',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: dispositivo.estado == false
                            ? Colors.black54
                            : Colors.green,
                        fontWeight: FontWeight.bold)),
                Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                      color: dispositivo.estado == false
                          ? Colors.grey.shade600
                          : Colors.green,
                      borderRadius: BorderRadius.circular(150)),
                )
              ],
            )));
  }

  Widget propiedades(String prefijo, String dato) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
                prefijo == 'Ultimo Registro: ' && dato == '-1'
                    ? 'Sin Registros'
                    : '$prefijo $dato',
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold))));
  }

  Widget listaPropiedades(String tem, String hum) {
    return Row(
      children: [
        propiedades("Tem: ", tem),
        Container(width: 10),
        propiedades("Hum: ", hum)
      ],
    );
  }
}
