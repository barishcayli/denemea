import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference books =
      FirebaseFirestore.instance.collection("books");

  Future<void> addBook(
    String kitapAdi,
    String yayinevi,
    String yazar,
    String kategori,
    String sayfa,
    String basimYili,
    bool eklemeonayi,
  ) {
    return books.add({
      'kitapadi': kitapAdi,
      'yayinevi': yayinevi,
      'yazar': yazar,
      'kategori': kategori,
      'sayfasayisi': sayfa,
      'basimYili': basimYili,
      'eklemeonayi': eklemeonayi,
      'eklenme zamanı': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getBooksStream() {
    final booksStream =
        books.orderBy('eklenme zamanı', descending: true).snapshots();

    return booksStream;
  }

  Future<void> updateBooks(
      String docID,
      String kitapAdi,
      String yayinevi,
      String yazar,
      String kategori,
      String sayfa,
      String basimYili,
      bool eklemeonayi) {
    return books.doc(docID).update({
      'kitapadi': kitapAdi,
      'yayinevi': yayinevi,
      'yazar': yazar,
      'kategori': kategori,
      'sayfasayisi': sayfa,
      'basimYili': basimYili,
      'eklemeonayi': eklemeonayi,
      'eklenme zamanı': Timestamp.now()
    });
  }

  Future<void> deleteBook(String docID) {
    return books.doc(docID).delete();
  }
}
