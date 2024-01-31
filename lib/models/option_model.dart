import 'package:intl/intl.dart';

class DrinkOption {
  int? id;
  String? name;
  double? price;
  DrinkOption({
    this.id,
    this.name,
    this.price,
  });

  DrinkOption copyWith({
    int? id,
    String? name,
    double? price,
  }) {
    return DrinkOption(
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

  factory DrinkOption.fromJson(Map<String, dynamic> map) {
    return DrinkOption(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
    );
  }

  @override
  String toString() => 'DrinkOption(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(covariant DrinkOption other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;

  List<DrinkOption> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => DrinkOption.fromJson(e)).toList();
  }

  String getPrice() {
    if (price != null) {
      final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
      final formattedNumber = numberFormat.format(price);
      return price! > 0 ? '+$formattedNumber' : formattedNumber;
    }
    return '0đ';
  }
}
