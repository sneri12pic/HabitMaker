class Companion {
  final String id;
  final String name;
  final String avatarKey;

  const Companion({
    required this.id,
    required this.name,
    required this.avatarKey,
  });

  Companion copyWith({
    String? id,
    String? name,
    String? avatarKey,
  }) {
    return Companion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarKey: avatarKey ?? this.avatarKey,
    );
  }
}
