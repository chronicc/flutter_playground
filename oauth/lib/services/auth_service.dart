import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  bool get authenticated => _account != null;

  GoogleSignInAccount? _account;
  GoogleSignInAccount? get account => _account;

  Future<bool> signInWithGoogle() async {
    if (_account == null) {
      _account = await _googleSignIn.signIn();
      if (_account == null) {
        return false;
      }
      _provider = AuthProvider.google;
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
    _account = null;
    _provider = null;
    notifyListeners();
    return true;
  }
}
