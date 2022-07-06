import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:lista_app/services/dispositivo_service.dart';
import 'package:lista_app/models/dispositivo_model.dart';
import 'package:lista_app/screens/dispositivo_card.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({Key? key}) : super(key: key);

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final dispositivoService = DispositivoService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Dispositivo> listaDisp = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.indigoAccent.shade100,
            title: const Text('Monitor de Temperatura'),
            elevation: 1),
        body: FutureBuilder(
          future: _getDispositivos(),
          builder: (context, AsyncSnapshot<List<Dispositivo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _listViewDispositivos();
            }
          },
        ));
  }

  Widget _listViewDispositivos() {
    return SmartRefresher(
      
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _cargarDispositivos,
      header: WaterDropHeader(
        complete: Icon(Icons.check, color: Colors.indigoAccent.shade100),
        waterDropColor: Colors.indigoAccent.shade100,
      ),
      
      child: listaDisp.isEmpty
          ? Center(child: titulo("Sin Dispositivos!"))
          : ListView.separated(
              itemBuilder: (_, i) => DispositivoCard(
                dispositivo: listaDisp[i], 
              ),
              
              separatorBuilder: (_, i) => const Divider(),
              itemCount: listaDisp.length,
            ),
            
    );
  }

  int randon(int a, int b) {
    Random rnd = Random();
    int r = a + rnd.nextInt(b - a);
    return r;
  }

  Widget titulo(String nombre) {
    return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Text(nombre,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 30.0, color: Colors.black54)));
  }

  void _cargarDispositivos() async {
    listaDisp = await dispositivoService.getDispositivos();
    setState(() {});
    //await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<List<Dispositivo>> _getDispositivos() async {
    listaDisp = await dispositivoService.getDispositivos();
    return listaDisp;
  }
}
