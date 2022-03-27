import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPegawai() async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailController.text, password: "password");

        if (userCredential.user != null) {
          String? uid = userCredential.user?.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "uid": uid,
            "nip": nipController.text,
            "name": nameController.text,
            "email": emailController.text,
            "createdAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user?.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'weak-password') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Password yang digunakan terlalu singkat');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar(
              'Terjadi Kesalahan', 'Email yang digunakan sudah terdaftar.');
        }
      } catch (e) {
        print(e);
        Get.snackbar('Terjadi Kesalahan', 'Harap ulangi beberapa saat lagi.');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'NIP, Nama, dan Email harus diisi');
    }
  }
}
