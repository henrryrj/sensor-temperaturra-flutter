import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:lista_app/models/dispositivo_model.dart';
import 'package:lista_app/models/monitor_model.dart';

class DispositivoService {
  Future<List<Dispositivo>> getDispositivos() async {
    List<Dispositivo> listaDispositivos = [];
    final req = await http.get(Uri.parse(
        'https://api-node-mysql-sd.herokuapp.com/getListaDeDispositivos'));
    final resp = convert.jsonDecode(req.body);
    listaDispositivos = resp
        .map<Dispositivo>((e) => Dispositivo(
            id: e["id"],
            tem: e["Tem"].toDouble(),
            hum: e["Hum"].toDouble(),
            ultimoRegistro: e["ultimoRegistro"],
            estado: e["estado"].toInt()))
        .toList();
    return listaDispositivos;
  }

  Future<List<Monitor>> getHistorialPorDia(int id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse(
        'https://api-node-mysql-sd.herokuapp.com/getHistorialPorDia/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            id: e["id"],
            tem: e["Temp"].toDouble(),
            hum: e["Hum"].toDouble(),
            time: e["time"],
            idCliente: e["idCliente"].toInt()))
        .toList();
    return listaHistorial;
  }

  Future<List<Monitor>> getHistorialPorSemana(int id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse(
        'https://api-node-mysql-sd.herokuapp.com/getHistorialPorSemana/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            id: e["id"],
            tem: e["Temp"].toDouble(),
            hum: e["Hum"].toDouble(),
            time: e["time"],
            idCliente: e["idCliente"].toInt()))
        .toList();
    return listaHistorial;
  }

  Future<List<Monitor>> getHistorialPorMes(int id) async {
    List<Monitor> listaHistorial = [];
    final req = await http.get(Uri.parse(
        'https://api-node-mysql-sd.herokuapp.com/getHistorialPorMes/$id'));
    final resp = convert.jsonDecode(req.body);
    listaHistorial = resp
        .map<Monitor>((e) => Monitor(
            id: e["id"],
            tem: e["Temp"].toDouble(),
            hum: e["Hum"].toDouble(),
            time: e["time"],
            idCliente: e["idCliente"].toInt()))
        .toList();
    return listaHistorial;
  }
}
