class Player {
  final String id;
  final String name;
  final int extraThrows;

  Player({
    required this.id,
    required this.name,
    this.extraThrows = 0,
  });

  Player copyWith({
    String? id,
    String? name,
    int? extraThrows,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      extraThrows: extraThrows ?? this.extraThrows,
    );
  }
}