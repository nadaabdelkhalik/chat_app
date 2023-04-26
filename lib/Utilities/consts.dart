import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const kprimaryColor = Colors.deepPurple;
final ksecondaryColor = Colors.deepPurple[300];
FirebaseAuth firebaseInstance = FirebaseAuth.instance;
var currentUserId = firebaseInstance.currentUser?.uid ?? '';
String? imageURL;
