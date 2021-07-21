class Data {
  final String name;
  final double dist;
  final String kinds;
  Data({
    required this.name,
    required this.dist,
    required this.kinds,
  });
  Data copyWith({
    String? name,
    double? dist,
    String? kinds,
  }) {
    return Data(
      name: name ?? this.name,
      dist: dist ?? this.dist,
      kinds: kinds ?? this.kinds,
    );
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'],
      dist: map['dist']?.toDouble(),
      kinds: map['kinds'],
    );
  }
}

