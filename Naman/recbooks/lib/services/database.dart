import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recbooks/models/user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "Error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "Success";
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String? uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.get("fullName");
      retVal.email = _docSnapshot.get("email");
      retVal.accountCreated = _docSnapshot.get("accountCreated");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }
}
