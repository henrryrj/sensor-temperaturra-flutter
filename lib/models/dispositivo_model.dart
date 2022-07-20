import 'dart:convert';

class Dispositivo {
  String id;
  double? temp;
  double? hum;
  String ultimoRegistro;
  bool estado;

  Dispositivo({
    required this.id,
    this.temp,
    this.hum,
    required this.ultimoRegistro,
    required this.estado 
  });

  Dispositivo dispositivoFromJson(String str) =>
      Dispositivo.fromJson(json.decode(str));

  String dispositivoToJson(Dispositivo data) => json.encode(data.toJson());

  factory Dispositivo.fromJson(Map<String, dynamic> json) => Dispositivo(
        id: json["id"],
        temp: json["temp"].toDouble(),
        hum: json["hum"].toDouble(),
        ultimoRegistro: json["ultimoRegistro"],
        estado: json["estado"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temp": temp,
        "hum": hum,
        "ultimoRegistro": ultimoRegistro,
        "estado": estado
      };
}
