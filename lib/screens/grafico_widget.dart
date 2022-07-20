import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:lista_app/models/chart_data.dart';
import 'package:lista_app/models/dispositivo_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';
import '../models/monitor_model.dart';
import '../services/dispositivo_service.dart';

class GraphWidget extends StatefulWidget {
  final String tipo;
  final Dispositivo dispositivo;
  const GraphWidget({Key? key, required this.tipo, required this.dispositivo})
      : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final dispositivoService = DispositivoService();
  late List<Monitor> listData;
  late ChartSeriesController _chartSeriesController;
  TooltipBehavior? _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  int pasada = 0;
  String timeAnterion = "";
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enableDoubleTapZooming: true,
        enablePanning: true,
        enablePinching: true,
        enableSelectionZooming: true);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.tipo == "Diario") {
        Timer.periodic(const Duration(seconds: 8), updateDataSource2);
      }
    });
    _tooltipBehavior = TooltipBehavior(enable: false);
    super.initState();
  }

  List<Monitor> calibrarDiario(List<Monitor> l1) {
    if (l1.length > 30) {
      return l1.sublist(l1.length - 31, l1.length - 1);
    } else {
      return l1;
    }
  }

  List<Monitor> promediarDatos(String tipo, List<Monitor> listaDeDatos) {
    List<Monitor> listaFinal = [];
    if (tipo == "Diario") {
      Monitor datoInicial = listaDeDatos.first;
      String fechaAnterior = datoInicial.time.substring(10, 13);
      int iDia = 0;
      while (listaDeDatos.isNotEmpty) {
        while (datoInicial.time.substring(10, 13) == fechaAnterior) {
          iDia++;
          if (listaDeDatos.isNotEmpty) {
            listaDeDatos.removeAt(0);
            datoInicial = listaDeDatos.first;
          }
          debugPrint(iDia.toString());
        }
      }
    } else if (tipo == "Semanal") {
    } else {}
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.tipo == "Diario"
            ? dispositivoService.getHistorialPorDia(widget.dispositivo.id)
            : widget.tipo == "Semanal"
                ? dispositivoService
                    .getHistorialPorSemana(widget.dispositivo.id)
                : dispositivoService.getHistorialPorMes(widget.dispositivo.id),
        builder: (context, AsyncSnapshot<List<Monitor>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (widget.tipo == "Diario") {
              listData = calibrarDiario(snapshot.data!);
            } else {
              listData = snapshot.data!;
            }
            List<Monitor> xd = promediarDatos(widget.tipo, snapshot.data!);
            return Column(children: [
              SizedBox.fromSize(
                size: const Size.fromHeight(70.0),
                child: Center(
                    child: Text('Grafico ${widget.tipo}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ))),
              ),
              Expanded(
                child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  enableAxisAnimation: true,
                  tooltipBehavior: _tooltipBehavior,
                  // Initialize category axis
                  series: <LineSeries<Monitor, String>>[
                    // Initialize line series
                    LineSeries<Monitor, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: listData,
                        xValueMapper: (Monitor data, _) =>
                            getLabel(widget.tipo, data.time),
                        yValueMapper: (Monitor data, _) =>
                            num.parse(data.temp.toString()),
                        // Render the data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true)),
                  ],

                  primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      labelRotation: widget.tipo != "Diario" ? 90 : 0,
                      title: AxisTitle(
                          text: 'Tiempo (Horas)',
                          alignment: ChartAlignment.center)),
                  primaryYAxis: NumericAxis(
                      //decimalPlaces: 0,
                      title: AxisTitle(
                          text: 'Temperatura Dip (C)',
                          alignment: ChartAlignment.center)),
                ),
              )
            ]);
          }
        });
  }

  void updateDataSource1(Timer timer) async {
    ChartData nuevoDato =
        await dispositivoService.getNuevoDato(widget.dispositivo.id);
    if (nuevoDato.estado != -1 && nuevoDato.estado == 1) {
      Monitor nuevo = Monitor(
          temp: nuevoDato.temp,
          time: nuevoDato.time,
          idDispositivo: widget.dispositivo.id);
      debugPrint(jsonEncode(nuevo));
      listData.add(nuevo);
      if (listData.length > 20) {
        listData.removeAt(0);
        _chartSeriesController.updateDataSource(
            addedDataIndex: listData.length - 1, removedDataIndex: 0);
      }
    } else {
      debugPrint('SIMULACION TIEMPO REAL DETENIDA!!!');
      timer.cancel();
    }
  }

  void updateDataSource2(Timer timer) async {
    List<Monitor> nuevoDato =
        await dispositivoService.getHistorialPorDia(widget.dispositivo.id);
    String timeActual = "";
    late Monitor nuevo;
    debugPrint('DATOS ACTUALES ${listData.length.toString()}');
    if (nuevoDato.isNotEmpty) {
      nuevo = nuevoDato[nuevoDato.length - 1];
      timeActual = nuevo.time;
    } else {
      debugPrint('SIMULACION TIEMPO REAL DETENIDA!!!');
      timer.cancel();
    }
    if (timeActual != timeAnterion) {
      debugPrint(jsonEncode(nuevo));
      listData.add(nuevo);
      listData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: listData.length - 1, removedDataIndex: 0);
      timeAnterion = timeActual;
      pasada = 0;
    } else {
      pasada = pasada + 1;
      debugPrint(pasada.toString());
      if (pasada > 6) {
        timeAnterion = "";
        pasada = 0;
        debugPrint('SIMULACION TIEMPO REAL DETENIDA!!!');
        timer.cancel();
      }
    }
  }

  String getLabel(String tipo, String data) {
    if (tipo == 'Diario') {
      return data.substring(10, 16);
    } else if (tipo == "Semanal") {
      return data.substring(0, 10) + "  " + data.substring(10, 16);
    } else {
      return data.substring(0, 10) + "  " + data.substring(10, 13) + ":00";
    }
  }
}
