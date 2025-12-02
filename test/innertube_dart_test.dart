import 'package:innertube_dart/innertube_dart.dart';
import 'package:test/test.dart';

const testCookie =
    "YSC=G1kzae6sKZs; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; _gcl_au=1.1.976739750.1757334615; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; PREF=tz=Asia.Tokyo&repeat=NONE&autoplay=true; __Secure-ROLLOUT_TOKEN=COGf8NzYz4D6DRCulr-61siPAxijkOjbqZ6RAw%3D%3D; __Secure-1PSIDTS=sidts-CjUBwQ9iI8SlRW7H6uTLeBYRtjU6N0Uef9HyCeB5S1ug1ZZ08MFqVnGn6yLzWMUn16lWpL5qDxAA; __Secure-3PSIDTS=sidts-CjUBwQ9iI8SlRW7H6uTLeBYRtjU6N0Uef9HyCeB5S1ug1ZZ08MFqVnGn6yLzWMUn16lWpL5qDxAA; HSID=AKOmeAZX5F_QQNqdb; SSID=AV0H5wbxllIJ87B-D; APISID=hYwgnby29OkaMzWf/ASeh8FQBMq5h_ibi5; SAPISID=wTsRXLE8kFvEnM22/AuXH3pBzwAhvD5EZR; __Secure-1PAPISID=wTsRXLE8kFvEnM22/AuXH3pBzwAhvD5EZR; __Secure-3PAPISID=wTsRXLE8kFvEnM22/AuXH3pBzwAhvD5EZR; SID=g.a0004AhzshEG8gt4qyiWoZgNQCtYjMMBBY6BgrjMZ2ps32OXfujfvvNUixbdLYtC6_kVZJ84CgACgYKAdcSARYSFQHGX2MiD1lcE1tdVuveWaLoOxzmMxoVAUF8yKrYE_GpCH3b-2RqCc3zFYWf0076; __Secure-1PSID=g.a0004AhzshEG8gt4qyiWoZgNQCtYjMMBBY6BgrjMZ2ps32OXfujfeeNS1BcwRw-5rk2fYnk8lgACgYKAUgSARYSFQHGX2MiUTajfpe1ixFVVagb5Fi2ghoVAUF8yKrh7uEey3SVVR7AB2IzuI0z0076; __Secure-3PSID=g.a0004AhzshEG8gt4qyiWoZgNQCtYjMMBBY6BgrjMZ2ps32OXfujfOknm4uXkTp_dn3ldMccj1wACgYKAUMSARYSFQHGX2Mi0SLOkLOmb9fad7WOD37waBoVAUF8yKpdWKrsyBXeT4YY08K5ejBW0076; LOGIN_INFO=AFmmF2swRQIgJ3d437FbvYla8GC7tWUKH_6nzYDc2bxMYvxlu3nqzH0CIQCFXU6jReJYN6TFGJIQqEuRNVTJyvA_0OHHnGYoUAgZLw:QUQ3MjNmejZDbnhKVWgyZWtHcXJTcXNXT1gwU0k4cXRoQnZvMkFQM01DSFRqc3lvWl9rUlNPcFphclNJS0VIM05NTklRMU5pMUNLS2lfUmlBYlpQZ00tMGR0czFRV2dxWm15QnRsSVBVZVB5amwzRWJLXzU3UDRZR0dnNU9YTDhjc2NhTElMMWg5NEltTTZXNnRVa1FUUFo3LV9Ebk54bHZR; SIDCC=AKEyXzUQlT3d8DccvTNpymjy_DhB0mg4ChVMdTImTEzb7GEKCIeKfNVn2u2-XXnze9Ormfxjr7I; __Secure-1PSIDCC=AKEyXzVS6vrFoFzva_kGmUNCt8dd-opmkCH2rdT_eqWyM3QSyPIL8eEINqit67kym8Eg0fj_D5Y; __Secure-3PSIDCC=AKEyXzVagc72y8dkyAjldgEfXCOhSFtD0Mr1Sup0Swpno12EGc6aiqF5NYsA2n5CWAjl8WZ-sJo";
const testVisitorData = "CgtiZFNwRFNrMHNlcyi0w7rJBjIKCgJKUBIEGgAgVw%3D%3D";
const testDataSyncId = "114921521729099886596||";
const isDebug = true;

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
    test('YouTube client can be created', () async {
      final youtube = YouTube();
      await youtube.initialize();
      expect(youtube.locale, equals(YouTubeLocale.defaultLocale));
    });

    test('YouTube client accepts custom locale', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      expect(youtube.locale.gl, equals('JP'));
      expect(youtube.locale.hl, equals('ja'));
    });

    // this is working
    test('Search Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.search('Reol', SearchFilter.all);
      expect(result.isSuccess, isTrue);
    });

    test('Alubum Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.album('MPREb_MVRIwFy1LUK');
      expect(result.isSuccess, isTrue);
    });

    test('Playlist Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.playlist(
        'VLRDCLAK5uy_lXFoH_0mBWcJWJu6ZR2bPAX_gKYP_wmPo',
      );
      expect(result.isSuccess, isTrue);
    });

    test('Artist Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.artist('UCC_OGcKdYY-aWFvVMFVGbzw');
      if (isDebug && result.isSuccess) {
        print(result.value.name);
        for (var section in result.value.sections) {
          print(section);
        }
      }
      expect(result.isSuccess, isTrue);
    });

    test('Home Feed Api is working', () async {
      final youtube = YouTube(
        cookie: testCookie,
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.home();
      if (isDebug && result.isSuccess) {
        for (var section in result.value.sections) {
          print(section);
          if (section.items != null) {
            for (var item in section.items!) {
              print(item);
            }
          }
        }
      }
      expect(result.isSuccess, isTrue);
    });

    test('Home Feed Continuation Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.home();
      final continuation = result.value.continuations?.first;
      final result2 = await youtube.home(continuation: continuation);

      if (isDebug && result2.isSuccess) {
        for (var section in result.value.sections) {
          print(section);
        }
        for (var section in result2.value.sections) {
          print(section);
        }
      }
      expect(result2.isSuccess, isTrue);
    });

    test('Player Api is working', () async {
      final youtube = YouTube(
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.player(
        'dQw4w9WgXcQ',
        client: YouTubeClient.android,
      );
      if (isDebug && result.isSuccess) {
        print(result.value.playabilityStatus.status);
        print(result.value.videoDetails?.title);
        print(result.value.videoDetails?.author);
        print(result.value.streamingData?.adaptiveFormats);
        print(result.value.streamingData?.serverAbrStreamingUrl);
      }
      expect(result.isSuccess, isTrue);
    });

    test('Account Info Api is working', () async {
      final youtube = YouTube(
        cookie: testCookie,
        // visitorData: testVisitorData,
        // dataSyncId: testDataSyncId,
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      // see console
      await youtube.accountInfo(client: YouTubeClient.webRemix);
      expect(true, isTrue);
    });
  });
}
