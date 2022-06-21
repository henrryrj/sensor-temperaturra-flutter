import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:lista_app/models/dispositivo_model.dart';

class DispositivoService {
  Future<List<Dispositivo>> getDispositivos() async {
    List<Dispositivo> listaDispositivos = [];
    final req = await http
        .get(Uri.parse('https://api-node-mysql-sd.herokuapp.com/getListaDeDispositivos'));
    final resp = convert.jsonDecode(req.body);
    listaDispositivos = resp
        .map<Dispositivo>((e) => Dispositivo(
            id: e["id"],
            tem: e["Tem"].toDouble(),
            hum: e["Hum"].toDouble(),
            ultimoRegistro: e["ultimoRegistro"],
            estado: e["estado"].toInt()
            ))
        .toList();
    debugPrint(resp.toString());
    return listaDispositivos;
  }
}
