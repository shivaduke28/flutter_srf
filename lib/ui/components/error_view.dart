import 'package:flutter/material.dart';
import '../../errors/exceptions.dart';

/// エラー表示用の共通ウィジェット
class ErrorView extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    required this.error,
    this.stackTrace,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (icon, message) = _getErrorDetails(error);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: colorScheme.error.withAlpha(128),
            ),
            const SizedBox(height: 16),
            Text(
              'エラーが発生しました',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  (IconData, String) _getErrorDetails(Object error) {
    if (error is AppException) {
      if (error is FileNotFoundException) {
        return (Icons.search_off, error.message);
      } else if (error is AudioPlaybackException) {
        return (Icons.music_off, error.message);
      } else if (error is ImportException) {
        return (Icons.cloud_off, error.message);
      } else if (error is MetadataException) {
        return (Icons.info_outline, error.message);
      } else if (error is LibraryAccessException) {
        return (Icons.folder_off, error.message);
      } else if (error is ValidationException) {
        return (Icons.warning_amber, error.message);
      } else {
        return (Icons.error_outline, error.message);
      }
    } else {
      return (Icons.error_outline, '予期しないエラーが発生しました: ${error.toString()}');
    }
  }
}

/// エラーメッセージを表示するためのヘルパー関数
void showErrorSnackBar(BuildContext context, Object error) {
  final message = error is AppException
      ? error.message
      : 'エラーが発生しました: ${error.toString()}';

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: '閉じる',
        textColor: Theme.of(context).colorScheme.onError,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}