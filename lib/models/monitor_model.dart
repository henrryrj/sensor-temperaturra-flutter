import 'dart:convert';

class Monitor {
  double temp;
  String time;
  String idDispositivo;

  Monitor({
    required this.temp,
    required this.time,
    required this.idDispositivo,
  });

  Monitor dispositivoFromJson(String str) =>
      Monitor.fromJson(json.decode(str));

  String dispositivoToJson(Monitor data) => json.encode(data.toJson());

  factory Monitor.fromJson(Map<String, dynamic> json) => Monitor(
        temp: json["temp"].toDouble(),
        time: json["time"],
        idDispositivo: json["idDispositivo"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "time": time,
        "idDispositivo": idDispositivo
      };
}