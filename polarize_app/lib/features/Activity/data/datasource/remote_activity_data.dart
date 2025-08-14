import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polarize_app/features/Activity/data/model/activity_model.dart';

class RemoteActivityData {
  String? getUserUuid() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Future<void> createActivityForNewUser(ActivityModel activity) async {
    try {
      final userID = getUserUuid();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('activity')
          .doc('activityDoc')
          .set(activity.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ActivityModel> getActivity() async {
    final userID = getUserUuid();
    final DocumentSnapshot<Map<String, dynamic>> activityFireBase =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('activity')
            .doc('activityDoc')
            .get();
    final data = activityFireBase.data();
    if (data == null) return ActivityModel();
    return ActivityModel.fromMap(data);
  }

  Future<void> updateActivity(ActivityModel activityModel) async {
    final userID = getUserUuid();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('activity')
        .doc('activityDoc')
        .update(activityModel.toMap());
  }
}
