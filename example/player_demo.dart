import 'package:innertube_dart/innertube_dart.dart';

void main() async {
  print('=== Player API Demo ===\n');

  // YouTubeクライアントの初期化
  final youtube = YouTube();
  await youtube.initialize();
  print('✓ YouTube client initialized\n');

  // テスト用の動画ID（Rick Astley - Never Gonna Give You Up）
  const videoId = 'dQw4w9WgXcQ';
  print('Fetching player data for video: $videoId\n');

  // Player情報を取得
  final result = await youtube.player(videoId);

  result.when(
    success: (playerResponse) {
      print('✅ Player Response Retrieved!\n');

      // ステータス表示
      print('Playability Status: ${playerResponse.playabilityStatus.status}');
      if (playerResponse.playabilityStatus.reason != null) {
        print('Reason: ${playerResponse.playabilityStatus.reason}');
      }
      print('');

      // 動画詳細
      if (playerResponse.videoDetails != null) {
        final details = playerResponse.videoDetails!;
        print('📹 Video Details:');
        print('  Title: ${details.title}');
        print('  Author: ${details.author}');
        print('  Channel ID: ${details.channelId}');
        print('  Length: ${details.lengthSeconds}s');
        if (details.viewCount != null) {
          print('  Views: ${details.viewCount}');
        }
        print('');
      }

      // ストリーミングデータ
      if (playerResponse.streamingData != null) {
        final streaming = playerResponse.streamingData!;
        print('🎵 Streaming Data:');
        print('  Expires in: ${streaming.expiresInSeconds}s');
        print('  Adaptive Formats: ${streaming.adaptiveFormats.length}');

        // オーディオフォーマット
        final audioFormats = streaming.adaptiveFormats
            .where((f) => f.isAudio)
            .toList();
        print('  Audio Formats: ${audioFormats.length}');

        if (audioFormats.isNotEmpty) {
          print('\n  Audio Format Details:');
          for (var i = 0; i < audioFormats.length && i < 3; i++) {
            final format = audioFormats[i];
            print('    [${i + 1}] itag: ${format.itag}');
            print('        MIME: ${format.mimeType}');
            print('        Bitrate: ${format.bitrate}');
            print('        Quality: ${format.audioQuality ?? "N/A"}');
            print('        Has URL: ${format.url != null}');
            if (format.audioSampleRate != null) {
              print('        Sample Rate: ${format.audioSampleRate} Hz');
            }
            print('');
          }
        }

        // ビデオフォーマット
        final videoFormats = streaming.adaptiveFormats
            .where((f) => !f.isAudio)
            .toList();
        if (videoFormats.isNotEmpty) {
          print('  Video Formats: ${videoFormats.length}');
          final firstVideo = videoFormats.first;
          print(
            '    First: ${firstVideo.qualityLabel} (${firstVideo.width}x${firstVideo.height})',
          );
        }
        print('');
      }

      // プレイヤー設定
      if (playerResponse.playerConfig != null) {
        final config = playerResponse.playerConfig!;
        print('🔊 Audio Config:');
        if (config.audioConfig.loudnessDb != null) {
          print('  Loudness: ${config.audioConfig.loudnessDb} dB');
        }
        if (config.audioConfig.perceptualLoudnessDb != null) {
          print(
            '  Perceptual Loudness: ${config.audioConfig.perceptualLoudnessDb} dB',
          );
        }
        print('');
      }
    },
    error: (error) {
      print('❌ Error: $error');
      if (error is Error) {
        print('\nStack trace:');
        print(error.stackTrace);
      }
    },
  );

  youtube.dispose();
  print('✓ Completed');
}
