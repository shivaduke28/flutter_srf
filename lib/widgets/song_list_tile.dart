import 'package:flutter/material.dart';
import '../models/srf_container.dart';

class SongListTile extends StatelessWidget {
  final SrfContainer container;

  const SongListTile({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    final metadata = container.metadata;
    final duration = Duration(seconds: metadata.duration.toInt());
    final durationText =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.music_note)),
      title: Text(metadata.title, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${metadata.artist} ${metadata.album != null ? '• ${metadata.album}' : ''}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(durationText),
      onTap: () {
        // TODO: 再生機能の実装
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${metadata.title} を再生')));
      },
    );
  }
}
