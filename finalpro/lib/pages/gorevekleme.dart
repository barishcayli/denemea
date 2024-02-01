import 'package:flutter/material.dart';
import 'package:finalpro/pages/firestore.dart';

class gorev_ekleme extends StatefulWidget {
  final String? docID;
  final String? gorevAdi;
  final String? baslangicTarihi;
  final String? bitisTarihi;

  const gorev_ekleme({
    Key? key,
    this.docID,
    this.gorevAdi,
    this.baslangicTarihi,
    this.bitisTarihi,
  }) : super(key: key);

  @override
  State<gorev_ekleme> createState() => _gorev_eklemeState();
}

class _gorev_eklemeState extends State<gorev_ekleme> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController AdKontrol = TextEditingController();
  final TextEditingController baslangic = TextEditingController();
  final TextEditingController bitis = TextEditingController();
  String KategoriKontrol = 'Roman';

  bool paylasimKontrol = false;
  List<String> categories = [
    'Roman',
    'Tarih',
    'Edebiyat',
    'Şiir',
    'Ansiklopedi',
    'Bilim Kurgu',
    'Distopya',
    'Fantastik'
  ];

  @override
  void initState() {
    super.initState();
    AdKontrol.text = widget.gorevAdi ?? '';
    baslangic.text = widget.baslangicTarihi ?? '';
    bitis.text = widget.bitisTarihi ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('gorev Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: AdKontrol,
                  decoration: const InputDecoration(labelText: 'gorev Adı'),
                ),
                TextFormField(
                  controller: baslangic,
                  decoration:
                      const InputDecoration(labelText: 'baslangictarihi'),
                ),
                TextFormField(
                  controller: bitis,
                  decoration: const InputDecoration(labelText: 'bitiştarihi'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (widget.docID == null) {
                          if (AdKontrol.text == "" ||
                              baslangic.text == "" ||
                              bitis.text == "") {
                          } else {
                            firestoreService.addgorev(
                              AdKontrol.text,
                              baslangic.text,
                              bitis.text,
                            );
                          }
                          ;
                        } else {
                          firestoreService.updategorev(
                            widget.docID!,
                            AdKontrol.text,
                            baslangic.text,
                            bitis.text,
                          );
                        }

                        Navigator.pop(context);
                      },
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
