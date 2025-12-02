import 'package:innertube_dart/src/models/response/account_menu_response.dart';
import 'package:innertube_dart/src/models/thumbnails.dart';

class AccountMenuPage {
  final bool isSignedIn;
  final AccountMenuResponse response;
  final String? accountName;
  final String? accountHandle;
  final Thumbnails? accountPhoto;

  AccountMenuPage({
    required this.isSignedIn,
    required this.response,
    this.accountName,
    this.accountHandle,
    this.accountPhoto,
  });

  static AccountMenuPage fromAccountMenuResponse(AccountMenuResponse response) {
    final header = response
        .actions
        .firstOrNull
        ?.openPopupAction
        .popup
        .multiPageMenuRenderer
        .header;
    final isLoggedIn = header != null;
    final accountName =
        header?.activeAccountHeaderRenderer.accountName.runs?.firstOrNull?.text;
    final accountHandle = header
        ?.activeAccountHeaderRenderer
        .channelHandle
        .runs
        ?.firstOrNull
        ?.text;
    final accountPhoto = header?.activeAccountHeaderRenderer.accountPhoto;

    return AccountMenuPage(
      isSignedIn: isLoggedIn,
      response: response,
      accountName: accountName,
      accountHandle: accountHandle,
      accountPhoto: accountPhoto,
    );
  }
}
