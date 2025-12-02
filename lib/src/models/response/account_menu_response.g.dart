// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_menu_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountMenuResponse _$AccountMenuResponseFromJson(Map<String, dynamic> json) =>
    AccountMenuResponse(
      actions: (json['actions'] as List<dynamic>)
          .map((e) => MenuAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountMenuResponseToJson(
  AccountMenuResponse instance,
) => <String, dynamic>{'actions': instance.actions};

MenuAction _$MenuActionFromJson(Map<String, dynamic> json) => MenuAction(
  clickTrackingParams: json['clickTrackingParams'] as String,
  openPopupAction: OpenPopupAction.fromJson(
    json['openPopupAction'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MenuActionToJson(MenuAction instance) =>
    <String, dynamic>{
      'clickTrackingParams': instance.clickTrackingParams,
      'openPopupAction': instance.openPopupAction,
    };

OpenPopupAction _$OpenPopupActionFromJson(Map<String, dynamic> json) =>
    OpenPopupAction(
      popupType: json['popupType'] as String?,
      popup: Popup.fromJson(json['popup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenPopupActionToJson(OpenPopupAction instance) =>
    <String, dynamic>{'popupType': instance.popupType, 'popup': instance.popup};

Popup _$PopupFromJson(Map<String, dynamic> json) => Popup(
  multiPageMenuRenderer: MultiPageMenuRenderer.fromJson(
    json['multiPageMenuRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PopupToJson(Popup instance) => <String, dynamic>{
  'multiPageMenuRenderer': instance.multiPageMenuRenderer,
};

MultiPageMenuRenderer _$MultiPageMenuRendererFromJson(
  Map<String, dynamic> json,
) => MultiPageMenuRenderer(
  header: json['header'] == null
      ? null
      : MultiPageMenuRendererHeader.fromJson(
          json['header'] as Map<String, dynamic>,
        ),
  sections: (json['sections'] as List<dynamic>)
      .map(
        (e) => MultiPageMenuRendererSection.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$MultiPageMenuRendererToJson(
  MultiPageMenuRenderer instance,
) => <String, dynamic>{
  'header': instance.header,
  'sections': instance.sections,
};

MultiPageMenuRendererHeader _$MultiPageMenuRendererHeaderFromJson(
  Map<String, dynamic> json,
) => MultiPageMenuRendererHeader(
  activeAccountHeaderRenderer: ActiveAccountHeaderRenderer.fromJson(
    json['activeAccountHeaderRenderer'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MultiPageMenuRendererHeaderToJson(
  MultiPageMenuRendererHeader instance,
) => <String, dynamic>{
  'activeAccountHeaderRenderer': instance.activeAccountHeaderRenderer,
};

ActiveAccountHeaderRenderer _$ActiveAccountHeaderRendererFromJson(
  Map<String, dynamic> json,
) => ActiveAccountHeaderRenderer(
  accountName: Runs.fromJson(json['accountName'] as Map<String, dynamic>),
  accountPhoto: Thumbnails.fromJson(
    json['accountPhoto'] as Map<String, dynamic>,
  ),
  settingsEndpoint: json['settingsEndpoint'] as Map<String, dynamic>,
  manageAccountTitle: Runs.fromJson(
    json['manageAccountTitle'] as Map<String, dynamic>,
  ),
  trackingParams: json['trackingParams'] as String,
  channelHandle: Runs.fromJson(json['channelHandle'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActiveAccountHeaderRendererToJson(
  ActiveAccountHeaderRenderer instance,
) => <String, dynamic>{
  'accountName': instance.accountName,
  'accountPhoto': instance.accountPhoto,
  'settingsEndpoint': instance.settingsEndpoint,
  'manageAccountTitle': instance.manageAccountTitle,
  'trackingParams': instance.trackingParams,
  'channelHandle': instance.channelHandle,
};

MultiPageMenuRendererSection _$MultiPageMenuRendererSectionFromJson(
  Map<String, dynamic> json,
) => MultiPageMenuRendererSection(
  multiPageMenuSectionRenderer: json['multiPageMenuSectionRenderer'] == null
      ? null
      : MultiPageMenuSectionRenderer.fromJson(
          json['multiPageMenuSectionRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MultiPageMenuRendererSectionToJson(
  MultiPageMenuRendererSection instance,
) => <String, dynamic>{
  'multiPageMenuSectionRenderer': instance.multiPageMenuSectionRenderer,
};

MultiPageMenuSectionRenderer _$MultiPageMenuSectionRendererFromJson(
  Map<String, dynamic> json,
) => MultiPageMenuSectionRenderer(
  trackingParams: json['trackingParams'] as String,
  items: (json['items'] as List<dynamic>)
      .map(
        (e) => MultiPageMenuSectionRendererItem.fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$MultiPageMenuSectionRendererToJson(
  MultiPageMenuSectionRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'items': instance.items,
};

MultiPageMenuSectionRendererItem _$MultiPageMenuSectionRendererItemFromJson(
  Map<String, dynamic> json,
) => MultiPageMenuSectionRendererItem(
  compactLinkRenderer: json['compactLinkRenderer'] == null
      ? null
      : CompactLinkRenderer.fromJson(
          json['compactLinkRenderer'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$MultiPageMenuSectionRendererItemToJson(
  MultiPageMenuSectionRendererItem instance,
) => <String, dynamic>{'compactLinkRenderer': instance.compactLinkRenderer};

CompactLinkRenderer _$CompactLinkRendererFromJson(Map<String, dynamic> json) =>
    CompactLinkRenderer(
      trackingParams: json['trackingParams'] as String,
      title: Runs.fromJson(json['title'] as Map<String, dynamic>),
      icon: Icon.fromJson(json['icon'] as Map<String, dynamic>),
      navigationEndpoint: json['navigationEndpoint'] == null
          ? null
          : NavigationEndpoint.fromJson(
              json['navigationEndpoint'] as Map<String, dynamic>,
            ),
      serviceEndpoint: json['serviceEndpoint'] == null
          ? null
          : ServiceEndpoint.fromJson(
              json['serviceEndpoint'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CompactLinkRendererToJson(
  CompactLinkRenderer instance,
) => <String, dynamic>{
  'trackingParams': instance.trackingParams,
  'title': instance.title,
  'icon': instance.icon,
  'navigationEndpoint': instance.navigationEndpoint,
  'serviceEndpoint': instance.serviceEndpoint,
};
