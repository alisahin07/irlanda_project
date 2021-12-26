import 'package:flutter/material.dart';
import 'package:linkedin_clone/search/profile_company.dart';
import 'package:url_launcher/url_launcher.dart';

class AllWorkersWidget extends StatefulWidget {
  final String userID;
  final String userName;
  final String userEmail;

  final String phoneNumber;
  final String userImageUrl;

  const AllWorkersWidget(
      {required this.userID,
      required this.userName,
      required this.userEmail,
      required this.phoneNumber,
      required this.userImageUrl});
  @override
  _AllWorkersWidgetState createState() => _AllWorkersWidgetState();
}

class _AllWorkersWidgetState extends State<AllWorkersWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 25,
      color: Colors.white10,
      margin: EdgeInsets.symmetric(
        horizontal: 10, //yatay
        vertical: 6, //dikey
      ),
      child: ListTile(
        // ListTile tipik olarak bir metnin yanı sıra baştaki veya sondaki bir simgeyi içeren sabit yükseklikte tek satır.
        onTap: () {
          Navigator.pushReplacement(
              //Adından da anlaşılacağı gibi, açmaya çalıştığınız yeni sayfayı rota yığınındaki mevcut sayfayla değiştirir. Örneğin ikinci sayfadayken pushReplacement() yöntemini kullanın ve üçüncü sayfayı açın, geri tuşuna bastığınızda ilk sayfaya gidecek ve ikinci sayfayı atlayacaksınız.
              context,
              MaterialPageRoute(
                  //A modal route that replaces the entire screen with a platform-adaptive transition.
                  builder: (context) => ProfileScreen(
                      userID: widget
                          .userID))); // bir Login sayfasından doğru şifre ve kullanıcı adı ile giriş yapıp, yeni bir sayfaya gelen kullanıcının, (zaten giriş yapmış olduğu için) yeniden Login sayfasına gitmesini engellemek isteyebiliriz.İşte bu ve buna benzer durumlar için,Navigator.pushReplacement(…)
        },
        contentPadding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), //	contentPadding=desen iç dolgusu.
        leading: Container(
          //leading =Başlıktan önce görüntülenecek bir widget.
          padding: EdgeInsets.only(
              //EdgeInsets=  Tipik olarak bir kutunun dört tarafının her birinden bir ofset için kullanılır. Örneğin, bir kutunun içindeki dolgu bu sınıf kullanılarak temsil edilebilir. EdgeInsets sınıfı, ofsetleri görsel kenarlar, sol, üst, sağ ve alt olarak belirtir.
              right: 20), //Dekorasyonun içine yazılacak boş alan.
          decoration: BoxDecoration(
            //boxDecoration BoxDecoration, Container dediğimiz kutuları şekillendirmeye, boyamaya ve istenilen türde kutu yaratmaya yarayan dekorasyon aracıdır.
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: CircleAvatar(
            // circleavatar=Bir kullanıcıyı temsil eden bir daire. Tipik olarak bir kullanıcının profil resmiyle veya böyle bir resmin olmaması durumunda kullanıcının baş harfleriyle birlikte kullanılır.
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.network(
              widget.userImageUrl == null
                  ? 'https://previews.123rf.com/images/sevenozz/sevenozz2107/sevenozz210700012/171263560-gender-neutral-profile-avatar-front-view-of-an-anonymous-person-face.jpg'
                  : widget.userImageUrl,
            ),
          ),
        ),
        title: Text(
          widget.userName, //
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Visit Profile',
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
              style: (TextStyle(
                color: Colors.grey,
              )),
            ),
          ],
        ),
        trailing: IconButton(
          // Başlıktan sonra görüntülenecek bir widget. Tipik olarak bir Icon widget'ı.
          icon: Icon(
            Icons.mail_outline,
            size: 30,
            color: Colors.grey,
          ),
          onPressed: _mailTo,
        ),
      ),
    );
  }

  void _mailTo() async {
    var mailUrl = 'mainto: ${widget.userEmail}';
    print('widget.userEmail ${widget.userEmail}');
    if (await canLaunch(mailUrl)) {
      await launch(mailUrl);
    } else {
      print('Erorr');
      throw 'Erorr occured';
    }
  }
}
