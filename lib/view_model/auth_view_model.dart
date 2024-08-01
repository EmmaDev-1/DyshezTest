import 'package:dyshez/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  final supabase = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signUp(String username, String email, String phone, String name,
      String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'name': name,
          'phone': phone,
        },
      );
      print("Usuario creado: ${response.user}");
    } catch (e) {
      if (e is AuthException) {
        print("Error de autenticación: $e");
        if (e.statusCode == 429 &&
            e.message.contains('Email rate limit exceeded')) {
          throw ('Límite de solicitudes excedido.');
        } else if (e.statusCode == 400 &&
            e.message.contains('already registered')) {
          throw ('El correo electrónico ya está registrado.');
        }
      }
      print("Error: $e");
      throw ('Tuvimos un problema al crear tu cuenta. Intenta de nuevo más tarde.');
    }
  }

  Future<void> signIn(String username, String password) async {
    try {
      // Imprimir los valores proporcionados para depuración
      print('Intentando iniciar sesión con:');
      print('Username: $username');
      print('Contraseña: $password');

      // Realizar una consulta a la tabla 'users' para obtener el email correspondiente al username
      final response = await supabase
          .from('users')
          .select('id, email')
          .eq('username', username)
          .single();

      // Imprimir la respuesta obtenida de la consulta
      print('Respuesta de la consulta: $response');

      // Extraer el email y el id de la respuesta
      final email = response['email'];
      final id = response['id'];

      // Imprimir el email y el id para verificación
      print('Email obtenido: $email');
      print('ID obtenido: $id');

      // Realizar la autenticación con el email obtenido y la contraseña proporcionada
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Actualizar el modelo de usuario y notificar a los listeners
      _user = UserModel(id: id, email: email);
      notifyListeners();

      // Imprimir mensaje de éxito
      print('Inicio de sesión exitoso');
    } catch (e) {
      // Manejar errores y lanzar una excepción con un mensaje adecuado
      print('Error durante el inicio de sesión: $e');
      throw Exception('Usuario no encontrado o contraseña incorrecta.');
    }
  }

  Future<AuthResponse> googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '442661194849-hskfij4gkepferunms1kb5i27kfmltau.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOut() async {
    // Cerrar sesión de Supabase
    await supabase.auth.signOut();
    // Cerrar sesión de Google
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> verifyToken(String email, String token) async {
    try {
      await supabase.auth.verifyOTP(
        email: email,
        token: token,
        type: OtpType.signup,
      );
    } catch (e) {
      print("Error de verificación: $e");
      throw ('Error al verificar el token.');
    }
  }

  Future<void> resendVerificationCode(String email) async {
    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );
    } catch (e) {
      print("Error al reenviar el código: $e");
      throw ('Error al reenviar el código de verificación.');
    }
  }

  Future<void> sendEmailforPasswordChange(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.dyshez://reset-password/',
      );
    } catch (e) {
      print('Error al enviar correo para restablecer contraseña: $e');
      throw ('Error al enviar correo');
    }
  }

  Future<void> resetPassword(String password) async {
    try {
      await supabase.auth.updateUser(UserAttributes(
        password: password,
      ));
    } on AuthException catch (e) {
      if (e.message.contains('same password')) {
        throw ('No puedes usar la misma contraseña que antes');
      } else if (e.message.contains('invalid password')) {
        throw ('Contraseña inválida');
      } else {
        throw ('Error al restablecer contraseña');
      }
    } catch (e) {
      throw ('Error al restablecer contraseña');
    }
  }
}
