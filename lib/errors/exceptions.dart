/// アプリケーション例外の基底クラス
abstract class AppException implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

/// ファイルが見つからない例外
class FileNotFoundException extends AppException {
  const FileNotFoundException({
    required String filePath,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message: 'ファイルが見つかりません: $filePath',
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// 音楽再生エラー
class AudioPlaybackException extends AppException {
  const AudioPlaybackException({
    required String message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// インポートエラー
class ImportException extends AppException {
  const ImportException({
    required String message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// メタデータ抽出エラー
class MetadataException extends AppException {
  const MetadataException({
    required String message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// ライブラリアクセスエラー
class LibraryAccessException extends AppException {
  const LibraryAccessException({
    required String message,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

/// バリデーションエラー
class ValidationException extends AppException {
  const ValidationException({
    required String message,
  }) : super(message: message);
}