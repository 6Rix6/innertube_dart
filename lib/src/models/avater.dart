import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avater.g.dart';

@JsonSerializable()
class AvatarStackViewModel {
  final List<AvatarStackViewModelAvatar>? avatars;
  final AvatarStackViewModelText text;
  final RendererContext rendererContext;

  const AvatarStackViewModel({
    this.avatars,
    required this.text,
    required this.rendererContext,
  });

  factory AvatarStackViewModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarStackViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarStackViewModelToJson(this);
}

@JsonSerializable()
class AvatarStackViewModelText {
  final String content;

  const AvatarStackViewModelText({required this.content});

  factory AvatarStackViewModelText.fromJson(Map<String, dynamic> json) =>
      _$AvatarStackViewModelTextFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarStackViewModelTextToJson(this);
}

@JsonSerializable()
class AvatarStackViewModelAvatar {
  final AvatarViewModel avatarViewModel;

  const AvatarStackViewModelAvatar({required this.avatarViewModel});

  factory AvatarStackViewModelAvatar.fromJson(Map<String, dynamic> json) =>
      _$AvatarStackViewModelAvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarStackViewModelAvatarToJson(this);
}

@JsonSerializable()
class AvatarViewModel {
  final AvatarViewModelImage image;

  const AvatarViewModel({required this.image});

  factory AvatarViewModel.fromJson(Map<String, dynamic> json) =>
      _$AvatarViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarViewModelToJson(this);
}

@JsonSerializable()
class AvatarViewModelImage {
  final List<AvatarViewModelImageSource> sources;

  const AvatarViewModelImage({required this.sources});

  factory AvatarViewModelImage.fromJson(Map<String, dynamic> json) =>
      _$AvatarViewModelImageFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarViewModelImageToJson(this);
}

@JsonSerializable()
class AvatarViewModelImageSource {
  final String url;

  const AvatarViewModelImageSource({required this.url});

  factory AvatarViewModelImageSource.fromJson(Map<String, dynamic> json) =>
      _$AvatarViewModelImageSourceFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarViewModelImageSourceToJson(this);
}

@JsonSerializable()
class RendererContext {
  final AccessibilityData? accessibilityContext;
  final CommandContext? commandContext;

  const RendererContext({this.accessibilityContext, this.commandContext});

  factory RendererContext.fromJson(Map<String, dynamic> json) =>
      _$RendererContextFromJson(json);
  Map<String, dynamic> toJson() => _$RendererContextToJson(this);
}

@JsonSerializable()
class CommandContext {
  final CommandContextOnTap? onTap;

  const CommandContext({this.onTap});

  factory CommandContext.fromJson(Map<String, dynamic> json) =>
      _$CommandContextFromJson(json);
  Map<String, dynamic> toJson() => _$CommandContextToJson(this);
}

@JsonSerializable()
class CommandContextOnTap {
  final NavigationEndpoint? innertubeCommand;

  const CommandContextOnTap({this.innertubeCommand});

  factory CommandContextOnTap.fromJson(Map<String, dynamic> json) =>
      _$CommandContextOnTapFromJson(json);
  Map<String, dynamic> toJson() => _$CommandContextOnTapToJson(this);
}
