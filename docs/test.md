# Flutter SRF テスト駆動開発ガイド

## 概要

このドキュメントでは、Flutter SRFプロジェクトにおけるテスト駆動開発（TDD）の方針と実践方法について説明します。

## テスト戦略

### 1. テストの種類と優先順位

#### ユニットテスト（最優先）
- **対象**: モデル、サービス、プロバイダーのビジネスロジック
- **目的**: 個々の機能が正しく動作することを保証
- **カバレッジ目標**: 80%以上

#### ウィジェットテスト（高優先）
- **対象**: カスタムウィジェット、画面UI
- **目的**: UIコンポーネントが期待通りに表示・動作することを確認
- **カバレッジ目標**: 60%以上

#### 統合テスト（中優先）
- **対象**: エンドツーエンドのユーザーフロー
- **目的**: 実際の使用シナリオで正しく動作することを確認
- **カバレッジ目標**: 主要な機能フローをカバー

## テスト環境のセットアップ

### 必要なパッケージ

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
  test: ^1.24.0
  flutter_riverpod_test: ^1.0.0
  fake_async: ^1.3.0
```

### ディレクトリ構造

```
test/
├── unit/
│   ├── models/
│   ├── services/
│   └── providers/
├── widget/
│   ├── screens/
│   └── widgets/
├── integration/
├── fixtures/           # テストデータ
└── helpers/           # テストヘルパー関数
```

## TDDワークフロー

### Red-Green-Refactorサイクル

1. **Red**: 失敗するテストを書く
2. **Green**: テストをパスする最小限のコードを書く
3. **Refactor**: コードをリファクタリングしてクリーンに保つ

### 開発フロー

```bash
# 1. 新機能の開発開始時
flutter test --no-pub  # 既存のテストが全てパスすることを確認

# 2. テストファイルを作成
touch test/unit/services/new_feature_test.dart

# 3. 失敗するテストを書く
# 4. 実装を書く
# 5. テストを実行
flutter test test/unit/services/new_feature_test.dart

# 6. 全体のテストを実行
flutter test

# 7. カバレッジを確認
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 具体的な実装例

### 1. モデルのテスト

```dart
// test/unit/models/srf_metadata_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/models/srf_metadata.dart';

void main() {
  group('SrfMetadata', () {
    test('デフォルト値で作成できる', () {
      // Arrange & Act
      final metadata = SrfMetadata(
        title: 'Test Song',
        artist: 'Test Artist',
      );

      // Assert
      expect(metadata.title, 'Test Song');
      expect(metadata.artist, 'Test Artist');
      expect(metadata.album, '');
      expect(metadata.genre, '');
      expect(metadata.year, 0);
      expect(metadata.duration, 0);
    });

    test('copyWithが正しく動作する', () {
      // Arrange
      final original = SrfMetadata(
        title: 'Original',
        artist: 'Original Artist',
      );

      // Act
      final updated = original.copyWith(title: 'Updated');

      // Assert
      expect(updated.title, 'Updated');
      expect(updated.artist, 'Original Artist');
    });
  });
}
```

### 2. サービスのテスト

```dart
// test/unit/services/metadata_extractor_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_srf/services/metadata_extractor_service.dart';

void main() {
  late MetadataExtractorService service;

  setUp(() {
    service = MetadataExtractorService();
  });

  group('MetadataExtractorService', () {
    test('MP3ファイルからメタデータを抽出できる', () async {
      // Arrange
      const testPath = 'test/fixtures/test.mp3';

      // Act
      final metadata = await service.extractMetadata(testPath);

      // Assert
      expect(metadata.title, isNotEmpty);
      expect(metadata.artist, isNotEmpty);
    });

    test('サポートされていないファイル形式でデフォルト値を返す', () async {
      // Arrange
      const testPath = 'test/fixtures/test.wav';

      // Act
      final metadata = await service.extractMetadata(testPath);

      // Assert
      expect(metadata.title, 'test');
      expect(metadata.artist, 'Unknown Artist');
    });
  });
}
```

### 3. プロバイダーのテスト

