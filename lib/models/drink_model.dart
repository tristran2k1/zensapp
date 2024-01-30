import 'package:intl/intl.dart';

class Drink {
  int? id;
  String? name;
  String? img;
  String? description;
  double? price;
  double? salePrice;
  double? favorite;
  double? rating;
  bool isFavorite = false;
  Drink({
    this.id,
    this.name,
    this.img,
    this.description,
    this.price,
    this.salePrice,
    this.favorite,
    this.rating,
  });

  Drink copyWith({
    int? id,
    String? name,
    String? img,
    String? description,
    double? price,
    double? salePrice,
    double? favorite,
    double? rating,
  }) {
    return Drink(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      description: description ?? this.description,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      favorite: favorite ?? this.favorite,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'favorite': favorite,
      'rating': rating,
    };
  }

  factory Drink.fromJson(Map<String, dynamic> map) {
    return Drink(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      salePrice: map['salePrice'] != null ? map['salePrice'] as double : null,
      favorite: map['favorite'] != null ? map['favorite'] as double : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
    );
  }

  @override
  String toString() {
    return 'Drink(id: $id, name: $name, img: $img, description: $description, price: $price, salePrice: $salePrice, favorite: $favorite, rating: $rating)';
  }

  @override
  bool operator ==(covariant Drink other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.img == img &&
        other.description == description &&
        other.price == price &&
        other.salePrice == salePrice &&
        other.favorite == favorite &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        img.hashCode ^
        description.hashCode ^
        price.hashCode ^
        salePrice.hashCode ^
        favorite.hashCode ^
        rating.hashCode;
  }

  List<Drink> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => Drink.fromJson(e)).toList();
  }

  String getPrice() {
    if (price != null) {
      final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
      final formattedNumber = numberFormat.format(price);
      return formattedNumber;
    }
    return '0';
  }

  String getFavorite() => formatNumber(favorite ?? 0.0);

  String getRating() => formatNumber(rating ?? 0.0);

  String formatNumber(double value) {
    final numberFormat = NumberFormat.compact();
    final formattedNumber = numberFormat.format(value);
    return formattedNumber;
  }
}
