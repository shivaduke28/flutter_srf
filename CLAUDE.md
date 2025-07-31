# Flutter SRF

Flutter SRFはFlutterでsrfを管理するためのアプリケーションです。

- srfについては `docs/srf.md` を参照してください。
- プロダクト要件は `docs/prd.md` を参照してください。

## 開発要件

- Flutter
- Riverpod + Hooks + Freezed


## 開発の流れ

- タスクが完了したら`dart analyze`を行いエラーがないか確認する
- エラーがない場合は`dart format` でコードを整形する
- freezedをつかう場合はclassに`sealed`をつける必要がある
