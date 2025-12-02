import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:innertube_dart/src/models/icon.dart';

part 'account_menu_response.g.dart';

@JsonSerializable()
class AccountMenuResponse {
  final List<MenuAction> actions;

  const AccountMenuResponse({required this.actions});

  factory AccountMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountMenuResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccountMenuResponseToJson(this);
}

@JsonSerializable()
class MenuAction {
  final String clickTrackingParams;
  final OpenPopupAction openPopupAction;

  const MenuAction({
    required this.clickTrackingParams,
    required this.openPopupAction,
  });

  factory MenuAction.fromJson(Map<String, dynamic> json) =>
      _$MenuActionFromJson(json);
  Map<String, dynamic> toJson() => _$MenuActionToJson(this);
}

@JsonSerializable()
class OpenPopupAction {
  final String? popupType;
  final Popup popup;

  const OpenPopupAction({this.popupType, required this.popup});

  factory OpenPopupAction.fromJson(Map<String, dynamic> json) =>
      _$OpenPopupActionFromJson(json);
  Map<String, dynamic> toJson() => _$OpenPopupActionToJson(this);
}

@JsonSerializable()
class Popup {
  final MultiPageMenuRenderer multiPageMenuRenderer;

  const Popup({required this.multiPageMenuRenderer});

  factory Popup.fromJson(Map<String, dynamic> json) => _$PopupFromJson(json);
  Map<String, dynamic> toJson() => _$PopupToJson(this);
}

@JsonSerializable()
class MultiPageMenuRenderer {
  final MultiPageMenuRendererHeader? header;
  final List<MultiPageMenuRendererSection> sections;

  const MultiPageMenuRenderer({this.header, required this.sections});

  factory MultiPageMenuRenderer.fromJson(Map<String, dynamic> json) =>
      _$MultiPageMenuRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MultiPageMenuRendererToJson(this);
}

@JsonSerializable()
class MultiPageMenuRendererHeader {
  final ActiveAccountHeaderRenderer activeAccountHeaderRenderer;

  const MultiPageMenuRendererHeader({
    required this.activeAccountHeaderRenderer,
  });

  factory MultiPageMenuRendererHeader.fromJson(Map<String, dynamic> json) =>
      _$MultiPageMenuRendererHeaderFromJson(json);
  Map<String, dynamic> toJson() => _$MultiPageMenuRendererHeaderToJson(this);
}

@JsonSerializable()
class ActiveAccountHeaderRenderer {
  final Runs accountName;
  final Thumbnails accountPhoto;
  final Map<String, dynamic> settingsEndpoint;
  final Runs manageAccountTitle;
  final String trackingParams;
  final Runs channelHandle;

  const ActiveAccountHeaderRenderer({
    required this.accountName,
    required this.accountPhoto,
    required this.settingsEndpoint,
    required this.manageAccountTitle,
    required this.trackingParams,
    required this.channelHandle,
  });

  factory ActiveAccountHeaderRenderer.fromJson(Map<String, dynamic> json) =>
      _$ActiveAccountHeaderRendererFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveAccountHeaderRendererToJson(this);
}

@JsonSerializable()
class MultiPageMenuRendererSection {
  final MultiPageMenuSectionRenderer? multiPageMenuSectionRenderer;

  const MultiPageMenuRendererSection({this.multiPageMenuSectionRenderer});

  factory MultiPageMenuRendererSection.fromJson(Map<String, dynamic> json) =>
      _$MultiPageMenuRendererSectionFromJson(json);
  Map<String, dynamic> toJson() => _$MultiPageMenuRendererSectionToJson(this);
}

@JsonSerializable()
class MultiPageMenuSectionRenderer {
  final String trackingParams;
  final List<MultiPageMenuSectionRendererItem> items;

  const MultiPageMenuSectionRenderer({
    required this.trackingParams,
    required this.items,
  });

  factory MultiPageMenuSectionRenderer.fromJson(Map<String, dynamic> json) =>
      _$MultiPageMenuSectionRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MultiPageMenuSectionRendererToJson(this);
}

@JsonSerializable()
class MultiPageMenuSectionRendererItem {
  final CompactLinkRenderer? compactLinkRenderer;

  const MultiPageMenuSectionRendererItem({this.compactLinkRenderer});

  factory MultiPageMenuSectionRendererItem.fromJson(
    Map<String, dynamic> json,
  ) => _$MultiPageMenuSectionRendererItemFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MultiPageMenuSectionRendererItemToJson(this);
}

@JsonSerializable()
class CompactLinkRenderer {
  final String trackingParams;
  final Runs title;
  final Icon icon;
  final NavigationEndpoint? navigationEndpoint;
  final ServiceEndpoint? serviceEndpoint;

  const CompactLinkRenderer({
    required this.trackingParams,
    required this.title,
    required this.icon,
    this.navigationEndpoint,
    this.serviceEndpoint,
  });

  factory CompactLinkRenderer.fromJson(Map<String, dynamic> json) =>
      _$CompactLinkRendererFromJson(json);
  Map<String, dynamic> toJson() => _$CompactLinkRendererToJson(this);
}
