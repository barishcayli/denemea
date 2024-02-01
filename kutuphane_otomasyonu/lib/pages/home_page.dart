import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kutuphane_otomasyonu/pages/firestore.dart';
import 'package:kutuphane_otomasyonu/pages/kitap_ekleme_sayfasi.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // int _selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Barış Çaylı kütüphane otomasyonu"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const kitap_ekleme()));
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getBooksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List bookList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = bookList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String KitapAdi = data['kitapadi'];
                String YazarAdi = data['yazar'];
                String SayfaSayisi = data['sayfasayisi'];
                bool eklemeOnayi = data['eklemeonayi'];
                String YayinEvi = data['yayinevi'];
                String Kategori = data['kategori'];
                String BasimYili = data['basimYili'];
                if (eklemeOnayi == true) {
                  return Card(
                    child: ListTile(
                      title: Text(KitapAdi,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text("yazar: " +
                          YazarAdi +
                          ", Sayfa Sayısı: " +
                          SayfaSayisi),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => kitap_ekleme(
                                    docID: docID,
                                    kitapAdi: KitapAdi,
                                    yayinEvi: YayinEvi,
                                    yazar: YazarAdi,
                                    kategori: Kategori,
                                    sayfaSayisi: SayfaSayisi,
                                    basimYili: BasimYili,
                                    eklemeOnayi: true,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Kitap Silme'),
                                  content: Text(
                                      'Bu kitabı silmek istediğinizden emin misiniz?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('İptal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await FirestoreService()
                                            .deleteBook(docID);

                                        Navigator.pop(context);
                                      },
                                      child: Text('Sil'),
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
            return ListTile(title: Text("kitap yok"));
          }
        },
      ),

      //bu kısım işlevsiz fakat attığınız görselde bulunduğundan yaptım yorum satırlarını kaldırarak  bakabilirsiniz 12. satırda da bir yorum satırı bulunmakta
      /* 
       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Kitaplar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Satın al',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          (() {
            _selectedIndex = index;
          });
        },
      ),
      */
    );
  }
}
