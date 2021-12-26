import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/auth/register.dart';
import 'package:linkedin_clone/user_state.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //WidgetFlutterBinding, Flutter motoruyla etkileşim kurmak için kullanılır. Firebase.initializeApp(), Firebase'i başlatmak için yerel kodu çağırmalıdır ve eklentinin yerel kodu çağırmak için platform kanallarını kullanması gerektiğinden, bu eşzamansız olarak yapılır, bu nedenle bir örneğiniz olduğundan emin olmak için emineInitialized() öğesini çağırmanız gerekir.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inilization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Flutter'da FutureBuilder Widget'ı, bir Gelecekle etkileşimin en son anlık görüntüsüne dayalı olarak widget'lar oluşturmak için kullanılır. Future'ın durum değişikliği veya bağımlılıklardaki değişiklik yoluyla daha erken elde edilmesi gerekir. FutureBuilder, bazı eşzamansız işlevleri yürütmenize yardımcı olacak bir Widget'tır ve bu işlevin sonucuna göre kullanıcı arayüzünüz güncellenir. FutureBuilder doğası gereği Durum Bilgilidir, yani bizim StatefulWidgets'ta yaptığımız gibi kendi durumunu korur
        future: _inilization,
        builder: (context, snapshot) {
          //snapshot, FutureBuilder'ınızda dinlediğiniz Geleceğin veya Akışın sonucudur. Döndürülen verilerle etkileşime girmeden ve bunları oluşturucunuzda kullanmadan önce, önce ona erişmeniz gerekir.  FutureBuilder'ınız tarafından teknik olarak size dolaylı olarak iletilen bu verilere erişmek için FutureBuilder'dan istemeniz gerekir.   Bunu önce enstantane diyerek yaparsınız, çünkü tabiri caizse Flutter'a kullanacağınızı söylediğiniz lakap budur.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Center(
                    child: Text(
                        'App is being initialized'), // uygulama dabase'e baglanana kadar ne yazacaksa onu gösterir.
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Center(
                    child: Text('App is being initialized'),
                  ),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LinkedIn Clone',
            theme: ThemeData(
              //Temalar, herhangi bir uygulama için kullanıcı arayüzünün ayrılmaz bir parçasıdır. Temalar, bir uygulamanın yazı tiplerini ve renklerini tasarlamak ve daha şık hale getirmek için kullanılır. Flutter'da Tema widget'ı, bir uygulamaya tema eklemek için kullanılır. Düğmeler ve gezinme çubuğu gibi uygulamanın belirli bir bölümü için kullanabilir veya uygulamanın tamamında kullanmak için uygulamanın kök dizininde tanımlayabilirsiniz.
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors
                  .blue, //primarySwatch bir Renk değildir. Bu MaterialColor. Bu, bir malzeme uygulamasının kullanacağı rengin farklı tonları olduğu anlamına gelir.
            ),
            home: UserState(), //userstate
          );
        });
  }
}
