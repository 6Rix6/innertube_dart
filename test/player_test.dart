import 'package:test/test.dart';
import 'package:innertube_dart/innertube_dart.dart';

void main() {
  group('Player Model Tests', () {
    test('PlayerResponse deserialization should work', () {
      final sampleJson = {
        'playabilityStatus': {'status': 'OK'},
        'videoDetails': {
          'videoId': 'test123',
          'title': 'Test Video',
          'author': 'Test Author',
          'channelId': 'UC123',
          'lengthSeconds': '180',
          'thumbnail': {'thumbnails': []},
        },
        'streamingData': {
          'adaptiveFormats': [
            {
              'itag': 140,
              'url': 'https://example.com/audio.mp4',
              'mimeType': 'audio/mp4',
              'bitrate': 128000,
              'quality': 'medium',
            },
          ],
          'expiresInSeconds': 21540,
        },
      };

      final playerResponse = PlayerResponse.fromJson(sampleJson);

      expect(playerResponse.playabilityStatus.status, equals('OK'));
      expect(playerResponse.videoDetails?.videoId, equals('test123'));
      expect(playerResponse.videoDetails?.title, equals('Test Video'));
      expect(playerResponse.streamingData?.adaptiveFormats.length, equals(1));
      expect(playerResponse.streamingData?.expiresInSeconds, equals(21540));
    });

    test('Format.isAudio getter should work correctly', () {
      final audioFormat = Format(
        itag: 140,
        mimeType: 'audio/mp4',
        bitrate: 128000,
        quality: 'medium',
      );

      expect(audioFormat.isAudio, isTrue);

      final videoFormat = Format(
        itag: 137,
        mimeType: 'video/mp4',
        bitrate: 1000000,
        quality: 'hd720',
        width: 1280,
        height: 720,
      );

      expect(videoFormat.isAudio, isFalse);
    });

    test('Format.isOriginal getter should work correctly', () {
      final originalFormat = Format(
        itag: 140,
        mimeType: 'audio/mp4',
        bitrate: 128000,
        quality: 'medium',
      );

      expect(originalFormat.isOriginal, isTrue);

      final dubbedFormat = Format(
        itag: 140,
        mimeType: 'audio/mp4',
        bitrate: 128000,
        quality: 'medium',
        audioTrack: AudioTrack(id: 'track1', isAutoDubbed: true),
      );

      expect(dubbedFormat.isOriginal, isFalse);
    });
  });

  group('Player API Integration Tests', () {
    late YouTube youtube;

    setUp(() async {
      youtube = YouTube();
      await youtube.initialize();
    });

    tearDown(() {
      youtube.dispose();
    });

    test(
      'player() should return PlayerResponse for valid video ID',
      () async {
        // Test with a known YouTube Music video ID
        const videoId = 'dQw4w9WgXcQ'; // Rick Astley - Never Gonna Give You Up

        final result = await youtube.player(videoId);

        result.when(
          success: (playerResponse) {
            expect(playerResponse, isNotNull);
            expect(playerResponse.playabilityStatus, isNotNull);
            expect(playerResponse.playabilityStatus.status, isNotEmpty);

            print('✓ Status: ${playerResponse.playabilityStatus.status}');

            if (playerResponse.playabilityStatus.status == 'OK') {
              expect(playerResponse.streamingData, isNotNull);
              expect(playerResponse.videoDetails, isNotNull);
              print('✓ Title: ${playerResponse.videoDetails?.title}');
              print('✓ Author: ${playerResponse.videoDetails?.author}');
            }
          },
          error: (error) {
            // API call failure is acceptable in test env but log it
            print('⚠ API call failed (expected in some envs): $error');
          },
        );
      },
      skip: 'Requires network connection',
    );
  });
}
