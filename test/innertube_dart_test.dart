import 'package:innertube_dart/innertube_dart.dart';
import 'package:test/test.dart';

void main() {
  group('Core Models', () {
    test('Artist can be created', () {
      final artist = Artist(name: 'Queen', id: 'UCRq...');

      expect(artist.name, equals('Queen'));
      expect(artist.id, equals('UCRq...'));
      expect(artist.toString(), equals('Queen'));
    });

    test('Album can be created', () {
      final album = Album(name: 'A Night at the Opera', id: 'MPREb...');

      expect(album.name, equals('A Night at the Opera'));
      expect(album.id, equals('MPREb...'));
    });

    test('SongItem extends YTItem', () {
      final song = SongItem(
        id: 'dQw4w9WgXcQ',
        title: 'Bohemian Rhapsody',
        artists: [Artist(name: 'Queen', id: 'UCRq...')],
        thumbnail: 'https://example.com/thumb.jpg',
        duration: 354,
      );

      expect(song.id, equals('dQw4w9WgXcQ'));
      expect(song.title, equals('Bohemian Rhapsody'));
      expect(song.artists.length, equals(1));
      expect(song.shareLink, contains('music.youtube.com/watch?v='));
    });

    test('AlbumItem has correct properties', () {
      final album = AlbumItem(
        browseId: 'MPREb...',
        playlistId: 'OLAK5uy...',
        title: 'A Night at the Opera',
        artists: [Artist(name: 'Queen', id: 'UCRq...')],
        year: "1975",
        thumbnail: 'https://example.com/thumb.jpg',
      );

      expect(album.browseId, equals('MPREb...'));
      expect(album.playlistId, equals('OLAK5uy...'));
      expect(album.year, equals('1975'));
      expect(album.shareLink, contains('playlist?list='));
    });
  });

  group('Utilities', () {
    test('parseTime converts time strings correctly', () {
      expect(parseTime('3:45'), equals(225)); // 3*60 + 45
      expect(parseTime('1:23:45'), equals(5025)); // 1*3600 + 23*60 + 45
      expect(parseTime('45'), equals(45));
      expect(parseTime('invalid'), isNull);
      expect(parseTime(null), isNull);
    });
  });

  group('Result', () {
    test('Result.success creates successful result', () {
      final result = Result.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isError, isFalse);
      expect(result.value, equals(42));
    });

    test('Result.error creates error result', () {
      final result = Result<int>.error(Exception('Test error'));

      expect(result.isError, isTrue);
      expect(result.isSuccess, isFalse);
      expect(result.error, isA<Exception>());
    });

    test('Result.when handles success and error cases', () {
      final successResult = Result.success(42);
      final errorResult = Result<int>.error(Exception('Test error'));

      final successValue = successResult.when(
        success: (value) => 'Success: $value',
        error: (error) => 'Error: $error',
      );
      expect(successValue, equals('Success: 42'));

      final errorValue = errorResult.when(
        success: (value) => 'Success: $value',
        error: (error) => 'Error: ${error.toString()}',
      );
      expect(errorValue, contains('Error:'));
    });
  });

  group('YouTube API Client', () {
    test('YouTube client can be created', () {
      final youtube = YouTube();

      expect(youtube.locale, equals(YouTubeLocale.defaultLocale));
    });

    test('YouTube client accepts custom locale', () {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );

      expect(youtube.locale.gl, equals('JP'));
      expect(youtube.locale.hl, equals('ja'));
    });

    // this is working
    test('Search Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      final result = await youtube.search('Reol', SearchFilter.all);
      expect(result.isSuccess, isTrue);
    });

    test('Alubum Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      final result = await youtube.album('MPREb_MVRIwFy1LUK');
      expect(result.isSuccess, isTrue);
    });

    test('Playlist Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      final result = await youtube.playlist(
        'VLRDCLAK5uy_lXFoH_0mBWcJWJu6ZR2bPAX_gKYP_wmPo',
      );
      expect(result.isSuccess, isTrue);
    });

    test('Artist Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      final result = await youtube.artist('UCC_OGcKdYY-aWFvVMFVGbzw');
      if (result.isSuccess) {
        for (var section in result.value.sections) {
          print(section.toString());
          print("===================================");
        }
      }
      expect(result.isSuccess, isTrue);
    });
  });
}
