import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: NotHesaplama(),
    );
  }
}

class NotHesaplama extends StatefulWidget {
  NotHesaplama({Key key}) : super(key: key);

  @override
  _NotHesaplamaState createState() => _NotHesaplamaState();
}

class _NotHesaplamaState extends State<NotHesaplama> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  double ortalama = 0.0;
  var formKey = GlobalKey<FormState>();
  List<Ders> tumdersler;
  static int sayac = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumdersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Not Hesaplama"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
              }
            },
            child: Icon(Icons.add),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return uygulamagovdesi();
            } else {
              return uygulamagovdesilandspape();
            }
          })),
    );
  }

  Widget uygulamagovdesi() {
    sayac++;
    print(sayac);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // STATİK FORMU TUTAN CONTAİNER
          Container(
            padding: EdgeInsets.all(10),
            //   color: Colors.blue.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      border: OutlineInputBorder(),
                    ),
                    validator: (girilendeger) {
                      if (girilendeger.length > 0) {
                        return null;
                      } else {
                        return "Ders adi boş olamaz";
                      }
                    },
                    onSaved: (kaydedilecekdeger) {
                      dersAdi = kaydedilecekdeger;
                      setState(() {
                        tumdersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi,
                            rasgelerenkolustur()));
                        ortalama = 0;
                        ortlamahesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue.shade400),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKredileri(),
                            value: dersKredi,
                            onChanged: (gelenkredi) {
                              setState(() {
                                dersKredi = gelenkredi;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple.shade400),
                            borderRadius: BorderRadius.circular(7)),
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(4),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              items: harfdergerleri(),
                              value: dersHarfDegeri,
                              onChanged: (harfdegeri) {
                                setState(() {
                                  dersHarfDegeri = harfdegeri;
                                });
                              }),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Center(
                child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: tumdersler.length == 0
                        ? "Lütfen Ders ve Not bilgilerini giriniz"
                        : "Ortalama : ",
                    style: TextStyle(
                      fontSize: 18,
                    )),
                TextSpan(
                    text: tumdersler.length == 0 ? "" : "$ortalama",
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ]),
            )),
          ),

          // DİNAMİK FORMU TUTAN CONTAİNER
          Expanded(
            child: Container(
              //  color: Colors.green.shade600,
              child: Form(
                  child: Container(
                child: ListView.builder(
                  itemBuilder: dinamikliste,
                  itemCount: tumdersler.length,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget uygulamagovdesilandspape() {
    sayac++;

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            // SOL TARAFTAKİ BÖLÜM
            child: Container(
              child: Container(
                padding: EdgeInsets.all(10),
                //   color: Colors.blue.shade200,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Ders Adı",
                          border: OutlineInputBorder(),
                        ),
                        validator: (girilendeger) {
                          if (girilendeger.length > 0) {
                            return null;
                          } else {
                            return "Ders adi boş olamaz";
                          }
                        },
                        onSaved: (kaydedilecekdeger) {
                          dersAdi = kaydedilecekdeger;
                          setState(() {
                            tumdersler.add(Ders(dersAdi, dersHarfDegeri,
                                dersKredi, rasgelerenkolustur()));
                            ortalama = 0;
                            ortlamahesapla();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue.shade400),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                items: dersKredileri(),
                                value: dersKredi,
                                onChanged: (gelenkredi) {
                                  setState(() {
                                    dersKredi = gelenkredi;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple.shade400),
                                borderRadius: BorderRadius.circular(7)),
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.all(4),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  items: harfdergerleri(),
                                  value: dersHarfDegeri,
                                  onChanged: (harfdegeri) {
                                    setState(() {
                                      dersHarfDegeri = harfdegeri;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Container(
                          
                           
                            color: Colors.blue,
                            child: Center(
                              
                                child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: tumdersler.length == 0
                                        ? "Lütfen Ders ve Not bilgilerini giriniz"
                                        : "Ortalama : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                TextSpan(
                                    text:
                                        tumdersler.length == 0 ? "" : "$ortalama",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ]),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            // SAĞ TARAFATAKİ BÖLÜM
            child: Container(
              child: Container(
                //  color: Colors.green.shade600,
                child: Form(
                    child: Container(
                  child: ListView.builder(
                    itemBuilder: dinamikliste,
                    itemCount: tumdersler.length,
                  ),
                )),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }

  dersKredileri() {
    List<DropdownMenuItem<int>> krediler = [];

    for (var i = 1; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        child: Text("$i Kredi"),
        value: i,
      ));
    }

    return krediler;
  }

  harfdergerleri() {
    List<DropdownMenuItem<double>> harfler = [];

    harfler.add(DropdownMenuItem(
      child: Text("A1"),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("A2"),
      value: 3.70,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("B1"),
      value: 3.30,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("B2"),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("C1"),
      value: 2.70,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("C2"),
      value: 2.30,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("D1"),
      value: 1.70,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("D2"),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("E"),
      value: 0.50,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("F1"),
      value: 0,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("F2"),
      value: 0,
    ));

    return harfler;
  }

  Widget dinamikliste(BuildContext context, int index) {
    Color rastgelecerceverengi = rasgelerenkolustur();

    return Dismissible(
      direction: DismissDirection
          .startToEnd, // sadece soldan sağa doğru sürüklediğimizde çalışır dismissible'ın ne tarafa doğru çalışacağını
      key: Key(sayac.toString()),
      onDismissed: (dismissed) {
        // dismissible işlemi gerçekleştirildikten sonra yapılacak işlemleri parantez içinde yaparız
        setState(() {
          tumdersler.removeAt(index);
          ortlamahesapla();
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          border: Border.all(width: 2, color: tumdersler[index].renk),
        ),
        child: ListTile(
          title: Text(tumdersler[index].dersAdi.toString()),
          subtitle: Text(tumdersler[index].kredi.toString() +
              " kredi ders" +
              " Not Değeri " +
              tumdersler[index].harfdegeri.toString()),
        ),
      ),
    );
  }

  void ortlamahesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;

    for (var oankideger in tumdersler) {
      var ortkredi = oankideger.kredi;
      var ortharfdegeri = oankideger.harfdegeri;

      toplamNot += (ortharfdegeri * ortkredi);
      toplamKredi += ortkredi;
    }

    ortalama = toplamNot / toplamKredi;
  }

  Color rasgelerenkolustur() {
    return Color.fromARGB(150 + Random().nextInt(105), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255));
  }
}

class Ders {
  String dersAdi;
  double harfdegeri;
  int kredi;
  Color renk;

  Ders(this.dersAdi, this.harfdegeri, this.kredi, this.renk);
}
