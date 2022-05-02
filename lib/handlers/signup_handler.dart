import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erx/screens/assistant_home_screen.dart';
import 'package:erx/screens/doctor_home_screen.dart';
import 'package:erx/screens/error_screen.dart';
import 'package:erx/screens/patient_home_screen.dart';
import 'package:erx/screens/pharmacist_home_screen.dart';
import 'package:erx/screens/signup_screen.dart';
import 'package:erx/widgets/customer_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpHandler extends StatelessWidget {
  const SignUpHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String _userType = Provider.of<SharedPreferences>(
      context,
      listen: false,
    ).getString("userType")!;
    final String _phoneNo = FirebaseAuth.instance.currentUser!.phoneNumber!;
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(_userType)
          .doc(_phoneNo)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.data() == null) {
            // Not yet signed-up
            return SignupScreen();
          } else {
            // Signed up
            // Todo: Check user type and route corresponding home screen
            if (_userType == "patient") {
              return PatientHomeScreen();
            } else if (_userType == "doctor") {
              return const DoctorHomeScreen();
            } else if (_userType == "assistant") {
              return const AssistantHomeScreen();
            } else if (_userType == "pharmacist") {
              return PharmacistHomeScreen();
            } else {
              return const ErrorScreen();
            }
          }
        } else {
          // Loading
          return const CustomLoader();
        }
      },
    );
  }
}
