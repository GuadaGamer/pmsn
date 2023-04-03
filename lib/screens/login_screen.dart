import 'package:flutter/material.dart';
import 'package:psmnn/firebase/firebase_emailauth.dart';
import 'package:psmnn/responsive.dart';
import 'package:psmnn/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  EmailAuth emailAuth = EmailAuth();

  TextEditingController emailTxt = TextEditingController();
  TextEditingController passwordTxt = TextEditingController();

  final spaceHorizont = const SizedBox(height: 10);

  final btngoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google, onPressed: () {});
  final btnface = SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook, onPressed: () {});
  final btngit = SocialLoginButton(
      buttonType: SocialLoginButtonType.github, onPressed: () {});

  final imgLogo = Image.asset(
    'assets/itce.png',
    height: 200,
  );

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
      controller: emailTxt,
      decoration: const InputDecoration(
          label: Text('Email user'), border: OutlineInputBorder()),
    );
    final txtPass = TextFormField(
      controller: passwordTxt,
      obscureText: true,
      decoration: const InputDecoration(
          label: Text('Password user'), border: OutlineInputBorder()),
    );

    final btnEmail = SocialLoginButton(
        buttonType: SocialLoginButtonType.generalLogin,
        onPressed: () {
          isLoading = true;
          setState(() {});
          //Future.delayed(const Duration(milliseconds: 4000)).then((value) {
          emailAuth
              .signInWithEmailandPassword(
                  email: emailTxt.text, password: passwordTxt.text)
              .then((value) {
            if (value) {
              Navigator.pushNamed(context, '/dash');
            } else {
              final snackbar = SnackBar(
                content: const Text('Revisa los datos ingresados'),
                action: SnackBarAction(
                label: 'Undo',
                onPressed: () {},
                 ),
                 );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              //snackbar de error
            }
          });
          isLoading = false;
          setState(() {});
        });
    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            'Crear cuenta :)',
            style:
                TextStyle(fontSize: 18, decoration: TextDecoration.underline),
          )),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
          mobile: MobileSS(
            btnEmail: btnEmail,
            isLoading: isLoading,
            imgLogo: imgLogo,
            btnface: btnface,
            btngit: btngit,
            btngoogle: btngoogle,
            spaceHorizont: spaceHorizont,
            txtPass: txtPass,
            txtRegister: txtRegister,
            txtEmail: txtEmail,
          ),
          desktop: DesktopSs(
              imgLogo: imgLogo,
              txtEmail: txtEmail,
              spaceHorizont: spaceHorizont,
              txtPass: txtPass,
              btnEmail: btnEmail,
              btngit: btngit,
              btngoogle: btngoogle,
              btnface: btnface,
              txtRegister: txtRegister),
          tablet: TabledSS(
              imgLogo: imgLogo,
              txtEmail: txtEmail,
              spaceHorizont: spaceHorizont,
              txtPass: txtPass,
              btnEmail: btnEmail,
              btngit: btngit,
              btngoogle: btngoogle,
              btnface: btnface,
              txtRegister: txtRegister)),
    );
  }
}

class DesktopSs extends StatelessWidget {
  const DesktopSs({
    super.key,
    required this.imgLogo,
    required this.txtEmail,
    required this.spaceHorizont,
    required this.txtPass,
    required this.btnEmail,
    required this.btngit,
    required this.btngoogle,
    required this.btnface,
    required this.txtRegister,
  });

  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox spaceHorizont;
  final TextFormField txtPass;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btngit;
  final SocialLoginButton btngoogle;
  final SocialLoginButton btnface;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: .4,
              fit: BoxFit.cover,
              image: AssetImage('assets/fondo.webp'))),
      child: Row(
        children: [
          Expanded(child: imgLogo),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 450.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      txtEmail,
                      spaceHorizont,
                      txtPass,
                      spaceHorizont,
                      btnEmail,
                      spaceHorizont,
                      btngit,
                      spaceHorizont,
                      btngoogle,
                      spaceHorizont,
                      btnface,
                      spaceHorizont,
                      txtRegister
                    ],
                  ))
            ],
          )),
        ],
      ),
    );
  }
}

class TabledSS extends StatelessWidget {
  const TabledSS({
    super.key,
    required this.imgLogo,
    required this.txtEmail,
    required this.spaceHorizont,
    required this.txtPass,
    required this.btnEmail,
    required this.btngit,
    required this.btngoogle,
    required this.btnface,
    required this.txtRegister,
  });

  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox spaceHorizont;
  final TextFormField txtPass;
  final SocialLoginButton btnEmail;
  final SocialLoginButton btngit;
  final SocialLoginButton btngoogle;
  final SocialLoginButton btnface;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: .4,
              fit: BoxFit.cover,
              image: AssetImage('assets/fondo.webp'))),
      child: Row(
        children: [
          Expanded(child: imgLogo),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      txtEmail,
                      spaceHorizont,
                      txtPass,
                      spaceHorizont,
                      btnEmail,
                      spaceHorizont,
                      btngit,
                      spaceHorizont,
                      btngoogle,
                      spaceHorizont,
                      btnface,
                      spaceHorizont,
                      txtRegister
                    ],
                  ))
            ],
          )),
        ],
      ),
    );
  }
}

class MobileSS extends StatelessWidget {
  const MobileSS(
      {super.key,
      required this.btnEmail,
      required this.isLoading,
      required this.imgLogo,
      required this.txtEmail,
      required this.btnface,
      required this.btngit,
      required this.btngoogle,
      required this.spaceHorizont,
      required this.txtPass,
      required this.txtRegister});

  final SocialLoginButton btnEmail;
  final bool isLoading;
  final Image imgLogo;
  final TextFormField txtEmail;
  final SizedBox spaceHorizont;
  final TextFormField txtPass;
  final SocialLoginButton btngit;
  final SocialLoginButton btngoogle;
  final SocialLoginButton btnface;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .4,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/fondo.webp'))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    txtEmail,
                    spaceHorizont,
                    txtPass,
                    spaceHorizont,
                    btnEmail,
                    spaceHorizont,
                    btngoogle,
                    spaceHorizont,
                    btnface,
                    spaceHorizont,
                    btngit,
                    spaceHorizont,
                    txtRegister
                  ],
                ),
                Positioned(
                  top: 100,
                  child: imgLogo,
                )
              ],
            ),
          ),
        ),
        isLoading ? const LoadingModalWidget() : Container()
      ],
    );
  }
}
