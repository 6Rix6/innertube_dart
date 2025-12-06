// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avater.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarStackViewModel _$AvatarStackViewModelFromJson(
  Map<String, dynamic> json,
) => AvatarStackViewModel(
  avatars: (json['avatars'] as List<dynamic>?)
      ?.map(
        (e) => AvatarStackViewModelAvatar.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  text: AvatarStackViewModelText.fromJson(json['text'] as Map<String, dynamic>),
  rendererContext: RendererContext.fromJson(
    json['rendererContext'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AvatarStackViewModelToJson(
  AvatarStackViewModel instance,
) => <String, dynamic>{
  'avatars': instance.avatars,
  'text': instance.text,
  'rendererContext': instance.rendererContext,
};

AvatarStackViewModelText _$AvatarStackViewModelTextFromJson(
  Map<String, dynamic> json,
) => AvatarStackViewModelText(content: json['content'] as String);

Map<String, dynamic> _$AvatarStackViewModelTextToJson(
  AvatarStackViewModelText instance,
) => <String, dynamic>{'content': instance.content};

AvatarStackViewModelAvatar _$AvatarStackViewModelAvatarFromJson(
  Map<String, dynamic> json,
) => AvatarStackViewModelAvatar(
  avatarViewModel: AvatarViewModel.fromJson(
    json['avatarViewModel'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AvatarStackViewModelAvatarToJson(
  AvatarStackViewModelAvatar instance,
) => <String, dynamic>{'avatarViewModel': instance.avatarViewModel};

AvatarViewModel _$AvatarViewModelFromJson(Map<String, dynamic> json) =>
    AvatarViewModel(
      image: AvatarViewModelImage.fromJson(
        json['image'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AvatarViewModelToJson(AvatarViewModel instance) =>
    <String, dynamic>{'image': instance.image};

AvatarViewModelImage _$AvatarViewModelImageFromJson(
  Map<String, dynamic> json,
) => AvatarViewModelImage(
  sources: (json['sources'] as List<dynamic>)
      .map(
        (e) => AvatarViewModelImageSource.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$AvatarViewModelImageToJson(
  AvatarViewModelImage instance,
) => <String, dynamic>{'sources': instance.sources};

AvatarViewModelImageSource _$AvatarViewModelImageSourceFromJson(
  Map<String, dynamic> json,
) => AvatarViewModelImageSource(url: json['url'] as String);

Map<String, dynamic> _$AvatarViewModelImageSourceToJson(
  AvatarViewModelImageSource instance,
) => <String, dynamic>{'url': instance.url};

RendererContext _$RendererContextFromJson(Map<String, dynamic> json) =>
    RendererContext(
      accessibilityContext: json['accessibilityContext'] == null
          ? null
          : AccessibilityData.fromJson(
              json['accessibilityContext'] as Map<String, dynamic>,
            ),
      commandContext: json['commandContext'] == null
          ? null
          : CommandContext.fromJson(
              json['commandContext'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$RendererContextToJson(RendererContext instance) =>
    <String, dynamic>{
      'accessibilityContext': instance.accessibilityContext,
      'commandContext': instance.commandContext,
    };

CommandContext _$CommandContextFromJson(Map<String, dynamic> json) =>
    CommandContext(
      onTap: json['onTap'] == null
          ? null
          : CommandContextOnTap.fromJson(json['onTap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommandContextToJson(CommandContext instance) =>
    <String, dynamic>{'onTap': instance.onTap};

CommandContextOnTap _$CommandContextOnTapFromJson(Map<String, dynamic> json) =>
    CommandContextOnTap(
      innertubeCommand: json['innertubeCommand'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['innertubeCommand'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CommandContextOnTapToJson(
  CommandContextOnTap instance,
) => <String, dynamic>{'innertubeCommand': instance.innertubeCommand};
