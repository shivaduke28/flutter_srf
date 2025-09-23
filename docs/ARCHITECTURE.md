# ARCHITECTURE.md

３層にする

```agsl
lib
|- ui
|- application
|- system
```

## UI

画面構成などに応じてディレクトリを作る
```
ui
|- track_list
|- album_list
|- settings
|- components
```

- UI層のクラスの名前は基本的に`XxxView`とする。
- ConsumerWidgetまたはHookConsumerWidgetを継承する。
- Viewはapplication層の複数のproviderをwatch、readしてよい

## Application

```
application
|- tracks
|  |- track.dart
|  |- track_repository.dart
|  |- queried_tracks_provider.dart
|  |- foo_notifier.dart
|- albums
|- audio_players
```

- featureごとにディレクトリを切る
- UI層とディレクトリが1:1である必要はない（画面ごとではなくドメインごと）
- アプリケーションの状態をSSoTとして保持する（NotifierおよびProviderを使う）
  - providerで十分ならproviderにする、足りない場合はnotifierにする
  - riverpodのコード生成を行う
- track.dartなどのモデルはfreezedを使う
- アプリケーション外への永続化を行う場合はRepositoryを作る
- Repositoryはstatelessにする
- Repositoryは必要に応じてsystem内のserviceとやりとりする
- 例えばAPIレスポンスをapplication層のモデルに変換するのはrepositoryの役割
- Repositoryに対してproviderを作成してよいが、uiからの使用は禁止する(notifier, providerから見る)
- この層に対してテストを書くことができることが望ましい

## System

```
system
|- bar
  |- bar_service.dart
```

- featureごとにディレクトリを切る (ui, applicationと1:1:1でなくてよい)
- いわゆるinfrastructureで、外部サービス（e.g. db, file i/oなど）とのやりとりをする
- この層もstatelessにする
- firebase, firestoreなどを使う場合もここにする
- テストは外部サービスに依存する場合は書くのが難しくなる
- 自前のロジックをもつだけのserviceならテストを書く