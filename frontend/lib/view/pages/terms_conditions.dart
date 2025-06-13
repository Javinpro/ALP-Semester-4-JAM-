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
                    'Terms & Conditions',
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
                            '1. This App is intended for personal and non-commercial use only. You are fully responsible for any activity conducted under your account. You agree not to use the App for any unlawful purpose or in a way that may harm or infringe upon the rights of others.',
                            style: body1,
                          ),
                          Text(
                            '2. Users must provide accurate and up-to-date information during registration. You are responsible for maintaining the confidentiality of your account credentials. The developer is not liable for any loss or damage resulting from unauthorized use of your account.',
                            style: body1,
                          ),
                          Text(
                            '3. You are solely responsible for the content you upload in the Task Posting feature. It is strictly prohibited to post content that contains elements of hate speech, pornography, violence, copyright infringement, or anything illegal. We reserve the right to remove content deemed inappropriate without prior notice.',
                            style: body1,
                          ),
                          Text(
                            '4. Points are awarded as a form of appreciation for user participation in the Task Posting feature. Points have no monetary value and cannot be exchanged for cash or goods unless otherwise specified by the developer.',
                            style: body1,
                          ),
                          Text(
                            '5. Your personal data will be stored and used in accordance with our Privacy Policy. Photos taken to deactivate the alarm will not be permanently stored without the user’s explicit consent.',
                            style: body1,
                          ),
                          Text(
                            '6. The developer reserves the right to modify features, suspend, or permanently discontinue the service without prior notice. Users may not hold the developer liable for any losses resulting from such changes or service termination.',
                            style: body1,
                          ),
                          Text(
                            '7. The App is provided “as-is” without any warranty of any kind. The developer shall not be held liable for any direct, indirect, incidental, or consequential damages arising from the use of the App.',
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
                      child: const Text('Agree', style: headerblack),
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
