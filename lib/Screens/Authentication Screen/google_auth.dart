import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

///This Class have the all Logic of Sign in with Google
///its handel all validations and other things.
class Authentication {
  static Future<User?> signInWithGoogle() async {
    //created the instance/object of FirebaseAuth class.
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    //calling the Google Sign in method form Google Sign Package/Dependency
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    //Checking if user is present then proceed
    if (googleSignInAccount != null) {
      EasyLoading.show(status: "Please Wait...");
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      //Here Checking the Validations for user <Expectation Handling Process>
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use' ||
            e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
              msg: 'The email address is already in use by another account.');
        } else if (e.code == 'invalid-credential') {
          Fluttertoast.showToast(
              msg: 'Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: "Error $e");
      }
    }
    return user;
  }

  //Calling SignOut Function for SignOut the user Form App.
  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error signing out. Try again.');
    }
  }
}
