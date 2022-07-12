import 'package:flutter/material.dart';
import 'package:lista_app/models/chart_data.dart';
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
  late PageController _controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ChartData chartData =
        ModalRoute.of(context)!.settings.arguments as ChartData;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade300,
          title: const Text('Sistemas Distribuidos'),
          elevation: 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: FutureBuilder(
        future: dispositivoService.getHistorialPorMes(chartData.disp.id),
        builder: (context, AsyncSnapshot<List<Monitor>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _body();
          }
        },
      ),
    );
  }
  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _graph(),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    Alignment _alignment;
    var selected = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );
    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: const Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Diaria", 0),
          _pageItem("Semanal", 1),
          _pageItem("Mensual", 2),
        ],
      ),
    );
  }
  Widget _graph() {
    return const SizedBox(
      height: 250.0,
      child: GraphWidget(),
    );
  }
}
