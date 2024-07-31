import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:dyshez/view/pages/authentication_section/reset_password/verify_new_password.dart';
import 'package:dyshez/view/pages/authentication_section/login/login.dart';

class DeepLinkHandler extends StatefulWidget {
  const DeepLinkHandler({Key? key}) : super(key: key);

  @override
  _DeepLinkHandlerState createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    try {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          if (uri.scheme == 'io.supabase.dyshez' &&
              uri.host == 'reset-password') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VerifyNewPassPage(),
              ),
            );
          }
        }
      }, onError: (err) {
        // Manejar errores
      });
    } on PlatformException {
      // Manejar excepciones
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
