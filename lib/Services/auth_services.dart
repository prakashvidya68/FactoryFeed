import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {

  FirebaseUser mCurrentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Shared State for Widgets
  Observable<FirebaseUser> user;
  PublishSubject loading = PublishSubject();

  // constructor
  AuthService() {

    user = Observable(_auth.onAuthStateChanged);

  }

  Future<FirebaseUser> googleSignIn() async {

    loading.add(true);

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;
    // Done
    loading.add(false); 
    print("signed in as " + user.displayName );
    return user;

  }

  void signOut() {

    _auth.signOut();
  }

  Future<String> getToken() async {

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    return googleAuth.idToken;

  }
}

final AuthService authService = AuthService();