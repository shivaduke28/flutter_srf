import 'package:flutter/material.dart';
import '../providers/artists_provider.dart';
import './artist_detail_screen.dart';

class ArtistListItemView extends StatelessWidget {
  final ArtistInfo artist;

  const ArtistListItemView({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(artist.name),
      subtitle: Text('${artist.albumCount}枚のアルバム • ${artist.trackCount}曲'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtistDetailScreen(artist: artist),
          ),
        );
      },
    );
  }
}
