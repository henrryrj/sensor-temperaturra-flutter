import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart';
import 'package:lista_app/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/monitor_model.dart';
import '../services/dispositivo_service.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final dispositivoService = DispositivoService();
  //late List<LiveData> chartData;
  //late ChartSeriesController _chartSeriesController;
  @override
  Widget build(BuildContext context) {
    final ChartData chartData =
        ModalRoute.of(context)!.settings.arguments as ChartData;
    debugPrint(jsonEncode(chartData.lista));
    return SfCartesianChart(
        title: ChartTitle(text: 'Grafico Diario'),
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Initialize line series
          LineSeries<Monitor, String>(
              dataSource: chartData.lista,
              xValueMapper: (Monitor data, _) =>data.time.substring(10, 16),
              yValueMapper: (Monitor data, _) => data.tem,
              // Render the data label
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ]);
  }

/*   int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  } */
}

