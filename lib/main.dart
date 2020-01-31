import 'package:flutter/material.dart';

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
  var formKey = GlobalKey<FormState>();
  List<Ders> tumdersler;

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
        body: uygulamagovdesi(),
      ),
    );
  }

  Widget uygulamagovdesi() {
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
                        tumdersler
                            .add(Ders(dersAdi, dersHarfDegeri, dersKredi));
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

          // DİNAMİK FORMU TUTAN CONTAİNER
          Expanded(
            child: Container(
              color: Colors.green.shade600,
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
    return Card(
      child: ListTile(
        title: Text(tumdersler[index].dersAdi.toString()),
        subtitle: Text(tumdersler[index].kredi.toString() +
            " kredi ders" +
            " Not Değeri " +
            tumdersler[index].harfdegeri.toString()),
      ),
    );
  }
}

class Ders {
  String dersAdi;
  double harfdegeri;
  int kredi;

  Ders(this.dersAdi, this.harfdegeri, this.kredi);
}
