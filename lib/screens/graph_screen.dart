import 'package:flutter/material.dart';
import 'package:lista_app/models/dispositivo_model.dart';
import 'package:lista_app/models/monitor_model.dart';
import '../services/dispositivo_service.dart';
import 'grafico_Widget.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final dispositivoService = DispositivoService();
  List<Monitor> listaDisp = [];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Dispositivo dispositivoActual =
        ModalRoute.of(context)!.settings.arguments as Dispositivo;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
          title: const Text('Monitor de Temperaturas'),
          elevation: 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _body(dispositivoActual)
    );
  }

  Widget _body(Dispositivo dispositivo) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: [
        GraphWidget(tipo: "Diario", dispositivo: dispositivo),
        GraphWidget(tipo: "Semanal", dispositivo: dispositivo),
        GraphWidget(tipo: "Mensual", dispositivo: dispositivo)
      ],
    );
  }
}
