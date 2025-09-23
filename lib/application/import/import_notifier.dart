import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:flutter_srf/system/importer/track_importer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'import_notifier.freezed.dart';
part 'import_notifier.g.dart';

@freezed
sealed class ImportState with _$ImportState {
  const factory ImportState({
    required int totalFiles,
    required int processedFiles,
    required String currentFile,
    required bool isImporting,
    @Default([]) List<String> errors,
  }) = _ImportState;

  factory ImportState.initial() =>
      const ImportState(totalFiles: 0, processedFiles: 0, currentFile: '', isImporting: false, errors: []);
}

@riverpod
class ImportNotifier extends _$ImportNotifier {
  @override
  ImportState build() {
    return ImportState.initial();
  }

  Future<void> importDirectory(String directoryPath) async {
    if (state.isImporting) return;

    // ライブラリパスを取得
    final appSupport = await getApplicationSupportDirectory();
    final libraryPath = p.join(appSupport.path, 'library');

    // インポーターを取得
    final importer = ref.read(trackImporterProvider);

    // 状態を更新
    state = state.copyWith(isImporting: true, errors: []);

    try {
      // インポート実行（コールバックで進捗を受け取る）
      await importer.importDirectory(directoryPath, libraryPath, (event) {
        switch (event) {
          case ImportStarted(:final totalFiles):
            state = state.copyWith(totalFiles: totalFiles, processedFiles: 0, currentFile: '');
          case ImportProgress(:final processedFiles, :final currentFile):
            state = state.copyWith(processedFiles: processedFiles, currentFile: currentFile);
          case ImportCompleted():
            // 完了処理は下で行う
            break;
          case ImportError(:final filePath, :final error):
            state = state.copyWith(errors: [...state.errors, '$filePath: $error']);
        }
      });

      // インポート完了後、TracksControllerを更新
      await ref.read(tracksControllerProvider.notifier).refresh();

      // 状態を完了に更新
      state = state.copyWith(processedFiles: state.totalFiles, isImporting: false);
    } catch (e) {
      state = state.copyWith(isImporting: false, errors: [...state.errors, e.toString()]);
      rethrow;
    }
  }

  void cancelImport() {
    // Note: 現在の実装では実際のインポート処理をキャンセルすることはできない
    // UIの状態のみをリセット
    state = state.copyWith(isImporting: false);
  }

  double get progress {
    if (state.totalFiles == 0) return 0;
    return state.processedFiles / state.totalFiles;
  }
}
