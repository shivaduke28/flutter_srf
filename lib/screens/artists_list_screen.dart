import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArtistsListScreen extends HookConsumerWidget {
  const ArtistsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('アーティスト一覧（準備中）'));
  }
}
