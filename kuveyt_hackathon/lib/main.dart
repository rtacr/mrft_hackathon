import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

String adSoyad = "Ad Soyad";

List<Kullanici> arkadasList = [
  Kullanici(isim: "MAHSUN RAZİ", soyisim: "", iban: "TR480020500000007789800001")
];

List<Kullanici> nonFriendList = [];
var acList;
void populate(int count) {
  Random rnd = Random();
  for (var i = 0; i < count; i++) {
    if(rnd.nextInt(100) > 10){
    nonFriendList.add(Kullanici(
        isim: "Ahmet$i",
        soyisim: "Yılmaz",
        iban: "TR" + (rnd.nextDouble() * (pow(10, 24))).round().toString()));
    }else{
      arkadasList.add(Kullanici(
        isim: "Ahmet$i",
        soyisim: "Yılmaz",
        iban: "TR" + (rnd.nextDouble() * (pow(10, 24))).round().toString()));
    }
  }
}
String token =
      "Bearer 9b39217f1e8c02bfad10ce36d109180cda1436b21797d1ebef06348d930d022a";

 void moneyTransfer(Kullanici receiver, double amount) async {
        String accounts = "https://apitest.kuveytturk.com.tr/prep//v1/transfers/toIBAN";
        var donus = await http.post(accounts,
            headers: {'Authorization': token},
            body: {
              "SenderAccountSuffix":"1",
              "ReceiverName": receiver.isim,
              "ReceiverIBAN": receiver.iban,
              "Amount": amount.toString(),
              "Comment":"test money transfer",
              "PaymentTypeId":"99"  
            }
            );
            print(donus.body);
    }
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
      // String token =
      // "Bearer 24039a8f0de6f0b397cfe89aab255894391cddb84f4ec4967e987a55e9b83488";

  @override
  void initState() {
    populate(100);
    getList();
    super.initState();
  }

 

  void getList() async {
        print('Getting List');
        String accounts = "https://apitest.kuveytturk.com.tr/prep/v1/accounts";
        var donut = await http.get(accounts,
            headers: {'Authorization': token, 'Accept': 'application/json'});

        setState(() {
          print(donut.body);
          acList = jsonDecode(donut.body);
          adSoyad = acList["value"][0]["customerName"];
        });
        print(acList.length);

        setState(() {
          print(donut.body);
          acList = jsonDecode(donut.body);
          adSoyad = acList["value"][0]["customerName"];
        });
        print(acList.length);
        
      }
  @override
  Widget build(BuildContext context) {
   

    

    @override
    void initState() {
      getList();
      super.initState();
    }

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getList();
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(adSoyad),
                currentAccountPicture: CircleAvatar(child: Icon(Icons.person, size: 60,),),
              ),
              ListTile(
                leading: CircleAvatar(child: Icon(Icons.person),),
                title: Text(
                  "Profilim",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Profilim();
                  }));
                },
              ),
              ListTile(
                leading: CircleAvatar(child: Icon(Icons.attach_money),),
                  title: Text(
                    "Para Transferi",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ParaTransferListesi();
                    }));
                  }),
              ExpansionTile(
                leading: CircleAvatar(child: Icon(Icons.account_balance_wallet),),
                backgroundColor: Colors.grey[300],
                title: Text(
                  "Ödemeler",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ListTile(
                leading: CircleAvatar(child: Icon(Icons.group),),
                    contentPadding: EdgeInsets.only(left: 48),
                      title: Text(
                        "Ortak Ödeme",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return OrtakOdeme();
                        }));
                      }),
                  ListTile(
                leading: CircleAvatar(child: Icon(Icons.healing),),
                    contentPadding: EdgeInsets.only(left: 48),
                    title: Text(
                      "Ortak Bağış",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Ortak_Bagislar();
                      }));
                    },
                  ),
                  
                ],
              ),
              ExpansionTile(
                leading: CircleAvatar(child: Icon(Icons.card_giftcard),),
                backgroundColor: Colors.grey[300],
                title: Text(
                  "Ödüller",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  ListTile(
                leading: CircleAvatar(child: Icon(Icons.control_point_duplicate),),
                    contentPadding: EdgeInsets.only(left: 48),
                    title: Text(
                      "Puanlarım",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PuanGecmisi();
                      }));
                    },
                  ),
                  ListTile(
                leading: CircleAvatar(child: Icon(Icons.copyright),),
                    contentPadding: EdgeInsets.only(left: 48),
                    title: Text(
                      "Markalar",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Markalarimiz();
                      }));
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Icon(Icons.card_membership),),
                    contentPadding: EdgeInsets.only(left: 48),
                    title: Text(
                      "Hediye Seç",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Hediyeler();
                      }));
                      }
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(flex: 7, child: Container(
              child: Center(child: Text("Kuveyt Türk Anasayfa")),
            )),
          ],
        ));
  }
}

