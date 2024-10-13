import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthProvider {
  apple,
  facebook,
  google,
  instagram,
  x,
}

class AuthService extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider? _provider;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  String? _displayName;
  String? get displayName => _displayName;

  String? _email;
  String? get email => _email;

  Future<bool> signIn(AuthProvider provider) async {
    if (!_isSignedIn) {
      switch (provider) {
        case AuthProvider.apple:
          try {
            var account = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
              webAuthenticationOptions: WebAuthenticationOptions(
                // A payed apple developer account is required to use this feature
                clientId: '',
                redirectUri: Uri.parse(''),
              ),
            );
            _displayName = '$account.givenName $account.familyName';
            _email = account.email;
          } catch (e) {
            print(e);
            return false;
          }
          break;
        case AuthProvider.google:
          try {
            var account = await _googleSignIn.signIn();
            _displayName = account!.displayName;
            _email = account.email;
          } catch (e) {
            print(e);
            return false;
          }
          break;
        default:
          return false;
      }
      _isSignedIn = true;
      _provider = provider;
    }
    notifyListeners();
    return true;
  }

  Future<bool> signOut() async {
    switch (_provider) {
      case AuthProvider.google:
        await _googleSignIn.signOut();
        break;
      default:
        return false;
    }
    _displayName = null;
    _email = null;
    _isSignedIn = false;
    _provider = null;
    notifyListeners();
    return true;
  }
}
