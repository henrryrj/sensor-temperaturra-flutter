import 'dart:convert';

class Dispositivo {
  int id;
  double? tem;
  double? hum;
  String ultimoRegistro;
  int estado;

  Dispositivo({
    required this.id,
    this.tem,
    this.hum,
    required this.ultimoRegistro,
    required this.estado 
  });

  Dispositivo dispositivoFromJson(String str) =>
      Dispositivo.fromJson(json.decode(str));

  String dispositivoToJson(Dispositivo data) => json.encode(data.toJson());

  factory Dispositivo.fromJson(Map<String, dynamic> json) => Dispositivo(
        id: json["id"],
        tem: json["Tem"].toDouble(),
        hum: json["Hum"].toDouble(),
        ultimoRegistro: json["ultimoRegistro"],
        estado: json["estado"].toInt()
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Tem": tem,
        "Hum": hum,
        "ultimoRegistro": ultimoRegistro,
        "estado": estado
      };
}
