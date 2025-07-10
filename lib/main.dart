import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyProject(),
    );
  }
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Tekrar"),
        backgroundColor: Colors.black45,
      ),
      body: TextFormFieldKullanimi(),
    );
  }
}

class TextFormFieldKullanimi extends StatefulWidget {
  const TextFormFieldKullanimi({super.key});

  @override
  State<TextFormFieldKullanimi> createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  late final String _email, _password, _userName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          //validate işlemini ne zaman çalıştıracağını belirler
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //TextEditingcontroller a ihtiyaç duymaz çünkü onSaved vardır
              TextFormField(
                onSaved:(gettingUserName) {
                  _userName = gettingUserName!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "onuralıcı",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle:  TextStyle(
                    color: Colors.red
                  ),
                  labelText: "Kullanıcı Adı",
                  hintText: "Username",
                  border: OutlineInputBorder()
                ),
                validator: (gettingUserName) {
                  if (gettingUserName!.isEmpty) {
                    return "Kullanıcı adı boş olmaz";
                  }
                  if (gettingUserName!.length < 5) {
                    return "5 karekterden az olamaz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                onSaved: (gettingEmail) {
                  _email = gettingEmail!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "onuralıcı",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle:  TextStyle(
                    color: Colors.red
                  ),
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder()
                ),
                validator: (gettingEmail) {
                  //if içerisine koyulan ünlem true dönmesinde false dönsün diye eklenir. Kütüphane eklemede bu ünleme dikkat edilmelidir. 
                  if (!EmailValidator.validate(gettingEmail!)) {
                    return "Geçerli bir mail giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                onSaved: (gettingPassword) {
                  _password = gettingPassword!;
                },
                //varsayılan değeri tanımlar
                //initialValue: "onuralıcı",
                decoration: InputDecoration(
                  //hata mesajlarının rengini değiştirir
                  errorStyle:  TextStyle(
                    color: Colors.red
                  ),
                  labelText: "Şifre",
                  hintText: "Password",
                  border: OutlineInputBorder()
                ),
                validator: (gettingPassword) {
                  if (gettingPassword!.isEmpty) {
                    return "Şifre boş olmaz";
                  }
                  if (gettingPassword!.length < 5) {
                    return "Şifre en az 6 karekterden oluşmalı";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 180,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    side: BorderSide(
                      color: Colors.teal.shade800, width: 1
                    ),
                    backgroundColor: Colors.teal.shade200,
                    foregroundColor: Colors.white
                  ),
                  onPressed: (){
                    //validate'in tamamladığını kontrol etmek için
                    bool _isValidate = _formKey.currentState!.validate();
                    if (_isValidate) {
                      //TextField den gelen verileri kaydetme işlemi
                      _formKey.currentState!.save();
                      String result = "Kullanıcı Adı: $_userName \nEmail: $_email \nŞifre: $_password";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.teal.shade100,
                          content: Text(result, style: TextStyle(
                            color: Colors.black
                          ),
                          ),
                        ),
                      );
                      //save işlemi olduktan sonra textField içeriğini temizler
                      _formKey.currentState!.reset();
                    }
                  }, 
                  child: Text("Kaydet")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidgetKullanimi extends StatefulWidget {
  const TextFieldWidgetKullanimi({super.key});

  @override
  State<TextFieldWidgetKullanimi> createState() => _TextFieldWidgetKullanimiState();
}

class _TextFieldWidgetKullanimiState extends State<TextFieldWidgetKullanimi> {

  late TextEditingController _emailController;
  late FocusNode _focusNode;
  int maxLineCount = 1;
  Color fillColor = Colors.grey.shade100;

  @override
  void initState() {
    super.initState(); //bir defaya mahsus bir initializedır. ilk bu kurulur. 
    //_emailController = TextEditingController(text: "onuralici3661@gmail.com");
    _emailController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener((){
      setState(() {
        maxLineCount = _focusNode.hasFocus ? 3 : 1;
        fillColor = _focusNode.hasFocus ? Colors.greenAccent.shade100 : Colors.grey.shade100; 
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose(); //bir sayfa kapandığında o sayfadaki kalıcı olan bilgileri siler
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextField(
            controller: _emailController,
            focusNode: _focusNode,
            maxLines: maxLineCount,
            //Açılacak olan klavye türü
            keyboardType: TextInputType.emailAddress,
            //Klavyedeki(Android) ana butonunun ne olacağı
            textInputAction: TextInputAction.done,
            //Seçili gelme olayı
            autofocus: true,
            //Satır sayısı
            //maxLines: 5,
            //Girilecek karakter sayısı (TC)
            //maxLength: 11,
            //İmleç rengi
            cursorColor: Colors.red,
            decoration: InputDecoration(
              //Kayan bilgi yazısı
              labelText: "Username",
              //İpucu
              hintText: "Kullanıcı adınızı giriniz",
              icon: Icon(Icons.add),
              //Sol tarafa eklenen icon
              prefix: Icon(Icons.person),
              //Sağ taraf iconu
              suffixIcon: Icon(Icons.cancel),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              //Arka plan rengi verme izni
              filled: true,
              fillColor: fillColor,
            ),
            //Klavye ile yapılan her değişikliği algılar
            onChanged: (String gelenDeger){
              
            },
            //Klavyedeki done tuşuna basınca çalışır ya da fiel dan çıkınca 
            onSubmitted: (String gelenDeger){

            },

          ),
        ),
        TextField(),
      ],
    );

  }
}

