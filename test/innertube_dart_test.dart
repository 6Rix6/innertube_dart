import 'package:innertube_dart/innertube_dart.dart';
import 'package:test/test.dart';

const testCookie =
    "YSC=fYpa1t-hHyM; VISITOR_INFO1_LIVE=IX9F3e5sllE; VISITOR_PRIVACY_METADATA=CgJKUBIEGgAgTg%3D%3D; _gcl_au=1.1.388645542.1764399384; __Secure-ROLLOUT_TOKEN=CNqG_IPG49Lv8wEQ7eTG8-OWkQMY6PvC9OOWkQM%3D; PREF=repeat=NONE; CONSISTENCY=AKreu9v9qfGi_GB2KuyGnpxOT23QcYcO2eke7hR7PwFAiE7n04K1H60Q1hH7OqOJJCklei09h0oYMl9cFz2J3hb7cRTs0XSsmXDC_wrzf736ALLfeA7oJh6aFLc-LzIQdg1uWDE78y7l5ay6dwU2DnU; __Secure-1PSIDTS=sidts-CjUBwQ9iI3XTUX6i5yx1pjGVDi6qoPC3EbMVd7WNBDs4F7i-spFLzmH4Gp5pJmGoChkoq_UQ0RAA; __Secure-3PSIDTS=sidts-CjUBwQ9iI3XTUX6i5yx1pjGVDi6qoPC3EbMVd7WNBDs4F7i-spFLzmH4Gp5pJmGoChkoq_UQ0RAA; HSID=AL7O48iPZAiM52uT4; SSID=AeOefivefAj81GdAc; APISID=kNcJkG870XaLwCT_/A8i_OpVThhewGFXaX; SAPISID=odriVyvt3p8Vu9vq/AtYMRT0GuzD4e9L5L; __Secure-1PAPISID=odriVyvt3p8Vu9vq/AtYMRT0GuzD4e9L5L; __Secure-3PAPISID=odriVyvt3p8Vu9vq/AtYMRT0GuzD4e9L5L; SID=g.a0004AiWBsMVc4618HGc4-0Azi8nJFEA-H_vpVVooli0KJ4vmm8rynskaZXDeNEjAJDdPZXpwAACgYKAbASARISFQHGX2MidtL_WqqgPs4QE8g7eodbrhoVAUF8yKr8oVvy6_wD_-0_CWlhklqz0076; __Secure-1PSID=g.a0004AiWBsMVc4618HGc4-0Azi8nJFEA-H_vpVVooli0KJ4vmm8rUOus9ifkG2VbjY4Ow7tKogACgYKASQSARISFQHGX2MiyTvUw3W1JasjLo3pt7DmohoVAUF8yKoeinVfTyClTlmNXHqlgy3w0076; __Secure-3PSID=g.a0004AiWBsMVc4618HGc4-0Azi8nJFEA-H_vpVVooli0KJ4vmm8rEJnj6sbWmHnMS0tEuED4_QACgYKASsSARISFQHGX2Mi5yEyQ4tXvU8rT0gtSUtayxoVAUF8yKo32x_vuBD45bxo2e_16uKf0076; LOGIN_INFO=AFmmF2swRQIhALKB2ylaXDL5h1A_qiuNkYNj6qazs-wbSnPhWdB1FIMdAiAvBCHeKf0zsv6JIydjKNsWkYgDrS48axz0O_8LBOIpOg:QUQ3MjNmeWpnRXJrVFZ4dk1oakRER2I4ZHduWS1WT1VfRmJnN3VFaktsZHZVeVpRNFNoUjVFQ0l6Zm43TkxzT0dRWDhoLTlLTkJ4dTgzSHN4YjBsNjZ5RUhEaEplYlZSVzFEOTQ0M0ViSm5sVTVNN01sMXNMNlFnTmdzZ3lRMjJZYTZYQThBMENqXzdubGdJelFZb2FSX0hfRWdKalktaFR3; SIDCC=AKEyXzXfsJrtWSjUMDetD1RTrPQRY-F1o_7pwNRiu_MBJwK4-mm2rQzrb6NVjW1uV46oszkH5g; __Secure-1PSIDCC=AKEyXzVCKOITk2BOnyaloGiIULP7U7QVebczWpKdsCZWca2A1gWPUf3CaD1fIdUTOLMlGXzghQ; __Secure-3PSIDCC=AKEyXzW4v9KhKrcE32uvGfu5pjBa5z5qI_Kt_ziO44VPk6SP4MogohkkTBbgSgFXYOhrUSlD; ST-1b=";
const testVisitorData = "CgtiZFNwRFNrMHNlcyih2K_JBjIKCgJKUBIEGgAgVw%3D%3D";
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
        // cookie: testCookie,
        // visitorData: testVisitorData,
        locale: YouTubeLocale(gl: 'JP', hl: 'ja'),
      );
      await youtube.initialize();
      final result = await youtube.home();
      if (isDebug && result.isSuccess) {
        for (var section in result.value.sections) {
          print(section);
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
  });
}
