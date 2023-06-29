import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:particle_auth/particle_auth.dart';

class User {
  final String id;
  final String phone;
  final bool hasSetMasterPassword;
  final bool hasSetPaymentPassword;
  final String token;
  final String updatedAt;
  final String uuid;
  final List<Map<String, dynamic>> wallets;

  User({
    required this.id,
    required this.phone,
    required this.hasSetMasterPassword,
    required this.hasSetPaymentPassword,
    required this.token,
    required this.updatedAt,
    required this.uuid,
    required this.wallets,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      phone: json['phone'],
      hasSetMasterPassword: json['security_account']['has_set_master_password'],
      hasSetPaymentPassword: json['security_account']['has_set_payment_password'],
      token: json['token'],
      updatedAt: json['updated_at'],
      uuid: json['uuid'],
      wallets: List<Map<String, dynamic>>.from(json['wallets']),
    );
  }
}

class AuthLogic {
  static late ChainInfo currChainInfo;
  static User? currentUser;

  static void setChain() {
    currChainInfo = EthereumChain.goerli();
  }

  static void init(Env env) {
    const projectId = "664ff688-36ad-4b5c-945b-938be5f3902e";
    const clientK = "cQQNxlymxvOCt8Eku1BW5D6ZrHgroMBMg58rQBzJ";
    if (projectId.isEmpty || clientK.isEmpty) {
      throw const FormatException('You need to set project info, get your project id and client key from the dashboard.');
    }
    ParticleInfo.set(projectId, clientK);

    ParticleAuth.init(currChainInfo, env);
  }

  static String? evmPubAddress;
  static String? solPubAddress;
  static String? publicAddress;
  static String? chainName;

  static login() async {
    List<SupportAuthType> supportAuthType = <SupportAuthType>[];
    supportAuthType.add(SupportAuthType.google);
    supportAuthType.add(SupportAuthType.email);
    String result = await ParticleAuth.login(LoginType.phone, "", supportAuthType, socialLoginPrompt: SocialLoginPrompt.select_account);

    if (jsonDecode(result)["status"] == true || jsonDecode(result)["status"] == 1) {
      final userInfo = jsonDecode(result)["data"];
      currentUser = User.fromJson(userInfo);

      List<Map<String, dynamic>> wallets = (userInfo["wallets"] as List).map((dynamic e) => e as Map<String, dynamic>).toList();

      for (var element in wallets) {
      if (element["chain_name"] == "sol") {
        solPubAddress = element["public_address"]; 
      } else if (element["chain_name"] == "evm_chain") { 
        evmPubAddress = element["public_address"]; 
      }
    }

      if (solPubAddress != null) {
        publicAddress = solPubAddress;
        chainName = "Solana";
      } else if (evmPubAddress != null) {
        publicAddress = evmPubAddress;
        chainName = "Ethereum";
      } else {
        publicAddress = null;
        chainName = null;
      }

      print("login: $userInfo");
      print("publicAddress: $publicAddress");
      print("chainName: $chainName");
    } else {
      final error = RpcError.fromJson(jsonDecode(result)["data"]);
      print(error);
    }
  }

  static isLogin() async {
    bool result = await ParticleAuth.isLogin();
    showToast("isLogin: $result");
  }

  static Future<bool> isLoginAsync() async {
    String result = await ParticleAuth.isLoginAsync();
    print("isLoginAsync: $result");
    if (jsonDecode(result)["status"] == true || jsonDecode(result)["status"] == 1) {
      log("isLoginAsync: $result");
      return true;
    } else {
      print("isLoginAsync: $result");
      return false;
    }
  }

  static void getAddress() async {
    final address = await ParticleAuth.getAddress();
    print("getAddress: $address");
  }

  static void getUserInfo() async {
    final userInfo = await ParticleAuth.getUserInfo();
    print("getUserInfo: $userInfo");
  }

  static logout() async {
    String result = await ParticleAuth.logout();
    debugPrint("logout: $result");
  }
}
