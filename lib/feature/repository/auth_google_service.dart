import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        print('googleUser: $googleUser');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print('credential: $credential');
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        print('error');
      }
    } catch (e) {
      print("Error function: $e");
      return null;
    }
    return null;
  }
}
