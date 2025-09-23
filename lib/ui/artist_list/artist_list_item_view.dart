import 'package:flutter/material.dart';
import 'package:flutter_srf/application/artists/artist.dart';
import 'package:flutter_srf/ui/artist_list/artist_detail_screen.dart';

class ArtistListItemView extends StatelessWidget {
  final Artist artist;

  const ArtistListItemView({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(artist.name),
      subtitle: Text('${artist.albumIds.length}枚のアルバム • ${artist.trackIds.length}曲'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(context, MaterialPageRoute<void>(builder: (context) => ArtistDetailScreen(artist: artist)));
      },
    );
  }
}
