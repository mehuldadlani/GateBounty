import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:particle_auth/particle_auth.dart';



class AuthLogic {
  static late ChainInfo currChainInfo;

  static void setChain() {
    currChainInfo = EthereumChain.goerli();
  }

  static void init(Env env) {
    // Get your project id and client from dashboard, https://dashboard.particle.network
    const projectId = "664ff688-36ad-4b5c-945b-938be5f3902e"; //772f7499-1d2e-40f4-8e2c-7b6dd47db9de
    const clientK = "cQQNxlymxvOCt8Eku1BW5D6ZrHgroMBMg58rQBzJ"; //ctWeIc2UBA6sYTKJknT9cu9LBikF00fbk1vmQjsV
    if (projectId.isEmpty || clientK.isEmpty) {
      throw const FormatException(
          'You need set project info, get your project id and client key from dashboard, https://dashboard.particle.network');
    }
    ParticleInfo.set(projectId, clientK);

    ParticleAuth.init(currChainInfo, env);
  }

  static String? evmPubAddress;
  static String? solPubAddress;

  static void login() async {
    List<SupportAuthType> supportAuthType = <SupportAuthType>[];
    supportAuthType.add(SupportAuthType.google);
    supportAuthType.add(SupportAuthType.email);
    String result = await ParticleAuth.login(
        LoginType.phone, "", supportAuthType,
        socialLoginPrompt: SocialLoginPrompt.select_account);

    if (jsonDecode(result)["status"] == true ||
        jsonDecode(result)["status"] == 1) {
      final userInfo = jsonDecode(result)["data"];
      List<Map<String, dynamic>> wallets = (userInfo["wallets"] as List)
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList();

      for (var element in wallets) {
        if (element["chainName"] == "solana") {
          solPubAddress = element["publicAddress"];
        } else if (element["chainName"] == "evm_chain") {
          evmPubAddress = element["publicAddress"];
        }
      }
      print("login: $userInfo");
      showToast("login: $userInfo");
    } else {
      final error = RpcError.fromJson(jsonDecode(result)["data"]);
      print(error);
      showToast("login: $error");
    }
  }

  static void isLogin() async {
    bool result = await ParticleAuth.isLogin();
    showToast("isLogin: $result");
    print("isLogin: $result");
  }

  static void isLoginAsync() async {
    String result = await ParticleAuth.isLoginAsync();
    print("isLoginAsync:$result");
    if (jsonDecode(result)["status"] == true ||
        jsonDecode(result)["status"] == 1) {
      log("isLoginAsync: $result");
      showToast("isLoginAsync: $result");
    } else {
      print("isLoginAsync: $result");
      showToast("isLoginAsync: $result");
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

  static void logout() async {
    String result = await ParticleAuth.logout();
    debugPrint("logout: $result");
    showToast("logout: $result");
  }



 
}
