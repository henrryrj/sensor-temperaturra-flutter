import 'dart:convert';

class Monitor {
  int id;
  double tem;
  double hum;
  String time;
  int idCliente;

  Monitor({
    required this.id,
    required this.tem,
    required this.hum,
    required this.time,
    required this.idCliente 
  });

  Monitor dispositivoFromJson(String str) =>
      Monitor.fromJson(json.decode(str));

  String dispositivoToJson(Monitor data) => json.encode(data.toJson());

  factory Monitor.fromJson(Map<String, dynamic> json) => Monitor(
        id: json["id"],
        tem: json["Tem"].toDouble(),
        hum: json["Hum"].toDouble(),
        time: json["ultimoRegistro"],
        idCliente: json["estado"].toInt()
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Tem": tem,
        "Hum": hum,
        "ultimoRegistro": time,
        "estado": idCliente
      };
}