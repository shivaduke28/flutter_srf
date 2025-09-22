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
├── features/        # 機能別モジュール
│   ├── albums/      # アルバム機能
│   │   ├── models/  # アルバムデータモデル
│   │   ├── providers/ # アルバムプロバイダー
│   │   └── ui/      # アルバムUI
│   ├── artists/     # アーティスト機能
│   │   ├── providers/ # アーティストプロバイダー
│   │   └── ui/      # アーティストUI
│   ├── library/     # ライブラリ管理機能
│   │   ├── models/  # ライブラリデータモデル
│   │   └── providers/ # ライブラリプロバイダー
│   ├── player/      # 音楽再生機能
│   │   ├── providers/ # プレイヤープロバイダー
│   │   └── ui/      # プレイヤーUI
│   ├── settings/    # 設定機能
│   │   └── ui/      # 設定UI
│   └── tracks/      # 楽曲機能
│       ├── models/  # 楽曲データモデル
│       ├── providers/ # 楽曲プロバイダー
│       └── ui/      # 楽曲UI
├── shared/          # 共有コンポーネント
│   ├── ui/          # 共通UI
│   └── utils/       # ユーティリティ
└── main.dart        # エントリーポイント
```

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

1. タスクが完了したら`dart analyze`を行いエラーがないか確認する
2. エラーがない場合は`dart format` でコードを整形する
3. freezedをつかう場合はclassに`sealed`をつける必要がある
4. コード生成が必要な場合は `dart run build_runner build --delete-conflicting-outputs` を実行

### よく使うコマンド

```bash
# アプリの実行（macOS）
flutter run -d macos

# コード生成（Freezed, Riverpod Generator）
dart run build_runner build --delete-conflicting-outputs

# コード解析
dart analyze

# コード整形
dart format lib/

# テスト実行
flutter test

# 依存関係の更新
flutter pub get
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
- **フィーチャー構造**：各機能モジュール（features/）内でプロバイダーを管理
  - `TracksController`：楽曲一覧の状態管理
  - `LibraryManager`：ライブラリ全体の管理
  - `AudioPlayerService`：音楽再生制御

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
  - `AudioPlayerService`（`features/player/providers/`）：再生制御
  - `AudioPlayerState`：再生状態の管理（再生中トラック、再生位置、音量など）
  - `PlayerControlsView`（`features/player/ui/`）：プレイヤーUI
- **機能**：
  - 再生/一時停止/停止
  - 音量調整（0.0〜1.0、スライダー操作）
  - シークバー（再生位置の表示と操作）
  - 再生中トラックのハイライト表示

### アルバム・アーティスト機能
- **アルバム機能**（`features/albums/`）：
  - `AlbumsController`：アルバムの状態管理とフィルタリング
  - グリッド表示（`AlbumsScreen`）
  - アルバム詳細画面（`AlbumDetailScreen`）
- **アーティスト機能**（`features/artists/`）：
  - `ArtistsController`：アーティストの状態管理
  - リスト表示（`ArtistsScreen`）
  - アーティスト詳細画面（`ArtistDetailScreen`）
- **共通機能**：
  - 検索機能（リアルタイムフィルタリング）
  - ソート機能（名前順、楽曲数順、アルバム数順）
  - 各詳細画面からの楽曲再生

## トラブルシューティング

### 楽曲が表示されない場合
1. **プロバイダーの監視確認**：
   - `ref.watch(tracksControllerProvider)`でstateを監視しているか
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

現在の実装状況と優先度：

1. **高優先度**
   - [x] アーティスト一覧画面の実装
   - [x] アルバム一覧画面の実装
   - [x] 楽曲インポート機能の実装
   - [x] ライブラリ再スキャン機能の実装
   - [ ] ライブラリデータの永続化（SQLite/Hive）

2. **中優先度**
   - [x] 楽曲再生機能の実装
   - [x] 音量調整機能の実装
   - [x] 楽曲・アルバム・アーティスト検索機能
   - [x] ソート機能（各画面）
   - [ ] メタデータ編集機能
   - [ ] アルバムアートワークの表示
   - [ ] 音量設定の永続化（SharedPreferences）
   - [ ] 再生履歴

3. **低優先度**
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