import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finalpro/pages/firestore.dart';
import 'package:finalpro/pages/gorevekleme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("görev listesi"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const gorev_ekleme()));
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getgorevStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List gorevList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: gorevList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = gorevList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String gorevadi = data['gorev'];
                String baslangictarihi = data['baslangictarihi'];
                String bitistarihi = data['bitistarihi'];
                bool eklemeOnayi = data["eklemeonayi"];
                if (eklemeOnayi == true) {
                  return Card(
                    child: ListTile(
                      title: Text(gorevadi,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "gorev: $gorevadi, baslangic tarihi: $baslangictarihi, bitiş tarihi: $bitistarihi"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => gorev_ekleme(
                                    docID: docID,
                                    gorevAdi: gorevadi,
                                    baslangicTarihi: baslangictarihi,
                                    bitisTarihi: bitistarihi,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Görev Silme'),
                                  content: const Text(
                                      'Bu görevi silmek istediğinizden emin misiniz?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('İptal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await FirestoreService()
                                            .deletegorev(docID);

                                        Navigator.pop(context);
                                      },
                                      child: const Text('Sil'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return const ListTile(title: Text("gorev yok"));
          }
        },
      ),
    );
  }
}
