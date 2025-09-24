/// アプリケーション例外の基底クラス
abstract class AppException implements Exception {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  const AppException({required this.message, this.originalError, this.stackTrace});

  @override
  String toString() => message;
}

/// ファイルが見つからない例外
class FileNotFoundException extends AppException {
  const FileNotFoundException({required String filePath, super.originalError, super.stackTrace})
    : super(message: 'ファイルが見つかりません: $filePath');
}

/// 音楽再生エラー
class AudioPlaybackException extends AppException {
  const AudioPlaybackException({required super.message, super.originalError, super.stackTrace});
}

/// インポートエラー
class ImportException extends AppException {
  const ImportException({required super.message, super.originalError, super.stackTrace});
}

/// メタデータ抽出エラー
class MetadataException extends AppException {
  const MetadataException({required super.message, super.originalError, super.stackTrace});
}

/// ライブラリアクセスエラー
class LibraryAccessException extends AppException {
  const LibraryAccessException({required super.message, super.originalError, super.stackTrace});
}

/// バリデーションエラー
class ValidationException extends AppException {
  const ValidationException({required super.message});
}
