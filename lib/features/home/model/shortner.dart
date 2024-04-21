import 'dart:convert';

class Shortner {
  final String id;
  final String link;
  final DateTime createdAt;
  Shortner({
    required this.id,
    required this.link,
    required this.createdAt,
  });

  Shortner copyWith({
    String? id,
    String? link,
    DateTime? createdAt,
  }) {
    return Shortner(
      id: id ?? this.id,
      link: link ?? this.link,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'link': link,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Shortner.fromMap(Map<String, dynamic> map) {
    return Shortner(
      id: map['id'] ?? '',
      link: map['link'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shortner.fromJson(String source) =>
      Shortner.fromMap(json.decode(source));

  @override
  String toString() => 'Shortner(id: $id, link: $link, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shortner &&
        other.id == id &&
        other.link == link &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ link.hashCode ^ createdAt.hashCode;
}
