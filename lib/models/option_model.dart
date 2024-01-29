class Option {
  int? id;
  String? name;
  double? price;
  Option({
    this.id,
    this.name,
    this.price,
  });

  Option copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return Option(
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

  factory Option.fromJson(Map<String, dynamic> map) {
    return Option(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  @override
  String toString() => 'Option(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(covariant Option other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}
