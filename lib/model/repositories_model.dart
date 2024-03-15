class RepositoryModel {
  final String name;
  final String owner;
  bool isFavorite;

  RepositoryModel({
    required this.name,
    required this.owner,
    this.isFavorite = false,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      owner: json['owner']['login'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  factory RepositoryModel.fromSharedPreferences(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'],
      owner: json['owner'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'owner': owner,
        'isFavorite': isFavorite,
      };

  RepositoryModel copyWith({
    String? name,
    String? owner,
    String? description,
    bool? isFavorite,
  }) {
    return RepositoryModel(
      name: name ?? this.name,
      owner: owner ?? this.owner,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
