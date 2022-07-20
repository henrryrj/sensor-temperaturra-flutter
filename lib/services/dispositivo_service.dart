
import 'package:http/http.dart' as http;
import 'package:lista_app/models/chart_data.dart';
import 'dart:convert' as convert;

import 'package:lista_app/models/dispositivo_model.dart';
import 'package:lista_app/models/monitor_model.dart';

class DispositivoService {
  String local = 'http://192.168.0.20:3000';
  String disqNube = 'https://96b6-177-222-111-203.sa.ngrok.io';
  String nube = 'https://api-node-mysql-sd.herokuapp.com';
  List<String> grupos = ['https://api-distribuidos-1-2022.herokuapp.com'];

  Future<List<Dispositivo>> getDispositivos() async {
    List<Dispositivo> listaDispositivos = [];
    final req = await http.get(Uri.parse('$nube/getDispositivos'));
    final resp = convert. jsonDecode(req.body);
    listaDispositivos = resp
        .map<Dispositivo>((e) => Dispositivo(
            id: e["id"],
            temp: double.parse(e["temp"]),
            hum: double.parse(e["hum"]),
            ultimoRegistro: e["ultimoRegistro"],
            estado: e["estado"]))
        .toList();
    return listaDispositivos;
  }

  Future<List<Monitor>> getHistorialPorDia(String id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse('$nube/getHistorialPorDia/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            temp: double.parse(e["temp"]),
            time: e["time"],
            idDispositivo: e["idDispositivo"]))
        .toList();
    return listaHistorial;
  }

  Future<List<Monitor>> getHistorialPorSemana(String id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse('$nube/getHistorialPorSemana/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            temp: double.parse(e["temp"]),
            time: e["time"],
            idDispositivo: e["idDispositivo"]))
        .toList();
    return listaHistorial;
  }

  Future<List<Monitor>> getHistorialPorMes(String id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse('$nube/getHistorialPorMes/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            temp: double.parse(e["temp"]),
            time: e["time"],
            idDispositivo: e["idDispositivo"]))
        .toList();
    return listaHistorial;
  }

  Future<ChartData> getNuevoDato(String id) async {
    late ChartData nuevoDato;
    final req = await http.get(Uri.parse('$nube/getNuevoDato/$id'));
    final resp = convert.jsonDecode(req.body);
    nuevoDato = ChartData(
        temp: resp["temp"].toDouble(),
        time: resp["time"],
        estado: resp["estado"]);
    return nuevoDato;
  }
}
