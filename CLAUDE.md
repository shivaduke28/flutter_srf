# Flutter SRF

Flutter SRFはFlutterでsrfを管理するためのアプリケーションです。

- srfについては `docs/srf.md` を参照してください。
- プロダクト要件は `docs/prd.md` を参照してください。

## 開発要件

- Flutter 3.x
- Riverpod + Hooks + Freezed
- macOS 10.15以上（開発・実行環境）

## プロジェクト構造

```
lib/
├── application/     # アプリケーション層（状態管理・ビジネスロジック）
│   ├── albums/      # アルバム関連の状態管理
│   │   ├── album_notifier.dart
│   │   ├── album_query_controller.dart
│   │   └── queried_albums_provider.dart
│   ├── artists/     # アーティスト関連の状態管理
│   │   ├── artist_notifier.dart
│   │   ├── artist_query_controller.dart
│   │   └── queried_artists_provider.dart
│   ├── import/      # インポート機能
│   │   └── import_controller.dart
│   ├── library/     # ライブラリ全体の管理
│   │   └── library_provider.dart
│   ├── player/      # 音楽再生制御
│   │   ├── audio_player_notifier.dart
│   │   └── audio_player_state.dart
│   └── tracks/      # 楽曲関連の状態管理
│       ├── track.dart              # ドメインモデル
│       ├── track_repository.dart   # リポジトリ層
│       ├── tracks_notifier.dart    # 状態管理
│       ├── track_query_controller.dart
│       └── queried_tracks_provider.dart
├── system/          # システム層（外部サービス・低レベル実装）
│   ├── audio/       # 音楽再生の低レベル実装
│   │   └── audio_player_service.dart
│   ├── importer/    # ファイルインポート処理
│   │   └── track_importer.dart
│   └── library/     # ライブラリ管理の低レベル実装
│       ├── library_service.dart    # 1300行超のGod Class（要リファクタリング）
│       └── srf_track.dart          # SRFコンテナ用モデル（要統合）
├── ui/              # プレゼンテーション層
│   ├── album_list/  # アルバム関連画面
│   │   ├── albums_screen.dart
│   │   ├── album_detail_screen.dart
│   │   ├── album_list_view.dart
│   │   └── album_list_item_view.dart
│   ├── artist_list/ # アーティスト関連画面
│   │   ├── artists_screen.dart
│   │   ├── artist_detail_screen.dart
│   │   ├── artist_list_view.dart
│   │   └── artist_list_item_view.dart
│   ├── components/  # 共通UIコンポーネント
│   │   ├── async_value_widget.dart
│   │   ├── error_view.dart
│   │   ├── home_screen.dart
│   │   └── sort_popup_menu_button.dart
│   ├── player/      # プレイヤーUI
│   │   └── audio_player_view.dart
│   ├── settings/    # 設定画面
│   │   ├── settings_screen.dart
│   │   └── import_dialog.dart
│   └── track_list/  # 楽曲関連画面
│       ├── tracks_screen.dart
│       ├── track_list_view.dart
│       └── track_list_item_view.dart
├── errors/          # エラー定義
│   └── app_error.dart
└── main.dart        # エントリーポイント
```

### アーキテクチャの特徴

- **3層アーキテクチャ**：
  - **UI層**：画面とコンポーネント
  - **Application層**：状態管理とビジネスロジック
  - **System層**：外部サービスとの連携、低レベル実装
- **単方向依存**：UI → Application → System の依存方向を維持
- **Riverpod Generator**：プロバイダーの自動生成（`@riverpod`アノテーション使用）

## 主要な依存パッケージ

- **flutter_riverpod**: 状態管理
- **hooks_riverpod**: Flutter Hooksとの統合
- **freezed**: イミュータブルなデータクラス生成
- **audio_metadata_reader**: MP3等のメタデータ抽出
- **path_provider**: ファイルシステムアクセス
- **url_launcher**: システムファイルエクスプローラー連携
- **file_picker**: ファイル・ディレクトリ選択UI
- **just_audio**: 音楽再生機能（audioplayers より音楽アプリ向け）

