enum Category { interactive, text }

extension CategoryExtension on Category {
  static Category fromString(String category) {
    switch (category) {
      case 'interactive':
        return Category.interactive;
      case 'text':
        return Category.text;
      default:
        throw Exception('Unknown Category: $category');
    }
  }
}
