import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'jobs/jobs_screen.dart';
import 'jobs/upload_job.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //StreamBuilder, kullanıcı tanımlı nesnelerin akışını widget'lara dönüştürebilen bir Widget'tır.   Herhangi bir UI güncellemesi varsa (kullanıcı etkileşiminden veya ağ güncellemelerinden kaynaklanmış olabilir) güncellenen bir Akışınız olduğunu varsayalım. "Ana" widget'ınız akışı dinleyen bir StreamBuilder içeriyorsa, durumlarınızı görünümlere çevirmekten sorumlu öğe olarak işlev görebilir.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('user is not logged  in yet');
            return Login();
          } else if (userSnapshot.hasData) {
            print('user is already logged in ');
            return JobScreen();
            return UploadJobNow();
          } else if (userSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('An error has been occured .Try again later'),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: Text('Something went wrong..'),
            ),
          );
        });
  }
}
