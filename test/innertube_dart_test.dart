import 'package:innertube_dart/innertube_dart.dart';
import 'package:test/test.dart';

const testCookie =
    "YSC=G1kzae6sKZs; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; LOGIN_INFO=AFmmF2swRQIgV4tEUdOkpIx-2Cx2oDzczKXAnULdoBEDqqTTfOrQfaACIQDMMR6rUGMLxOKogaZ3fZTuiG0QMRQsO9zdtoe5q31flQ:QUQ3MjNmeUg3UDZmZUxEZU1PZHB3S3BqUGZOZkNCelJQaGh2ZGRfTHFPYU41czAwV0QzZHJsVHBaTXZUMmpIYnFKNnR5NkRNeG1mU0d1QnZiNVQ1NmdVaFNNTUxhSGo2X0hhSVV2Yk92dE44NldZemwxTDlEZkRQUE91Ml9IZVgwY0tRRE5uejduczB5cFVMRFpJRUdBVHRDNFl0UGVVRk1n; _gcl_au=1.1.976739750.1757334615; VISITOR_INFO1_LIVE=bdSpDSk0ses; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgVw%3D%3D; HSID=Ax-eno6m1GVFz020b; SSID=ApBq2XxuW5OTt2s2i; APISID=7wXeukWyAI3L4Gdu/Ar38BEB8JcKOdRbAE; SAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; __Secure-1PAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; __Secure-3PAPISID=Wi8ACq36QJZI9OnV/Ae-8FAEYZrmjOusJS; SID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOe_bRo2GKmrVN-n9W2a8BP4wACgYKAXQSARYSFQHGX2MifebMXD_6gclfj3LmGXp7pBoVAUF8yKqwcrnufLTExWkz26MgTf9Q0076; __Secure-1PSID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOezRK9MzG9WlgF-XZm4Wa2RgACgYKAZgSARYSFQHGX2Miw5KX5eGy-5bcMrSPRGDQXhoVAUF8yKpWXyoexrrqqYOKP_Ajdpfv0076; __Secure-3PSID=g.a0003whzsva5qwvD9r4FVZZBegU5e_eBOslAHEXu1WtoSNprLSOe29TJ2DnT0C5TbID8_RKKCAACgYKATsSARYSFQHGX2Mig8fAJaTu6UcMn_9embBLrBoVAUF8yKrETMvVuszxLgMfeGx5tkWH0076; PREF=tz=Asia.Tokyo&repeat=NONE&autoplay=true; __Secure-ROLLOUT_TOKEN=COGf8NzYz4D6DRCulr-61siPAxijkOjbqZ6RAw%3D%3D; __Secure-1PSIDTS=sidts-CjUBwQ9iIweWwyXR6LIx0x9zhWO7x58IKYAIUqWMrJ8anQJmc6WTg1uyxyv07viwU5I9rcs56hAA; __Secure-3PSIDTS=sidts-CjUBwQ9iIweWwyXR6LIx0x9zhWO7x58IKYAIUqWMrJ8anQJmc6WTg1uyxyv07viwU5I9rcs56hAA; SIDCC=AKEyXzXuc1_aoKvWVtSeWMBR-NemuYBQmsqx3ir5llN2gYh4vjFJBB4Uz9Jtdh173VS6ktf6BkE; __Secure-1PSIDCC=AKEyXzUTpTae1cxf9LsQzL7hWpseMAAwzahoEH0Udo9UeSI3Lcv9VP2uWiAeGKQflJJDjpUdX4k; __Secure-3PSIDCC=AKEyXzWyAwaCUkrIfB5_Qp5Uw07ZrZypr8j8wxah7gLEAWdwvaMta765qOQOAKfvC6W8OOy4Bms; ST-1b=";

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
      if (isDebug && result.isSuccess) {
        print(result.value.album.title);
        for (var song in result.value.songs) {
          print(song);
        }
      }
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
        cookie: testCookie,
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
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      // see console
      final result = await youtube.accountInfo(client: YouTubeClient.webRemix);
      if (isDebug && result.isSuccess) {
        print(result.value.accountName);
        print(result.value.accountHandle);
        print(result.value.accountPhoto?.thumbnails.first.url);
      }
      expect(result.isSuccess, isTrue);
    });
  });
}
