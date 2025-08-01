import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';
import 'package:techbox/src/features/auth/verify_email/presentation/states/verify_email_state.dart';
import 'package:http/http.dart' as http;


class VerifyEmailController extends StateNotifier<VerifyEmailState>{


}