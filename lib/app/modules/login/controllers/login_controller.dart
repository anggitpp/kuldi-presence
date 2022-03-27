import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuldi_presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
                title: 'Belum Verifikasi',
                middleText:
                    'Email yang digunakan belum terverifikasi, silahkan cek email anda untuk melakukan verifikasi.',
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar("Berhasil",
                            "Email verifikasi telah dikirim ulang ke email anda.");
                      } catch (e) {
                        Get.snackbar("Terjadi kesalahan",
                            "Tidak dapat mengirim email verifikasi. Silahkan hubungi admin.");
                      }
                    },
                    child: Text('KIRIM ULANG'),
                  ),
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);

        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Get.snackbar(
              'Terjadi kesalahan!', 'Email yang digunakan tidak terdaftar.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Terjadi kesalahan!', 'Email atau Password salah.');
        } else if (e.code == 'invalid-email') {
          Get.snackbar('Terjadi kesalahan!', 'Format email tidak valid.');
        }
      } catch (e) {
        Get.snackbar('Terjadi kesalahan!', 'Mohon mencoba beberapa saat lagi.');
      }
    } else {
      Get.snackbar('Terjadi kesalahan!', 'Email dan Password wajib diisi.');
    }
  }
}
