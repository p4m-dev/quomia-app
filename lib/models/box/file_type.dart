enum FileType { image, video, audio, text }

extension FileTypeExtension on FileType {
  static FileType? fromString(String type) {
    switch (type) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
      case 'audio':
        return FileType.audio;
      case 'text':
        return FileType.text;
      default:
        return null;
    }
  }
}