```dart
// test/unit/providers/srf_containers_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_srf/providers/srf_containers_provider.dart';
import 'package:flutter_srf/services/library_service.dart';

class MockLibraryService extends Mock implements LibraryService {}

void main() {
  group('SrfContainersProvider', () {
    test('初期状態でコンテナをロードする', () async {
      // Arrange
      final mockService = MockLibraryService();
      when(mockService.listContainers()).thenReturn([]);

      final container = ProviderContainer(
        overrides: [
          libraryServiceProvider.overrideWith(() => mockService),
        ],
      );

      // Act
      final result = await container.read(srfContainersProvider.future);

      // Assert
      expect(result, isEmpty);
      verify(mockService.listContainers()).called(1);
    });
  });
}
```

### 4. ウィジェットのテスト

```dart
// test/widget/widgets/song_list_tile_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_srf/widgets/song_list_tile.dart';
import 'package:flutter_srf/models/srf_metadata.dart';

void main() {
  testWidgets('SongListTileが正しく表示される', (tester) async {
    // Arrange
    final metadata = SrfMetadata(
      title: 'Test Song',
      artist: 'Test Artist',
      album: 'Test Album',
    );

    // Act
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SongListTile(
              metadata: metadata,
              isPlaying: false,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Song'), findsOneWidget);
    expect(find.text('Test Artist'), findsOneWidget);
    expect(find.text('Test Album'), findsOneWidget);
  });

  testWidgets('再生中の曲がハイライトされる', (tester) async {
    // Arrange
    final metadata = SrfMetadata(
      title: 'Playing Song',
      artist: 'Test Artist',
    );

    // Act
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SongListTile(
              metadata: metadata,
              isPlaying: true,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    // Assert
    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(ListTile),
        matching: find.byType(Container),
      ).first,
    );
    expect(container.color, isNotNull);
  });
}
```

## ベストプラクティス

### テストの命名規則

- テストファイル名: `{対象ファイル名}_test.dart`
- テストの説明: 日本語で「何を」「どうする」を明確に記述

### テストの構造（AAA）

```dart
test('説明的なテスト名', () {
  // Arrange: テストの準備
  final input = createTestData();
  
  // Act: テスト対象の実行
  final result = targetFunction(input);
  
  // Assert: 結果の検証
  expect(result, expectedValue);
});
```

### モックの使用

```dart
// モックの生成
@GenerateMocks([LibraryService, AudioPlayerService])
void main() {
  // モックはbuild_runnerで自動生成される
}
```

### 非同期テストのパターン

```dart
test('非同期処理のテスト', () async {
  // async/awaitを使用
  final result = await asyncFunction();
  expect(result, isNotNull);
});

testWidgets('非同期UIのテスト', (tester) async {
  await tester.pumpWidget(MyWidget());
  
  // 非同期処理の完了を待つ
  await tester.pumpAndSettle();
  
  expect(find.text('Loaded'), findsOneWidget);
});
```

## テストカバレッジ

### カバレッジの測定

```bash
# カバレッジ付きでテスト実行
flutter test --coverage

# HTMLレポートの生成（要lcov）
genhtml coverage/lcov.info -o coverage/html

# レポートを開く
open coverage/html/index.html
```

### カバレッジ目標

- **全体**: 70%以上
- **モデル**: 90%以上
- **サービス**: 80%以上
- **プロバイダー**: 80%以上
- **ウィジェット**: 60%以上

## CI/CDでのテスト実行

### GitHub Actionsの設定例

```yaml
# .github/workflows/test.yml
name: Test

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter format --dry-run --set-exit-if-changed .
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
```

## テスト実装の優先順位

1. **第1フェーズ**: コアビジネスロジック
   - [ ] LibraryServiceのテスト
   - [ ] MetadataExtractorServiceのテスト
   - [ ] AudioPlayerServiceのテスト

2. **第2フェーズ**: データモデルとプロバイダー
   - [ ] Freezedモデルのテスト
   - [ ] 各プロバイダーのテスト

3. **第3フェーズ**: UI コンポーネント
   - [ ] カスタムウィジェットのテスト
   - [ ] 画面のテスト

4. **第4フェーズ**: 統合テスト
   - [ ] 楽曲インポートフロー
   - [ ] 再生フロー
   - [ ] アルバム/アーティスト表示フロー

## まとめ

TDDは最初は時間がかかるように見えますが、長期的には以下のメリットがあります：

- バグの早期発見
- リファクタリングの安全性
- ドキュメントとしてのテスト
- 設計の改善

「テストファースト」を心がけ、新機能の実装前には必ずテストから書き始めましょう。