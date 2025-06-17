import 'package:flutter/material.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/pages/register.dart';
import 'package:jam/view/utils/text_template.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  sizedbox9,
                  Image.asset('assets/img/logo.png', height: 100, width: 100),
                  sizedbox9,
                  const Text(
                    'Syarat dan Ketentuan',
                    style: headerblack3,
                    textAlign: TextAlign.center,
                  ),
                  sizedbox1,
                  Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '1. Aplikasi ini ditujukan untuk penggunaan pribadi dan non-komersial saja. Anda bertanggung jawab penuh atas setiap aktivitas yang dilakukan di bawah akun Anda. Anda setuju untuk tidak menggunakan Aplikasi untuk tujuan melanggar hukum atau dengan cara yang dapat membahayakan atau melanggar hak orang lain.\n',
                            style: body1,
                          ),
                          Text(
                            '2. Pengguna harus memberikan informasi yang akurat dan terkini saat pendaftaran. Anda bertanggung jawab untuk menjaga kerahasiaan kredensial akun Anda. Pengembang tidak bertanggung jawab atas kerugian atau kerusakan yang diakibatkan oleh penggunaan akun Anda tanpa izin.\n',
                            style: body1,
                          ),
                          Text(
                            '3. Anda bertanggung jawab penuh atas konten yang Anda unggah dalam fitur Posting Tugas. Dilarang keras untuk mengunggah konten yang mengandung unsur ujaran kebencian, pornografi, kekerasan, pelanggaran hak cipta, atau hal-hal ilegal. Kami berhak menghapus konten yang dianggap tidak pantas tanpa pemberitahuan sebelumnya.\n',
                            style: body1,
                          ),
                          Text(
                            '4. Poin diberikan sebagai bentuk apresiasi atas partisipasi pengguna dalam fitur Posting Tugas. Poin tidak memiliki nilai moneter dan tidak dapat ditukar dengan uang tunai atau barang, kecuali ditentukan lain oleh pengembang.\n',
                            style: body1,
                          ),
                          Text(
                            '5. Data pribadi Anda akan disimpan dan digunakan sesuai dengan Kebijakan Privasi kami. Foto yang diambil untuk menonaktifkan alarm tidak akan disimpan secara permanen tanpa persetujuan eksplisit dari pengguna.\n',
                            style: body1,
                          ),
                          Text(
                            '6. Pengembang berhak untuk mengubah fitur, menangguhkan, atau menghentikan layanan secara permanen tanpa pemberitahuan sebelumnya. Pengguna tidak dapat menuntut pengembang atas kerugian yang diakibatkan oleh perubahan atau penghentian layanan tersebut.\n',
                            style: body1,
                          ),
                          Text(
                            '7. Aplikasi ini disediakan “sebagaimana adanya” tanpa jaminan dalam bentuk apa pun. Pengembang tidak bertanggung jawab atas kerugian langsung, tidak langsung, insidental, atau konsekuensial yang timbul dari penggunaan Aplikasi.\n',
                            style: body1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  sizedbox3,
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text('Setuju', style: headerblack),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