class Profilim extends StatefulWidget {
  @override
  _ProfilimState createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = new TabController(length: 2, vsync: this);
    return Scaffold(
      bottomNavigationBar: Material(
        color: Colors.teal,
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text(
                "Profil",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "Sosyal",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(),
      body: TabBarView(controller: _tabController, children: [
        Column(
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      child: Icon(Icons.person, size: 125,),
                      radius: 70,
                      backgroundColor: Colors.white30,
                    ),
                  ),
                  color: Colors.teal,
                )),
            Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  adSoyad,
                  style: TextStyle(fontSize: 24),
                ))),
            Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  "IBAN:  " + acList["value"][0]["iban"],
                  style: TextStyle(fontSize: 18),
                ))),
            Flexible(
              flex: 2,
              child: ListView.builder(
                
                scrollDirection: Axis.horizontal,
                itemCount: acList["value"][0].length,
                itemBuilder: (context, index){
                  return Container(
                    width: 250,
                    height: 50,
                    child: Card(
                      child: ListTile(
                        title: Text(acList["value"][index]["iban"], style: TextStyle(fontSize: 18),),
                        subtitle: Text(acList["value"][index]["balance"].toString() + "TL"),
                      ),
                    ),
                  );
                }
                
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Card(
                    child: ListTile(
                  title: TextField(),
                  trailing: Icon(Icons.search),
                ))),
            Container(
              child: Text("Arkadaşlar"),
              padding: EdgeInsets.all(12),
            ),
            Flexible(
              flex: 6,
              child: GridView.builder(
                itemCount: arkadasList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.0),
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person, size: 30,),),
                      title: Text(arkadasList[index].isim + arkadasList[index].soyisim),
                      subtitle: Text(arkadasList[index].iban),
                    ),
                  );
                } 
                
              ),
            ),
            Container(
              child: Text("Önerilenler"),
              padding: EdgeInsets.all(16),
            ),
            Flexible(
              flex: 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index){
                  return Container(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person, size: 30,),),
                        title: Text(nonFriendList[index].isim + nonFriendList[index].soyisim),
                        subtitle: Text(nonFriendList[index].iban),
                      ),
                    ),
                  );
                } 
                
              ),
            )
          ],
        )
      ]),
    );
  }
}

class ParaTransferListesi extends StatefulWidget {
  @override
  _ParaTransferListesiState createState() => _ParaTransferListesiState();
}

class _ParaTransferListesiState extends State<ParaTransferListesi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Flexible(
              flex: 2,
              child: Card(
                  child: ListTile(
                title: TextField(),
                trailing: Icon(Icons.search),
              ))),
              Flexible(
              flex: 8,
              child: GridView.builder(
                itemCount: arkadasList.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.0),
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.person, size: 30,),),
                      title: Text(arkadasList[index].isim + arkadasList[index].soyisim),
                      subtitle: Text(arkadasList[index].iban),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ParaTransfer(
                              usr: Kullanici(
                                  isim: arkadasList[index].isim ,
                                  soyisim: arkadasList[index].soyisim,
                                  iban: arkadasList[index].iban));
                        }));
                      }
                    ),
                  );
                } 
                
              ),
            ),
        ]
        )
        );
  }
}

