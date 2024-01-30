class DrinkSize {
  int? id;
  String? name;
  double? price;
  DrinkSize({
    this.id,
    this.name,
    this.price,
  });

  DrinkSize copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return DrinkSize(
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

  factory DrinkSize.fromJson(Map<String, dynamic> map) {
    return DrinkSize(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  @override
  String toString() => 'DrinkSize(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(covariant DrinkSize other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;

  List<DrinkSize> fromJsonList(List<dynamic> json) {
    return json.map((e) => DrinkSize.fromJson(e)).toList();
  }
}
