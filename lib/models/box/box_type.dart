enum BoxType { social, future, rewind }

extension BoxTypeExtension on BoxType {
  static BoxType fromString(String type) {
    switch (type) {
      case 'future':
        return BoxType.future;
      case 'rewind':
        return BoxType.rewind;
      case 'social':
        return BoxType.social;
      // aggiungi altri casi se necessario
      default:
        throw Exception('Unknown BoxType: $type');
    }
  }
}
