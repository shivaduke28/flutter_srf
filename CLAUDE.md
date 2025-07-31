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
├── models/          # データモデル（Freezed）
├── providers/       # Riverpodプロバイダー
├── screens/         # 画面UI
├── widgets/         # 再利用可能なウィジェット
├── services/        # ビジネスロジック・外部連携
└── main.dart        # エントリーポイント
```

## 主要な依存パッケージ

- **flutter_riverpod**: 状態管理
- **hooks_riverpod**: Flutter Hooksとの統合
- **freezed**: イミュータブルなデータクラス生成
- **flutter_media_metadata**: MP3等のメタデータ抽出
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
- `LibraryService`は`@Riverpod(keepAlive: true)`で永続化
- `SrfContainersProvider`は`libraryServiceProvider.future`を待ってから初期化
- 非同期プロバイダーを使用する際は、初期化完了を適切に待つ必要がある
- **Riverpod Generatorを使用**：StateNotifierProviderは非推奨なので`@Riverpod`アノテーションを使う
- **Riverpod 3.0対応**：`XxxRef`型は廃止され、すべて`Ref`型を使用するように変更

### メタデータ抽出
- `flutter_media_metadata`パッケージを使用してMP3からメタデータを自動抽出
- 抽出できない場合はデフォルト値を使用
- 現在サポートされているのはMP3のみ（`.mp3`）

### macOS固有の設定
- `macos/Runner/DebugProfile.entitlements`と`Release.entitlements`でファイルアクセス権限を設定
- `com.apple.security.files.user-selected.read-write`が必要

### 音楽再生機能
- `just_audio`パッケージを使用（音楽アプリに適している）
- `AudioPlayerService`で再生制御を管理
- `PlayerState`プロバイダーで再生状態を管理（Riverpod Generator使用）
- 再生中の楽曲はハイライト表示される
- 音量調整機能実装済み（0.0〜1.0の範囲でスライダーで調整可能）

### アルバム・アーティスト機能
- `AlbumsProvider`でアルバム単位のグルーピングと情報を管理
- `ArtistsProvider`でアーティスト単位のグルーピングと情報を管理
- アルバム一覧画面：グリッド表示でアルバムを視覚的に表示
- アーティスト一覧画面：リスト表示でアーティストと楽曲数・アルバム数を表示
- 各詳細画面から楽曲の再生が可能

## トラブルシューティング

### 楽曲が表示されない場合
1. コンソールログを確認（`scanLibrary called`等のデバッグ出力）
2. ライブラリディレクトリが存在するか確認
3. SRFコンテナが正しく作成されているか確認
4. プロバイダーの初期化順序を確認

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
   - [ ] ライブラリデータの永続化（SQLite/Hive）

2. **中優先度**
   - [x] 楽曲再生機能の実装
   - [x] 音量調整機能の実装
   - [ ] メタデータ編集機能
   - [ ] アルバムアートワークの表示
   - [ ] 音量設定の永続化（SharedPreferences）

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