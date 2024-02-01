import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference gorev =
      FirebaseFirestore.instance.collection("gorev");

  Future<void> addgorev(
    String gorevadi,
    String baslangictarihi,
    String bitistarihi,
  ) {
    return gorev.add({
      'gorev': gorevadi,
      'baslangictarihi': baslangictarihi,
      'bitistarihi': bitistarihi,
      'eklemeonayi': true,
      'eklenme zamanı': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getgorevStream() {
    final gorevStream =
        gorev.orderBy('eklenme zamanı', descending: true).snapshots();

    return gorevStream;
  }

  Future<void> updategorev(
    String docID,
    String gorevadi,
    String baslangictarihi,
    String bitistarihi,
  ) {
    return gorev.add({
      'gorev': gorevadi,
      'baslangictarihi': baslangictarihi,
      'bitistarihi': bitistarihi,
      'eklenme zamanı': Timestamp.now()
    });
  }

  Future<void> deletegorev(String docID) {
    return gorev.doc(docID).delete();
  }
}
