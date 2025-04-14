import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "weight" field.
  double? _weight;
  double get weight => _weight ?? 0.0;
  bool hasWeight() => _weight != null;

  // "Username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "FullName" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  // "NPS_Score" field.
  int? _nPSScore;
  int get nPSScore => _nPSScore ?? 0;
  bool hasNPSScore() => _nPSScore != null;

  // "Birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "Meal1" field.
  String? _meal1;
  String get meal1 => _meal1 ?? '';
  bool hasMeal1() => _meal1 != null;

  // "Meal2" field.
  String? _meal2;
  String get meal2 => _meal2 ?? '';
  bool hasMeal2() => _meal2 != null;

  // "Meal3" field.
  String? _meal3;
  String get meal3 => _meal3 ?? '';
  bool hasMeal3() => _meal3 != null;

  // "Calorie_Intake" field.
  double? _calorieIntake;
  double get calorieIntake => _calorieIntake ?? 0.0;
  bool hasCalorieIntake() => _calorieIntake != null;

  // "Calorie_Loss" field.
  double? _calorieLoss;
  double get calorieLoss => _calorieLoss ?? 0.0;
  bool hasCalorieLoss() => _calorieLoss != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _weight = castToType<double>(snapshotData['weight']);
    _username = snapshotData['Username'] as String?;
    _fullName = snapshotData['FullName'] as String?;
    _nPSScore = castToType<int>(snapshotData['NPS_Score']);
    _birthday = snapshotData['Birthday'] as DateTime?;
    _meal1 = snapshotData['Meal1'] as String?;
    _meal2 = snapshotData['Meal2'] as String?;
    _meal3 = snapshotData['Meal3'] as String?;
    _calorieIntake = castToType<double>(snapshotData['Calorie_Intake']);
    _calorieLoss = castToType<double>(snapshotData['Calorie_Loss']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  double? weight,
  String? username,
  String? fullName,
  int? nPSScore,
  DateTime? birthday,
  String? meal1,
  String? meal2,
  String? meal3,
  double? calorieIntake,
  double? calorieLoss,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'weight': weight,
      'Username': username,
      'FullName': fullName,
      'NPS_Score': nPSScore,
      'Birthday': birthday,
      'Meal1': meal1,
      'Meal2': meal2,
      'Meal3': meal3,
      'Calorie_Intake': calorieIntake,
      'Calorie_Loss': calorieLoss,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.weight == e2?.weight &&
        e1?.username == e2?.username &&
        e1?.fullName == e2?.fullName &&
        e1?.nPSScore == e2?.nPSScore &&
        e1?.birthday == e2?.birthday &&
        e1?.meal1 == e2?.meal1 &&
        e1?.meal2 == e2?.meal2 &&
        e1?.meal3 == e2?.meal3 &&
        e1?.calorieIntake == e2?.calorieIntake &&
        e1?.calorieLoss == e2?.calorieLoss;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.weight,
        e?.username,
        e?.fullName,
        e?.nPSScore,
        e?.birthday,
        e?.meal1,
        e?.meal2,
        e?.meal3,
        e?.calorieIntake,
        e?.calorieLoss
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