## 開発の流れ

### 基本的な開発フロー

1. タスクが完了したら`make analyze`を行いエラーがないか確認する
2. エラーがない場合は`make format`でコードを整形する（生成ファイルを自動除外）
3. freezedをつかう場合はclassに`sealed`をつける必要がある
4. コード生成が必要な場合は`make build`を実行

### Makefileコマンド（推奨）

プロジェクトにはMakefileが用意されており、以下のコマンドが使用できます：

```bash
# 🎨 コードフォーマット（生成ファイルを自動除外）
make format

# 🔍 静的解析
make analyze

# 🏗️ コード生成（Freezed, Riverpod Generator）
make build

# 👀 watchモードでコード生成（開発時に便利）
make watch

# 🧪 テスト実行
make test

# 🚀 アプリ実行（macOS）
make run
```

### 直接実行する場合のコマンド（非推奨）

**注意**: `make format`と`dart format`は挙動が異なります。
- `make format`: 生成ファイル（*.g.dart, *.freezed.dart, *.mocks.dart）を**除外**してフォーマット
- `dart format`: すべてのDartファイルをフォーマット（生成ファイルも含む）

どうしてもMakefileを使えない場合のみ：

```bash
# 依存関係の更新
flutter pub get

# watchモードでコード生成（Makefileが使えない場合）
dart run build_runner watch --delete-conflicting-outputs
```

## 重要な実装詳細

### ライブラリパス
- デフォルト: `~/Library/Application Support/flutter_srf/library`
- macOSのサンドボックス環境に対応するため、アプリケーションサポートディレクトリを使用
- 現在は固定パス（将来的にカスタマイズ可能にする予定）

### プロバイダーの注意点
- **Riverpod Generator使用**：`@riverpod`アノテーションで自動生成
- **keepAlive設定**：永続化が必要なプロバイダーは`@Riverpod(keepAlive: true)`を使用
  - 例：`libraryManagerProvider`、`audioPlayerServiceProvider`
- **状態監視の重要ポイント**：
  - UIでは必ず`ref.watch(xxxProvider)`でstateを監視する（再ビルドのトリガー）
  - `ref.watch(xxxProvider.notifier)`は状態変更を検知しない
  - アクションの実行時のみ`ref.read(xxxProvider.notifier)`を使用
- **プロバイダー構造**：
  - **Application層**：状態管理とビジネスロジック
    - `TracksNotifier`：楽曲一覧の状態管理
    - `AlbumNotifier`：アルバム一覧の状態管理
    - `ArtistNotifier`：アーティスト一覧の状態管理
    - `TrackQueryController`/`AlbumQueryController`/`ArtistQueryController`：検索・フィルタリング
    - `AudioPlayerNotifier`：再生状態の管理
  - **System層**：低レベル実装
    - `LibraryService`：ライブラリ管理（要リファクタリング）
    - `AudioPlayerService`：音楽再生の低レベル制御
    - `TrackImporter`：ファイルインポート処理

### メタデータ抽出
- `audio_metadata_reader`パッケージを使用してMP3からメタデータを自動抽出
- 抽出できない場合はデフォルト値を使用
- 現在サポートされているのはMP3のみ（`.mp3`）

### macOS固有の設定
- `macos/Runner/DebugProfile.entitlements`と`Release.entitlements`でファイルアクセス権限を設定
- `com.apple.security.files.user-selected.read-write`が必要

### 音楽再生機能
- **パッケージ**：`just_audio`（音楽アプリに最適化）
- **アーキテクチャ**：
  - `AudioPlayerService`（`system/audio/`）：低レベル再生制御
  - `AudioPlayerNotifier`（`application/player/`）：再生状態の管理
  - `AudioPlayerState`：再生状態（再生中トラック、再生位置、音量など）
  - `AudioPlayerView`（`ui/player/`）：プレイヤーUI
