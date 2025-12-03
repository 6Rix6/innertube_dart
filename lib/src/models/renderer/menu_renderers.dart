import 'package:innertube_dart/src/models/accessibility_data.dart';
import 'package:innertube_dart/src/models/endpoints.dart';
import 'package:innertube_dart/src/models/icon.dart';
import 'package:innertube_dart/src/models/runs.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_renderers.g.dart';

@JsonSerializable()
class Menu {
  final MenuRenderer menuRenderer;

  const Menu({required this.menuRenderer});

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class MenuRenderer {
  final List<MenuRendererItem>? items;
  final Accessibility? accessibility;

  const MenuRenderer({required this.items, this.accessibility});

  factory MenuRenderer.fromJson(Map<String, dynamic> json) =>
      _$MenuRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MenuRendererToJson(this);
}

@JsonSerializable()
class MenuRendererItem {
  final MenuNavigationItemRenderer? menuNavigationItemRenderer;
  final MenuServiceItemRenderer? menuServiceItemRenderer;
  final Map<String, dynamic>? toggleMenuServiceItemRenderer;

  const MenuRendererItem({
    this.menuNavigationItemRenderer,
    this.menuServiceItemRenderer,
    this.toggleMenuServiceItemRenderer,
  });

  factory MenuRendererItem.fromJson(Map<String, dynamic> json) =>
      _$MenuRendererItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuRendererItemToJson(this);
}

@JsonSerializable()
class MenuNavigationItemRenderer {
  final String trackingParams;
  final Runs text;
  final Icon icon;
  final NavigationEndpoint? navigationEndpoint;

  const MenuNavigationItemRenderer({
    required this.trackingParams,
    required this.text,
    required this.icon,
    this.navigationEndpoint,
  });

  factory MenuNavigationItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MenuNavigationItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MenuNavigationItemRendererToJson(this);
}

@JsonSerializable()
class MenuServiceItemRenderer {
  final String trackingParams;
  final Runs text;
  final Icon icon;
  final NavigationEndpoint? serviceEndpoint;

  const MenuServiceItemRenderer({
    required this.trackingParams,
    required this.text,
    required this.icon,
    this.serviceEndpoint,
  });

  factory MenuServiceItemRenderer.fromJson(Map<String, dynamic> json) =>
      _$MenuServiceItemRendererFromJson(json);
  Map<String, dynamic> toJson() => _$MenuServiceItemRendererToJson(this);
}
