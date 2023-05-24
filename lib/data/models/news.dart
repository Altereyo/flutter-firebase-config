class News {
  final int? id;
  final String? title;
  final String? description;
  final String? imageUrl;

//<editor-fold desc="Data Methods">
  const News({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is News &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          imageUrl == other.imageUrl);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ description.hashCode ^ imageUrl.hashCode;

  @override
  String toString() {
    return 'News{ id: $id, title: $title, description: $description, imageUrl: $imageUrl,}';
  }

  News copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

//</editor-fold>
}