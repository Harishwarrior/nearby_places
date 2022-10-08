class Places {
  final String name;
  final double dist;
  final String kinds;
  final double rate;
  Places({
    required this.name,
    required this.dist,
    required this.kinds,
    required this.rate,
  });
  Places copyWith({
    String? name,
    double? dist,
    String? kinds,
    double? rate,
  }) {
    return Places(
      name: name ?? this.name,
      dist: dist ?? this.dist,
      kinds: kinds ?? this.kinds,
      rate: rate ?? this.rate,
    );
  }

  factory Places.fromMap(Map<String, dynamic> map) {
    return Places(
      name: map['name'],
      dist: map['dist']?.toDouble(),
      kinds: map['kinds'],
      rate: map['rate']?.toDouble(),
    );
  }
}
