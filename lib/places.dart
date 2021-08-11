class Places {
  final String name;
  final double dist;
  final String kinds;
  Places({
    required this.name,
    required this.dist,
    required this.kinds,
  });
  Places copyWith({
    String? name,
    double? dist,
    String? kinds,
  }) {
    return Places(
      name: name ?? this.name,
      dist: dist ?? this.dist,
      kinds: kinds ?? this.kinds,
    );
  }

  factory Places.fromMap(Map<String, dynamic> map) {
    return Places(
      name: map['name'],
      dist: map['dist']?.toDouble(),
      kinds: map['kinds'],
    );
  }
}
