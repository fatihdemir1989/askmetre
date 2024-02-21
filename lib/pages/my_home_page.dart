import 'package:askmetre/views/app_bar_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:startapp_sdk/startapp.dart';

import '../others/ad_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// deneme açıklama ekledim

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController seninAdinText = TextEditingController();
  TextEditingController sevdigininAdiText = TextEditingController();
  List<String> seninAdinHarfleri = [], sevdigininAdiHarfleri = [];
  List<int> seninAdinSayilari = [], sevdigininAdiSayilari = [];
  int seninAdinSayisi = 0, sevdigininAdiSayisi = 0;
  String seninAdin = '';
  String sevdigininAdi = '';
  double sonuc1 = 0.0, sonuc2 = 0.0;
  String _sonuc = '';
  List<String> harfler = [
    "A",
    "B",
    "C",
    "Ç",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "İ",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "Ö",
    "P",
    "R",
    "S",
    "Ş",
    "T",
    "U",
    "Ü",
    "V",
    "Y",
    "Z"
  ];
  List<int> sayilar = [
    3,
    6,
    3,
    4,
    3,
    4,
    3,
    5,
    3,
    1,
    2,
    3,
    3,
    2,
    4,
    3,
    4,
    6,
    4,
    5,
    5,
    6,
    2,
    3,
    5,
    2,
    3,
    3
  ];
  BannerAd? _bannerAd;
  var startAppSdk = StartAppSdk();
  StartAppBannerAd? bannerAd;
  InterstitialAd? _interstitialAd;
  StartAppInterstitialAd? interstitialAdStartApp;
  int count = 0;
  late Orientation _orientation;

  @override
  void initState() {
    super.initState();
    transactions();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: OrientationBuilder(
        builder: (context, orientation) {
          _orientation = orientation;
          if (_orientation == Orientation.portrait) {
            return darMod(screenWidth, screenHeight);
          } else {
            return genisMod(screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  TextField buildSevdigininAdiTextFieldDarMod(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      controller: sevdigininAdiText,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp("[ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ]"))
      ],
      textAlign: TextAlign.left,
      //maxLength: 50,
      maxLines: 1,
      style: TextStyle(
          fontSize: _orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.05
              : MediaQuery.of(context).size.width * 0.02,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: MediaQuery.of(context).size.width * 0.075,
          color: Colors.pink,
        ),
        hintText: 'Sevdiğinin Adı',
        hintStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  TextField buildSeninAdinTextFieldDarMod(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      controller: seninAdinText,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp("[ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ]"))
      ],
      textAlign: TextAlign.left,
      //maxLength: 50,
      maxLines: 1,
      style: TextStyle(
          fontSize: _orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width * 0.05
              : MediaQuery.of(context).size.width * 0.02,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: MediaQuery.of(context).size.width * 0.075,
          color: Colors.pink,
        ),
        hintText: 'Senin Adın',
        hintStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  TextField buildSevdigininAdiTextFieldGenisMod(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      controller: sevdigininAdiText,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp("[ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ]"))
      ],
      textAlign: TextAlign.left,
      //maxLength: 50,
      maxLines: 1,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.025,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: MediaQuery.of(context).size.width * 0.035,
          color: Colors.pink,
        ),
        hintText: 'Sevdiğinin Adı',
        hintStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.025),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  TextField buildSeninAdinTextFieldGenisMod(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      controller: seninAdinText,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp("[ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ]"))
      ],
      textAlign: TextAlign.left,
      //maxLength: 50,
      maxLines: 1,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.025,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: MediaQuery.of(context).size.width * 0.035,
          color: Colors.pink,
        ),
        hintText: 'Senin Adın',
        hintStyle:
            TextStyle(fontSize: MediaQuery.of(context).size.width * 0.025),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void adSayilariHesapla(List gelenHarfleri, List gelenSayilari) {
    for (int i = 0; i < gelenHarfleri.length; i++) {
      for (int y = 0; y < harfler.length; y++) {
        if (harfler[y] == gelenHarfleri[i]) {
          gelenSayilari.add(sayilar[y]);
        }
      }
    }
  }

  void sonucAl() async {
    count++;
    if (count == 3) {
      await admobInterstitialLoad();
      if (_interstitialAd != null) {
        print('ADMOB REKLAM YÜKLENMİŞ');
        _interstitialAd!.show();
      } else {
        print('ADMOB REKLAM YÜKLENMEMİŞ');
      }
    } else if (count == 6) {
      await startAppInterstitialLoad();
      if (interstitialAdStartApp != null) {
        print(interstitialAdStartApp);
        await interstitialAdStartApp!.show().then((shown) {
          if (shown) {
            setState(() {
              print('STARTAPP REKLAM YÜKLENMİŞ');
              interstitialAdStartApp = null;
              startAppInterstitialLoad();
            });
          }
          return null;
        }).onError((error, stackTrace) {
          debugPrint("Geçiş reklamı Gösterirken Hata: $error");
        });
      } else {
        print('STARTAPP REKLAM YÜKLENMEMİŞ');
      }
    } else if (count > 6) {
      count = 0;
    }

    seninAdinHarfleri = seninAdin.split("");
    sevdigininAdiHarfleri = sevdigininAdi.split("");

    adSayilariHesapla(seninAdinHarfleri, seninAdinSayilari);
    adSayilariHesapla(sevdigininAdiHarfleri, sevdigininAdiSayilari);

    for (int i = 0; i < seninAdinSayilari.length; i++) {
      seninAdinSayisi += i;
    }

    for (int i = 0; i < sevdigininAdiSayilari.length; i++) {
      sevdigininAdiSayisi += i;
    }

    if (seninAdinSayisi < 10) {
      sonuc1 = seninAdinSayisi.toDouble();
    }
    if (seninAdinSayisi >= 10 && seninAdinSayisi < 20) {
      sonuc1 = (seninAdinSayisi / 2) * 10;
    }
    if (seninAdinSayisi >= 20 && seninAdinSayisi < 30) {
      sonuc1 = (seninAdinSayisi / 3) * 10;
    }
    if (seninAdinSayisi >= 30 && seninAdinSayisi < 40) {
      sonuc1 = (seninAdinSayisi / 4) * 10;
    }
    if (seninAdinSayisi >= 40 && seninAdinSayisi < 50) {
      sonuc1 = (seninAdinSayisi / 5) * 10;
    }

    if (sevdigininAdiSayisi < 10) {
      sonuc2 = sevdigininAdiSayisi.toDouble();
    }
    if (sevdigininAdiSayisi >= 10 && sevdigininAdiSayisi < 20) {
      sonuc2 = (sevdigininAdiSayisi / 2) * 10;
    }
    if (sevdigininAdiSayisi >= 20 && sevdigininAdiSayisi < 30) {
      sonuc2 = (sevdigininAdiSayisi / 3) * 10;
    }
    if (sevdigininAdiSayisi >= 30 && sevdigininAdiSayisi < 40) {
      sonuc2 = (sevdigininAdiSayisi / 4) * 10;
    }
    if (sevdigininAdiSayisi >= 40 && sevdigininAdiSayisi < 50) {
      sonuc2 = (sevdigininAdiSayisi / 5) * 10;
    }

    _sonuc = ('% ${((sonuc1 + sonuc2) / 2).round().toString()}');
    setState(() {});
  }

  void _showToast(BuildContext context, String toastmessage) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(toastmessage),
        action: SnackBarAction(
            label: 'Tamam', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void onIslemler() {
    seninAdinSayilari.clear();
    sevdigininAdiSayilari.clear();
    seninAdinSayisi = 0;
    sevdigininAdiSayisi = 0;
    seninAdinHarfleri.clear();
    sevdigininAdiHarfleri.clear();
    sonuc1 = 0;
    sonuc2 = 0;
    seninAdin = seninAdinText.text;
    sevdigininAdi = sevdigininAdiText.text;
  }

  Widget darMod(double screenWidth, double screenHeight) {
    _bannerAd?.dispose();
    _bannerAd?.load();
    return SafeArea(
      bottom: true,
      left: false,
      right: false,
      top: true,
      child: Container(
        height: screenHeight,
        color: Colors.pink.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.pink.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink.shade700,
                                  blurRadius: 10.0,
                                  spreadRadius: 3)
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.pink.shade100,
                                  Colors.pink.shade300,
                                  Colors.pink.shade200,
                                  Colors.pink.shade100,
                                ])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.01),
                              child: SizedBox(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.1,
                                child: const AppBarIcon(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.01),
                              child: Text(widget.title,
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: screenWidth * 0.09,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.01),
                              child: SizedBox(
                                height: screenHeight * 0.06,
                                width: screenWidth * 0.1,
                                child: const AppBarIcon(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        //height: screenHeight * 0.07,
                        width: screenWidth,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.06,
                                child: _bannerAd != null
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: SafeArea(
                                          child: SizedBox(
                                            width: _bannerAd!.size.width
                                                .toDouble(),
                                            height: _bannerAd!.size.height
                                                .toDouble(),
                                            child: AdWidget(ad: _bannerAd!),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: _bannerAd != null
                                            ? Text(
                                                'Lütfen bekleyiniz. Reklam yükleniyor',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04))
                                            : Text(
                                                'Hoş Geldiniz',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04),
                                              ),
                                      ), /*BannerInlinePage()*/
                              ),
                              // Text('Burası Reklam Alanı'),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.pink.shade700,
                                  blurRadius: 10.0,
                                  spreadRadius: 3)
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.topLeft,
                                colors: [
                                  Colors.pink.shade100,
                                  Colors.pink.shade300,
                                  Colors.pink.shade200,
                                  Colors.pink.shade100,
                                ])),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                _sonuc,
                                style: TextStyle(
                                    color: Colors.pink.shade900,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.08,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: buildSeninAdinTextFieldDarMod(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: buildSevdigininAdiTextFieldDarMod(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.pinkAccent.shade700)),
                              onPressed: () {
                                setState(() {
                                  onIslemler();
                                  seninAdin == '' || sevdigininAdi == ''
                                      ? _showToast(
                                          context, 'Boş alan bırakmayın')
                                      : sonucAl();
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Testi Başlat',
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.07,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.pink.shade200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: screenWidth,
                  //height: screenHeight * 0.065,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      bannerAd != null
                          ? StartAppBanner(bannerAd!)
                          : Text(
                              'Hoş Geldiniz',
                              style: TextStyle(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04),
                            ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget genisMod(double screenWidth, double screenHeight) {
    _bannerAd?.dispose();
    _bannerAd?.load();
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      top: false,
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.pink.shade200,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.pink.shade700,
                            blurRadius: 10.0,
                            spreadRadius: 3)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.pink.shade100,
                            Colors.pink.shade300,
                            Colors.pink.shade200,
                            Colors.pink.shade100,
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.1,
                            child: const AppBarIcon(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(widget.title,
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: screenHeight * 0.08,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: screenHeight * 0.1,
                            width: screenWidth * 0.1,
                            child: const AppBarIcon(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.17,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.12,
                            child: _bannerAd != null
                                ? Align(
                                    alignment: Alignment.center,
                                    child: SafeArea(
                                      child: SizedBox(
                                        width: _bannerAd!.size.width.toDouble(),
                                        height:
                                            _bannerAd!.size.height.toDouble(),
                                        child: AdWidget(ad: _bannerAd!),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: _bannerAd != null
                                        ? Text(
                                            'Lütfen bekleyiniz. Reklam yükleniyor',
                                            style: TextStyle(
                                                color: Colors.red.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03))
                                        : Text(
                                            'Hoş Geldiniz',
                                            style: TextStyle(
                                                color: Colors.red.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                  ),
                          ),
                          // Text('Burası Reklam Alanı'),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: screenWidth,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.pink.shade700,
                            blurRadius: 10.0,
                            spreadRadius: 3)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.pink.shade100,
                            Colors.pink.shade300,
                            Colors.pink.shade200,
                            Colors.pink.shade100,
                          ]),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            _sonuc,
                            style: TextStyle(
                                color: Colors.pink.shade900,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.46,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                      buildSeninAdinTextFieldGenisMod(context),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: buildSevdigininAdiTextFieldGenisMod(
                                      context),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.46,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    width: screenWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        bannerAd != null
                                            ? StartAppBanner(bannerAd!)
                                            : Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        screenWidth * 0.03),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.pinkAccent.shade700)),
                                    onPressed: () {
                                      setState(() {
                                        onIslemler();
                                        seninAdin == '' || sevdigininAdi == ''
                                            ? _showToast(
                                                context, 'Boş alan bırakmayın')
                                            : sonucAl();
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'Testi Başlat',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.03,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> admobInterstitialLoad() async {
    await InterstitialAd.load(
        adUnitId: AdHelper.admobInterstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) async {
                  ad.dispose();
                });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('Geçiş Reklamı Yüklenemedi Hatası: $error');
          },
        ));
    setState(() {});
  }

  Future<void> startAppInterstitialLoad() async {
    startAppSdk.setTestAdsEnabled(false);
    await startAppSdk.loadInterstitialAd().then((interstitialAds) {
      setState(() {
        interstitialAdStartApp = interstitialAds;
      });
    }).onError<StartAppException>((ex, stackTrace) {
      debugPrint("Geçiş reklamı yüklenirken hata oluştu: ${ex.message}");
    }).onError((error, stackTrace) {
      debugPrint("Geçiş reklamı yüklenirken hata oluştu: $error");
    });
    setState(() {});
  }

  Future<void> admobBannerLoadAndShow() async {
    await BannerAd(
      adUnitId: AdHelper.admobBannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(
              'Reklam yüklenemedi (Hata Kodu: ${error.code} Hata Mesajı: ${error.message})');
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
    /*setState(() {});*/
  }

  Future<void> startAppBannerAndShow() async {
    startAppSdk.setTestAdsEnabled(true);
    await startAppSdk.loadBannerAd(StartAppBannerType.BANNER).then((bannerAd) {
      setState(() {
        this.bannerAd = bannerAd;
      });
    }).onError<StartAppException>((ex, stackTrace) {
      print("Banner Reklam Yüklenirken Hata: ${ex.message}");
    }).onError((error, stackTrace) {
      print("Banner Reklam Yüklenirken Hata: $error");
    });
    setState(() {});
  }

  Future<void> transactions() async {
    await admobBannerLoadAndShow();
    await startAppBannerAndShow();
  }
}
