import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math' as math;

import '../models/artist.dart';
import '../models/renderer/music_item_renderer.dart';
import '../models/runs.dart';

/// Parse cookie string into a map
Map<String, String> parseCookieString(String? cookie) {
  if (cookie == null || cookie.isEmpty) return {};

  final result = <String, String>{};
  final cookies = cookie.split(';');

  for (final cookiePair in cookies) {
    final trimmed = cookiePair.trim();
    if (trimmed.isEmpty) continue;

    final separatorIndex = trimmed.indexOf('=');
    if (separatorIndex == -1) continue;

    final key = trimmed.substring(0, separatorIndex).trim();
    final value = trimmed.substring(separatorIndex + 1).trim();

    if (key.isNotEmpty) {
      result[key] = value;
    }
  }

  return result;
}

/// Generate SHA-1 hash string
String sha1Hash(String input) {
  final bytes = utf8.encode(input);
  final digest = sha1.convert(bytes);
  return digest.toString();
}

String generateRandomString(int length) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
  final rand = math.Random.secure();

  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}

List<Artist> parseArtistRuns(List<Run>? runs) {
  final artists = <Artist>[];
  if (runs == null) return artists;
  for (final run in runs) {
    if (run.navigationEndpoint?.browseEndpoint?.browseId != null) {
      final id = run.navigationEndpoint!.browseEndpoint!.browseId!;
      if (id.startsWith('UC')) {
        artists.add(Artist(name: run.text, id: id));
      }
    }
  }
  return artists;
}

bool isExplicit(List<Badge>? badges) {
  return badges?.any(
        (badge) =>
            badge.musicInlineBadgeRenderer?.icon?.iconType ==
            'MUSIC_EXPLICIT_BADGE',
      ) ??
      false;
}

bool checkIsVideo(String? aspectRatio) {
  return aspectRatio ==
      'MUSIC_TWO_ROW_ITEM_THUMBNAIL_ASPECT_RATIO_RECTANGLE_16_9';
}
