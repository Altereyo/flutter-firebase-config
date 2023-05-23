class News {
  final String? title;
  final String? description;

//<editor-fold desc="Data Methods">
  const News({
    this.title,
    this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is News &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description);

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  @override
  String toString() {
    return 'News{ title: $title, description: $description,}';
  }

  News copyWith({
    String? title,
    String? description,
  }) {
    return News(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

//</editor-fold>
}