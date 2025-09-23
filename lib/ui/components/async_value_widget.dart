import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_view.dart';

/// AsyncValueの状態に応じて適切なウィジェットを表示するヘルパーウィジェット
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? error;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
    this.loading,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: data,
      loading: () => loading?.call() ?? const _DefaultLoadingWidget(),
      error: (err, stack) =>
          error?.call(err, stack) ??
          ErrorView(
            error: err,
            stackTrace: stack,
            onRetry: onRetry,
          ),
    );
  }
}

/// デフォルトのローディング表示
class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// AsyncValueの状態に応じて異なる処理を実行するためのExtension
extension AsyncValueX<T> on AsyncValue<T> {
  /// エラーの場合はスナックバーを表示し、データの場合は指定の処理を実行
  void whenOrNull({
    void Function(T data)? data,
    void Function(Object error, StackTrace? stackTrace)? error,
  }) {
    if (hasError && error != null) {
      error(this.error!, stackTrace);
    } else if (hasValue && data != null) {
      data(requireValue);
    }
  }

  /// エラーをSnackBarで表示するヘルパー
  void showErrorIfAny(BuildContext context) {
    if (hasError) {
      showErrorSnackBar(context, error!);
    }
  }
}