- **機能**：
  - 再生/一時停止/停止
  - 音量調整（0.0〜1.0、スライダー操作）
  - シークバー（再生位置の表示と操作）
  - 再生中トラックのハイライト表示

### アルバム・アーティスト機能
- **アルバム機能**：
  - `AlbumNotifier`（`application/albums/`）：アルバムの状態管理
  - `AlbumQueryController`：検索・フィルタリング
  - グリッド表示（`ui/album_list/albums_screen.dart`）
  - アルバム詳細画面（`ui/album_list/album_detail_screen.dart`）
- **アーティスト機能**：
  - `ArtistNotifier`（`application/artists/`）：アーティストの状態管理
  - `ArtistQueryController`：検索・フィルタリング
  - リスト表示（`ui/artist_list/artists_screen.dart`）
  - アーティスト詳細画面（`ui/artist_list/artist_detail_screen.dart`）
- **共通機能**：
  - 検索機能（リアルタイムフィルタリング）
  - ソート機能（名前順、楽曲数順、アルバム数順）
  - 各詳細画面からの楽曲再生

## トラブルシューティング

### 楽曲が表示されない場合
1. **プロバイダーの監視確認**：
   - `ref.watch(tracksNotifierProvider)`でstateを監視しているか
   - `notifier`ではなくstateを監視しているか確認
2. **ライブラリのスキャン**：
   - 「ライブラリを再スキャン」ボタンを実行
   - コンソールログで`scanLibrary`の実行を確認
3. **ファイルパス確認**：
   - ライブラリディレクトリ：`~/Library/Application Support/flutter_srf/library`
   - SRFコンテナファイル（`.srf`）が存在するか確認
4. **権限確認**：
   - macOSのファイルアクセス権限が有効か確認

### ビルドエラーが発生した場合
1. `flutter clean` を実行
2. `flutter pub get` を実行
3. `dart run build_runner build --delete-conflicting-outputs` を実行
4. macOSの場合は `cd macos && pod install` を実行

### インポートできない場合
1. 選択したディレクトリへの読み取り権限があるか確認
2. MP3ファイルが存在するか確認
3. ライブラリディレクトリへの書き込み権限があるか確認

## 次の開発タスク

### 最優先（アーキテクチャ改善）
- [ ] **LibraryServiceのリファクタリング**（1300行超のGod Class）
  - [ ] ScanningService（スキャン機能）に分割
  - [ ] MetadataService（メタデータ処理）に分割
  - [ ] PersistenceService（永続化）に分割
- [ ] **モデル統合**：`Track`と`SrfTrack`の重複を解消
- [ ] **プロバイダー命名規則の統一**：Controller/Service/Notifier/Providerの使い分けルール確立

### 高優先度（機能実装）
- [x] アーティスト一覧画面の実装
- [x] アルバム一覧画面の実装
- [x] 楽曲インポート機能の実装
- [x] ライブラリ再スキャン機能の実装
- [ ] ライブラリデータの永続化（SQLite/Hive）

### 中優先度
- [x] 楽曲再生機能の実装
- [x] 音量調整機能の実装
- [x] 楽曲・アルバム・アーティスト検索機能
- [x] ソート機能（各画面）
- [ ] メタデータ編集機能
- [ ] アルバムアートワークの表示
- [ ] 音量設定の永続化（SharedPreferences）
- [ ] 再生履歴
- [ ] テストカバレッジの向上

### 低優先度
- [ ] プレイリスト機能
- [ ] エクスポート機能
- [ ] 設定の永続化

## コード規約

- Dartの標準的な命名規則に従う
- ファイル名は`snake_case`
- クラス名は`PascalCase`
- 変数・関数名は`camelCase`
- プライベートメンバーは`_`プレフィックス
- コメントは必要最小限に（コードで意図を表現）
- エラーハンドリングは適切に行う（try-catch、AsyncValue.guard）