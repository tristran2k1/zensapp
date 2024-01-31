class CartItem {
  int? id;
  int? sizeid;
  int? toppingid;
  int? optionid;
  String? note;
  int? quantity;
  CartItem({
    this.id,
    this.sizeid,
    this.toppingid,
    this.optionid,
    this.note,
    this.quantity,
  });

  CartItem copyWith({
    int? id,
    int? sizeid,
    int? toppingid,
    int? optionid,
    String? note,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      sizeid: sizeid ?? this.sizeid,
      toppingid: toppingid ?? this.toppingid,
      optionid: optionid ?? this.optionid,
      note: note ?? this.note,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sizeid': sizeid,
      'toppingid': toppingid,
      'optionid': optionid,
      'note': note,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] != null ? map['id'] as int : null,
      sizeid: map['sizeid'] != null ? map['sizeid'] as int : null,
      toppingid: map['toppingid'] != null ? map['toppingid'] as int : null,
      optionid: map['optionid'] != null ? map['optionid'] as int : null,
      note: map['note'] != null ? map['note'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, sizeid: $sizeid, toppingid: $toppingid, optionid: $optionid, note: $note, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sizeid == sizeid &&
        other.toppingid == toppingid &&
        other.optionid == optionid &&
        other.note == note &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sizeid.hashCode ^
        toppingid.hashCode ^
        optionid.hashCode ^
        note.hashCode ^
        quantity.hashCode;
  }
}
