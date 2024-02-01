import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyonu/pages/firestore.dart';

class kitap_ekleme extends StatefulWidget {
  final String? docID;
  final String? kitapAdi;
  final String? yayinEvi;
  final String? yazar;
  final String? kategori;
  final String? sayfaSayisi;
  final String? basimYili;
  final bool? eklemeOnayi;

  const kitap_ekleme({
    Key? key,
    this.docID,
    this.kitapAdi,
    this.yayinEvi,
    this.yazar,
    this.kategori,
    this.sayfaSayisi,
    this.basimYili,
    this.eklemeOnayi,
  }) : super(key: key);

  @override
  State<kitap_ekleme> createState() => _kitap_eklemeState();
}

class _kitap_eklemeState extends State<kitap_ekleme> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController AdKontrol = TextEditingController();
  final TextEditingController YayinEviKontrol = TextEditingController();
  final TextEditingController YazarKontrol = TextEditingController();
  final TextEditingController SayfaSayisiKontrol = TextEditingController();
  final TextEditingController BasimYiliKontrol = TextEditingController();
  //
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
    AdKontrol.text = widget.kitapAdi ?? '';
    YayinEviKontrol.text = widget.yayinEvi ?? '';
    YazarKontrol.text = widget.yazar ?? '';
    SayfaSayisiKontrol.text = widget.sayfaSayisi ?? '';
    BasimYiliKontrol.text = widget.basimYili ?? '';
    KategoriKontrol = widget.kategori ?? '';
    paylasimKontrol = widget.eklemeOnayi ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Ekle'),
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
                  decoration: const InputDecoration(labelText: 'Kitap Adı'),
                ),
                TextFormField(
                  controller: YayinEviKontrol,
                  decoration: const InputDecoration(labelText: 'Yayınevi'),
                ),
                TextFormField(
                  controller: YazarKontrol,
                  decoration: const InputDecoration(labelText: 'Yazarlar'),
                ),
                DropdownButtonFormField(
                  value: 'Roman',
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      KategoriKontrol = value.toString();
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Kategori Seçin',
                  ),
                ),
                TextFormField(
                  controller: SayfaSayisiKontrol,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Sayfa Sayısı'),
                ),
                TextFormField(
                  controller: BasimYiliKontrol,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Basım Yılı'),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Listede Yayınlanacak Mı?"),
                      Checkbox(
                          value: paylasimKontrol,
                          onChanged: (value) {
                            setState(() {
                              paylasimKontrol = value ?? false;
                            });
                          }),
                    ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (widget.docID == null) {
                          firestoreService.addBook(
                            AdKontrol.text,
                            YayinEviKontrol.text,
                            YazarKontrol.text,
                            KategoriKontrol,
                            SayfaSayisiKontrol.text,
                            BasimYiliKontrol.text,
                            paylasimKontrol,
                          );
                        } else {
                          firestoreService.updateBooks(
                            widget.docID!,
                            AdKontrol.text,
                            YayinEviKontrol.text,
                            YazarKontrol.text,
                            KategoriKontrol,
                            SayfaSayisiKontrol.text,
                            BasimYiliKontrol.text,
                            paylasimKontrol,
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
