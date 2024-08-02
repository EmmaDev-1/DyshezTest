import 'package:dyshez/Utils/dialogs/reesend_email_dialog.dart';
import 'package:dyshez/Utils/dialogs/verify_email_dialog.dart';
import 'package:dyshez/Utils/timer/timer.dart';
import 'package:dyshez/view/components/Logo/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;
  const VerifyEmailPage({required this.email, Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  List<TextEditingController> textEditingControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              const LogoImageComponent(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              validationCode(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget validationCode(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Te hemos enviado un código de verificación",
            textAlign: TextAlign.center,
            style: TextStyle(
                letterSpacing: -1,
                wordSpacing: -1,
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontFamily: 'QuickSand-Bold',
                color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hemos enviado un código de verificación a tu email, por favor verifícalo e ingresalo.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 0,
                  wordSpacing: -1,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'QuickSand',
                  color: Colors.black),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.035),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return SizedBox(
                height: 48,
                width: 44,
                child: TextField(
                  controller: textEditingControllers[index],
                  autofocus: true,
                  showCursor: false,
                  readOnly: false,
                  onChanged: (value) async {
                    if (value.length == 1 && index < 5) {
                      FocusScope.of(context).nextFocus();
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                    if (index == 5) {
                      String token =
                          textEditingControllers.map((e) => e.text).join();
                      verifyAcount(context, token, widget.email);
                    }
                  },
                  style: Theme.of(context).textTheme.headline6,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.035),
          Text(
            "¿No te ha llegado ningún código de verificación?",
            style: TextStyle(
                letterSpacing: 0,
                wordSpacing: -1,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
                fontFamily: 'QuickSand',
                color: Colors.black),
          ),
          Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              return TextButton(
                onPressed: timerProvider.isButtonEnabled
                    ? () async {
                        timerProvider.resetTimer();
                        resendEmail(context, widget.email);
                      }
                    : null,
                child: Text(
                  "Solicitar nuevamente",
                  style: TextStyle(
                      letterSpacing: 0,
                      wordSpacing: -1,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: timerProvider.isButtonEnabled
                          ? FontWeight.bold
                          : FontWeight.w500,
                      fontFamily: 'QuickSand',
                      color: timerProvider.isButtonEnabled
                          ? const Color(0xFFE3026F)
                          : Colors.grey),
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(width: 5),
                  Text("${timerProvider.seconds} seg"),
                ],
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 199, 199, 199)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_searching_outlined),
                Text(
                  "¿Necesitas más ayuda? Contacta a soporte",
                  style: TextStyle(
                      letterSpacing: 0,
                      wordSpacing: -1,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'QuickSand',
                      color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
