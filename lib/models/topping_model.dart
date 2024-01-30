class Topping {
  int? id;
  String? name;
  double? price;
  Topping({
    this.id,
    this.name,
    this.price,
  });

  Topping copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return Topping(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory Topping.fromJson(Map<String, dynamic> map) {
    return Topping(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  @override
  String toString() => 'Topping(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(covariant Topping other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;

  List<Topping> fromJsonList(List<dynamic> list) {
    return list.map((e) => Topping.fromJson(e)).toList();
  }
}
