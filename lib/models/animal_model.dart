class Animal {
  Animal({
    this.nombre,
    this.sexo,
    this.tipo,
    this.edad,
  });

  String? nombre;
  String? sexo;
  String? tipo;
  String? edad;

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        nombre: json["nombre"],
        sexo: json["sexo"],
        tipo: json["tipo"],
        edad: json["Edad"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "sexo": sexo,
        "tipo": tipo,
        "Edad": edad,
      };
  List<Animal> cargarAnimales() {
    List<Animal> listaAnimales = [];
    listaAnimales.add(
        Animal(nombre: "Simon", sexo: "Macho", tipo: "Perro", edad: "4 meses"));
    listaAnimales.add(
      Animal(nombre: "Dukeza", sexo: "Hembra", tipo: "Perro", edad: "4 meses"));
    listaAnimales.add(
        Animal(nombre: "Negro", sexo: "Macho", tipo: "Gato", edad: "12 meses"));
    listaAnimales.add(
        Animal(nombre: "Manchita", sexo: "Hembra", tipo: "Caballo", edad: "5 meses"));
    listaAnimales.add(
        Animal(nombre: "Coco", sexo: "Macho", tipo: "Gato", edad: "5 meses"));
    listaAnimales.add(
        Animal(nombre: "Fifi", sexo: "Hembra", tipo: "Pato", edad: "5 meses"));
    listaAnimales.add(
        Animal(nombre: "Rodolfo", sexo: "Macho", tipo: "Conejo", edad: "5 meses"));
    return listaAnimales;
  }
}
