# SRF仕様

このドキュメントではSRF（Sound Resource File）の仕様を定義します。
仕様は開発を通して継続的に更新されることを想定しています。

## SRFとは

`.srf`は音源ファイルのメタデータを管理するための新しいフォーマットです。
既存の音源データはバイナリの中にメタデータを埋め込む方法が一般的ですが、
`.srf`はメタデータをJSON形式で分離して管理することを目的としています。

### 基本構造

例えば、`foo.mp3`という音源ファイルがある場合、それを含む`foo.srf`というディレクトリを作ります。
このディレクトリを"SRFコンテナ"と呼びます。
SRFコンテナの中には音源ファイルと、メタデータの`meta.json`ファイルが配置されます。

```
library/
├── foo.srf/
│   ├── foo.mp3
│   └── meta.json
├── bar.srf/
│   ├── bar.mp3
│   ├── bar.wav
│   └── meta.json
└── baz.srf/
    ├── baz.mp3
    └── meta.json
```

### 利点

1. **メタデータの独立管理**: 音源ファイルを変更せずにメタデータを編集可能
2. **複数フォーマット対応**: 同じ楽曲の異なるフォーマット（mp3、wav等）を一つのコンテナで管理
3. **拡張性**: 将来的にアートワーク、歌詞、楽譜などの追加データも格納可能
4. **可読性**: JSONフォーマットで人間が読み書き可能

## メタデータ仕様

`meta.json`ファイルは、音源ファイルのメタデータをJSON形式で記述します。

### 基本フィールド

```json
{
  "title": "my song",
  "artist": "foo feat. bar",
  "duration": 309.60326530612247,
  "trackNumber": 3,
  "artists": ["foo", "bar"],
  "album": "My Album",
  "albumArtist": "foo",
  "year": 2024,
  "genre": "Electronic",
  "comment": "Additional notes",
  "dateAdded": "2024-01-31T12:00:00Z",
  "lastModified": "2024-01-31T12:00:00Z"
}
```

### フィールド定義

| フィールド | 型 | 必須 | 説明 |
|----------|---|-----|-----|
| title | string | ✓ | 楽曲タイトル |
| artist | string | ✓ | メインアーティスト名（表示用） |
| duration | number | ✓ | 再生時間（秒） |
| trackNumber | number | - | トラック番号 |
| artists | string[] | - | アーティスト名の配列 |
| album | string | - | アルバム名 |
| albumArtist | string | - | アルバムアーティスト |
| year | number | - | リリース年 |
| genre | string | - | ジャンル |
| comment | string | - | コメント |
| dateAdded | string | - | 追加日時（ISO 8601形式） |
| lastModified | string | - | 最終更新日時（ISO 8601形式） |

## アルバム仕様（未実装）

アルバムは`.srfa`（Sound Resource File Album）という拡張子を持つディレクトリで管理されます。

### アルバム構造

```
my_album.srfa/
├── meta.json      # アルバムメタデータ
├── cover.jpg      # アルバムアートワーク
├── foo.srf/       # 楽曲1
├── bar.srf/       # 楽曲2
└── baz.srf/       # 楽曲3
```

### アルバムメタデータ

```json
{
  "albumTitle": "My Album",
  "albumArtist": "foo",
  "year": 2024,
  "genre": "Electronic",
  "totalTracks": 10,
  "discNumber": 1,
  "totalDiscs": 1
}
```

## 実装状況

### 実装済み
- ✅ SRFコンテナの作成
- ✅ メタデータの読み書き
- ✅ MP3ファイルからのメタデータ自動抽出
- ✅ ライブラリディレクトリでのSRFコンテナ管理

### 未実装
- アルバム（.srfa）のサポート
- 複数音源フォーマットの管理
- アートワークの管理
- メタデータの手動編集機能

## 今後の拡張予定

1. **追加メタデータ**
   - BPM（テンポ）
   - キー（調）
   - 歌詞
   - タグ/ラベル

2. **高度な機能**
   - メタデータのバージョン管理
   - メタデータの圧縮
   - チェックサムによる整合性確認

3. **互換性**
   - 既存の音楽メタデータフォーマット（ID3等）との相互変換
   - エクスポート/インポート機能