class AddressModel {
  int id;
  String name;
  String street;
  int number;
  String postalCode;
  String state;
  String municipality;
  String settlement;
  String additional;
  bool mark;

  AddressModel({
    required this.id,
    required this.name,
    required this.street,
    required this.number,
    required this.postalCode,
    required this.state,
    required this.municipality,
    required this.settlement,
    required this.additional,
    required this.mark,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"] as int,
        name: json["name"],
        street: json["street"],
        number: json["number"] as int,
        postalCode: json["postal_code"],
        state: json["state"],
        municipality: json["municipality"],
        settlement: json["settlement"],
        additional: json["additional"],
        mark: json["mark"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "street": street,
        "number": number,
        "postal_code": postalCode,
        "state": state,
        "municipality": municipality,
        "settlement": settlement,
        "additional": additional,
        "mark": mark,
      };
}