class ParaTransfer extends StatefulWidget {
  @override
  Kullanici usr;

  ParaTransfer({this.usr});
  _ParaTransferState createState() => _ParaTransferState();
}

double miktar;

class _ParaTransferState extends State<ParaTransfer> {
  TextEditingController editTextField = new TextEditingController();
  @override
  void initState() {
    miktar = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      child: Icon(Icons.person, size: 125,),
                      radius: 70,
                      backgroundColor: Colors.white30,
                    ),
                  ),
                  color: Colors.teal,
                )),
            Flexible(
                flex: 1,
                child: Center(
                    child: Text(
                  widget.usr.isim + " " + widget.usr.soyisim,
                  style: TextStyle(fontSize: 24),
                ))),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Card(child: Text(widget.usr.iban)),
                )),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ListTile(
                          leading: Text("Tutar"),
                          subtitle: Text("TL"),
                          title: Text(miktar.toString()),
                          trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return Dialog(
                                        child: Container(
                                      width: 200,
                                      child: ListTile(
                                        title: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: editTextField,
                                          onEditingComplete: () {
                                            if (editTextField.text != "") {
                                              setState(() {
                                                miktar = double.parse(
                                                    editTextField.text);
                                              });
                                            }
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.done),
                                          onPressed: () {
                                            print(editTextField.text);
                                            if (editTextField.text != "") {
                                              setState(() {
                                                miktar = double.parse(
                                                    editTextField.text);
                                              });
                                            }
                                            Navigator.of(context).pop();
                                            editTextField.clear();
                                          },
                                        ),
                                      ),
                                    ));
                                  },
                                );
                              }))),
                )),
            Spacer(),
            Flexible(
              flex: 1,
              child: Container(
                  child: FloatingActionButton.extended(
                icon: Icon(Icons.send),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                label: Text("Gönder",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                backgroundColor: miktar != 0 ? Colors.teal : Colors.grey,
                onPressed: miktar != 0
                    ? () {
                      
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Text("Para Transferi Onayı"),
                                content: Text(widget.usr.isim +
                                    " " +
                                    widget.usr.soyisim +
                                    " Kullanıcısına " +
                                    miktar.toString() +
                                    "TL para transferini onaylıyor musunuz?"),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: Text(
                                      "İptal",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.teal,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  MaterialButton(
                                    child: Text("Evet",
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.teal,
                                    onPressed: () async{
                                      moneyTransfer(arkadasList[0], 100);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    : null,
              )),
            )
          ],
        ));
  }
}

class OrtakOdeme extends StatefulWidget {
  @override
  _OrtakOdemeState createState() => _OrtakOdemeState();
}

List<Kullanici> ortakOdemeList = [
  Kullanici(isim: "isim", soyisim: "soyisim", iban: "TR1")
];
double ortak_odeme_hesap = 0;

class _OrtakOdemeState extends State<OrtakOdeme> {
  TextEditingController tController = TextEditingController();

  @override
  void initState() {
    tController.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)))),
                      style: TextStyle(fontSize: 56),
                      keyboardType: TextInputType.number,
                      controller: tController,
                      onChanged: (value) {
                        setState(() {
                          ortak_odeme_hesap = double.parse(value);
                        });
                      },
                    ),
                  ),
                ),
                    Text("TL", style: TextStyle(fontSize: 48),)
              ],
            ),
          ),
          Flexible(
            flex: 7,
            child: ListView.builder(
              itemCount: ortakOdemeList == null ? 0 : ortakOdemeList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(ortakOdemeList[index].isim +
                        " " +
                        ortakOdemeList[index].soyisim),
                    subtitle: Text(ortakOdemeList[index].iban),
                    trailing: ortakOdemeList != null
                        ? Text((ortak_odeme_hesap / ortakOdemeList.length)
                                .toStringAsFixed(1) +
                            "TL")
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: null,
              label: Text("Kişiler" + " " + ortakOdemeList.length.toString()),
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OrtakOdemeArkadasEkle();
                }));
              },
            ),
            Spacer(),
            FloatingActionButton.extended(
              backgroundColor: Colors.teal,
              label: Text("Gönder"),
              icon: Icon(Icons.send),
              onPressed: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text("Ödeme Talepleri Gönderildi"),
                      content: Text(ortakOdemeList.length.toString() +
                          " Kişiye talep gönderildi"),
                      actions: <Widget>[
                        MaterialButton(
                          child: Text("Kapat"),
                          onPressed: () {
                            ortakOdemeList.clear();
                            ortakOdemeList.add(Kullanici(
                                isim: "isim", soyisim: "soyisim", iban: "TR1"));
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrtakOdemeArkadasEkle extends StatefulWidget {
  @override
  _OrtakOdemeArkadasEkleState createState() => _OrtakOdemeArkadasEkleState();
}

class _OrtakOdemeArkadasEkleState extends State<OrtakOdemeArkadasEkle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Arkadaş Seç"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 8,
                child: ListView.builder(
                  itemCount: arkadasList.length,
                  itemBuilder: (context, index) {
                    bool _value = (ortakOdemeList == null
                            ? false
                            : ortakOdemeList.contains(arkadasList[index]))
                        ? true
                        : false;
                    return Card(
                      child: ListTile(
                        title: Text(arkadasList[index].isim +
                            " " +
                            arkadasList[index].soyisim),
                        subtitle: Text(arkadasList[index].iban),
                        trailing: Checkbox(
                          // onChanged: (newVal){},
                          activeColor: Colors.teal,
                          value: _value,
                        ),
                        onTap: () {
                          setState(() {
                            _value = !_value;
                          });
                          if ((ortakOdemeList == null
                              ? false
                              : ortakOdemeList.contains(arkadasList[index]))) {
                            setState(() {
                              ortakOdemeList.remove(arkadasList[index]);
                            });
                          } else {
                            setState(() {
                              ortakOdemeList.add(arkadasList[index]);
                            });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Tamam" + " " + ortakOdemeList.length.toString()),
          icon: Icon(Icons.done),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }
}

class OrtakBagis extends StatefulWidget {
  @override
  _OrtakBagisState createState() => _OrtakBagisState();
}

double ortak_bagis_hesap = 0;
double toplam_bagis=0;
class _OrtakBagisState extends State<OrtakBagis> with TickerProviderStateMixin {
  TextEditingController bController = TextEditingController();
  TextEditingController bagis_baslik_Controller = TextEditingController();
  TextEditingController bagis_aciklama_Controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(),
      body:
        Column(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 100,
                            child: TextField(
                              controller: bagis_baslik_Controller,
                              decoration:
                                  InputDecoration(hintText: "Bağış Başlığı"),
                            )),
                        Container(
                            width: 100,
                            child: TextField(
                              controller: bagis_aciklama_Controller,
                              decoration:
                                  InputDecoration(hintText: "Bağış Açıklaması"),
                            )),
                            // Container(
                            // width: 100,
                            // child: TextField(
                            //   controller: timeController,
                            //   keyboardType: TextInputType.number,
                            //   decoration:
                            //       InputDecoration(hintText: "Süre"),
                            // )),
                      ],
                    ),
                    Container(
                      width: 150,
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)))),
                          style: TextStyle(fontSize: 56),
                          keyboardType: TextInputType.number,
                          controller: bController,
                          onChanged: (value) {
                            setState(() {
                              ortak_bagis_hesap = double.parse(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Text("TL", style: TextStyle(fontSize: 48),)
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: ListView.builder(
                itemCount: ortakOdemeList == null ? 0 : ortakOdemeList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(ortakOdemeList[index].isim +
                          " " +
                          ortakOdemeList[index].soyisim),
                      subtitle: Text(ortakOdemeList[index].iban),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: null,
              label: Text("Kişiler" + " " + ortakOdemeList.length.toString()),
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OrtakOdemeArkadasEkle();
                }));
              },
            ),
            Spacer(),
            FloatingActionButton.extended(
              backgroundColor: Colors.teal,
              label: Text("Gönder"),
              icon: Icon(Icons.send),
              onPressed: () {
                
                Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DemoScreen(Bagis(bagisTuru: bagis_baslik_Controller.text ,aciklama: bagis_aciklama_Controller.text, saniye: 30,tutar: double.parse(bController.text)),);
                        }));
                
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DemoScreen extends StatefulWidget {
  @override
  Bagis bagis;
  DemoScreen(this.bagis);
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {

  @override
  void initState() {
    startTimer();
    super.initState();
  }
      Random rnd = Random();
    List bagis_fiyat_List = [];
    int digit;
    
  Timer _timer;
      int _start = 9;
  void startTimer() {
        const oneSec = const Duration(seconds: 3);
        _timer = new Timer.periodic(
            oneSec,
            (Timer timer) => setState(() {
 
                  if (_start < 1) {
                    setState(() {
      
                      widget.bagis.toplanan_tutar = toplam_bagis;
                      bagisList.add(widget.bagis);
                    });
                    timer.cancel();

                  } else {
                    _start = _start - 3;
                                              double bagis = (rnd.nextDouble() * (pow(10, digit-1)));
              toplam_bagis += bagis;
      
              bagis_fiyat_List.add(bagis); 
                  }
      
                }));
      }
  @override
  Widget build(BuildContext context) {
    String temp = (ortak_bagis_hesap.toInt() / 10).toInt().toString();
    
    digit = (ortak_bagis_hesap.toInt() / 10).toInt().toString().length;
    
      

      

      @override
      void dispose() {
        _timer.cancel();
        super.dispose();
      }
    return Scaffold(
      appBar: AppBar(title: Text(widget.bagis.bagisTuru),),
      body: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Text("Kişiler Tarafından Yapılan Bağışlar", style: TextStyle(fontSize: 24),),
                          ),
                          Flexible(
                            flex: 7,
                            child: ListView.builder(
                                itemCount: bagis_fiyat_List == null
                                    ? 0
                                    : bagis_fiyat_List.length,
                                itemBuilder: (context, index) {
                                   


                                  return Card(
                                    child: ListTile(
                                      title: Text(ortakOdemeList[index].isim +
                                          " " +
                                          ortakOdemeList[index].soyisim),
                                      subtitle:
                                          Text(ortakOdemeList[index].iban),
                                      trailing: ortakOdemeList != null
                                          ? Text(
                                              (bagis_fiyat_List[index]).toStringAsFixed(1) + "TL")
                                          : null,
                                    ),
                                  );
                                },
                              ),
                          ),
                          Flexible(flex: 3, child: Text("Toplam " + toplam_bagis.toStringAsFixed(1) + "TL Toplandı"),),
                          Flexible(
                            flex: 1,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              color: Colors.teal,
                              child: Text("Kapat",style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                ortakOdemeList.clear();
                                ortak_bagis_hesap = 0;
                                toplam_bagis = 0;
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
    );
  }
}

List<Bagis> bagisList = [
  Bagis(bagisTuru: " ",
    aciklama: " ",
    saniye: 30,
    tutar: 300,
    toplanan_tutar: 250,
    
  )

]; 

class Bagis{
  String bagisTuru;
  String aciklama;
  int saniye;
  double tutar;
  double toplanan_tutar;

  Bagis({this.bagisTuru, this.aciklama, this.saniye, this.tutar, this.toplanan_tutar});
}

class Ortak_Bagislar extends StatefulWidget {
  @override
  _Ortak_BagislarState createState() => _Ortak_BagislarState();
}

class _Ortak_BagislarState extends State<Ortak_Bagislar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 20,
            child: GridView.count(
                      crossAxisCount: 6,
                      children: <Widget>[
                        Text("Sıra"),
                        Text("bagisTuru"),
                        Text("aciklama"),
                        Text("tutar"),
                        Text("toplanan"),
                        Text("bagis_durum"),
                      ],
                    ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
              itemCount: bagisList == null ? 0 : bagisList.length,
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.all(12),
                  height: 50,
                  child: GridView.count(
                    crossAxisCount: 6,
                    children: <Widget>[
                      Text(index.toString()),
                      Text(bagisList[index].bagisTuru),
                      Text(bagisList[index].aciklama),
                      Text(bagisList[index].tutar.toString()),
                      Text(bagisList[index].toplanan_tutar.toStringAsFixed(2)),
                      Text(bagisList[index].toplanan_tutar >= bagisList[index].tutar  ? "Tamamlandı" : "Tamamlanmadı"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // icon: Icon(icon: Icons.add),
        label: Text("Yeni Bağış"),
        onPressed: (){
          Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return OrtakBagis();
                        }));
        },
      ),
      );
      
  }
}

class Markalarimiz extends StatefulWidget {
  @override
  _MarkalarimizState createState() => _MarkalarimizState();
}

List<Marka> markaList = [];

class _MarkalarimizState extends State<Markalarimiz> {
  void addMarka(int count){
    Random rn = Random();
    for (var i = 0; i < count; i++) {
      markaList.add(Marka(isim: 'Marka #$i', komisyon: rn.nextDouble()));
    }
  }
@override
  void initState() {
    addMarka(20);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Markalarımız'),),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: ListView.builder(
              itemCount: markaList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Text(markaList[index].isim),
                    title: Slider(
                      value: markaList[index].komisyon,
                    ),
                    trailing: Text("%" + (markaList[index].komisyon * 100).toStringAsFixed(0)),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class Hediyeler extends StatefulWidget {
  @override
  _HediyelerState createState() => _HediyelerState();
}

List<Hediye> hediyeList = [];

class _HediyelerState extends State<Hediyeler> {

  void addHediye(int count){
    Random rn = Random();
    for (var i = 0; i < count; i++) {
      hediyeList.add(Hediye(isim: 'Hediye #$i', puan: rn.nextInt(100)));
    }
  }
@override
  void initState() {
    addHediye(15);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hediyelerimiz'),),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: ListView.builder(
              itemCount: hediyeList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Text(hediyeList[index].isim),
                    trailing: Text(hediyeList[index].puan.toString() + " Puan"),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class PuanGecmisi extends StatefulWidget {
  @override
  _PuanGecmisiState createState() => _PuanGecmisiState();
}
List<Puan> puanList = [];

class _PuanGecmisiState extends State<PuanGecmisi> {

  void addPuan(int count){
      Random rn = Random();
      for (var i = 0; i < count; i++) {
        puanList.add(Puan(id: rn.nextInt(20), miktar: rn.nextInt(100)));
      }
    }
  @override
    void initState() {
      addPuan(15);
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Puan Geçmişi'),),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 9,
            child: ListView.builder(
              itemCount: puanList.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    leading: Text("Marka #"+ puanList[index].id.toString() + "'den "),
                    trailing: Text(puanList[index].miktar.toString() + " Puan"),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}

class Puan{
  int id;
  int miktar;

  Puan({this.id, this.miktar});
}

class Hediye{
  String isim;
  int puan;

  Hediye({this.isim, this.puan});
}

class Marka{
  String isim;
  double komisyon;

  Marka({this.isim, this.komisyon});
}
class Kullanici {
  String isim;
  String soyisim;
  String iban;

  Kullanici({this.isim, this.soyisim, this.iban});
}
