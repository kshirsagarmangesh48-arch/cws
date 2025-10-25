import 'dart:async';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ForceUpdate {
  Future<bool> checkForUpdate() async {
    var versionNo = await retriveCurrentVersionNumber();
    if (versionNo != null) {
      bool isUpdate = false;
      try {
        if (await checkIfVersionHasChanged()) {
          final isForceUpdate = await checkIfForceUpdate();
          if (isForceUpdate) {
            isUpdate = true;
          }
        }
        return isUpdate;
      } on PlatformException catch (_) {
        return false;
      } catch (exception) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String?> retriveCurrentVersionNumber() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String buildNumber = packageInfo.buildNumber;
      return buildNumber;
    } on FormatException catch (_) {
      return null;
    }
  }

  Future<String?> retriveVersionNumberFromServer() async {
    final FirebaseRemoteConfig remoteConfig =
        FirebaseRemoteConfig.instance;
    return remoteConfig.getString('version_number');
  }

  Future<String?> retriveBuildNumberFromServer() async {
    try {
      final FirebaseRemoteConfig remoteConfig =
          FirebaseRemoteConfig.instance;
      int remoteVersionNo = 0;
      if (Platform.isAndroid) {
        remoteVersionNo =  remoteConfig.getInt('version_android');
      }
      if (Platform.isIOS) {
        remoteVersionNo =  remoteConfig.getInt('version_ios');
      }
      return remoteVersionNo.toString();
    } on FormatException catch (_) {
      return null;
    }
  }

  Future<String?> retriveCurrentVersionCodeNumber() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String versionNumber = packageInfo.version;
      return versionNumber;
    } on FormatException catch (_) {
      return null;
    }
  }

  Future<bool> checkIfVersionHasChanged() async {
    var versionNo = await retriveCurrentVersionNumber();
    if (versionNo != null) {
      int version = int.parse(versionNo);
      final FirebaseRemoteConfig remoteConfig =
          FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 60),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
      int remoteVersionNo = 0;
      if (Platform.isAndroid) {
        remoteVersionNo = remoteConfig.getInt('version_android');
      }
      if (Platform.isIOS) {
        remoteVersionNo = remoteConfig.getInt('version_ios');
      }
      return Future.value(remoteVersionNo > version);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> checkIfForceUpdate() async {
    final int currentVersionNo =
    int.parse(await retriveCurrentVersionNumber() ?? '0');
    final FirebaseRemoteConfig remoteConfig =
        FirebaseRemoteConfig.instance;

    final int minSupportedVersion =
        int.tryParse(remoteConfig.getString('minSupportedVersion'))??0;
    return currentVersionNo < minSupportedVersion;
  }

  void updateNow() {
    if (Platform.isAndroid) {
      launchAndroidAppStore();
    } else if (Platform.isIOS) {
      launchiOSAppStore();
    }
  }

  Future<void> setNormalUpdatePopUpDate({required String buildNo}) async {
    final SharedPreferences preferenceManager =
    await SharedPreferences.getInstance();

    preferenceManager.setString('build_skip_no', buildNo);
    preferenceManager.setString(
        'normal_update_time',
        DateTime.now()
            .add(
          const Duration(days: 7),
        )
            .toIso8601String());
  }

  Future<DateTime?> getNormalUpdatePopUpDate() async {
    final SharedPreferences preferenceManager =
    await SharedPreferences.getInstance();

    final response = preferenceManager.getString('normal_update_time');
    DateTime? normalUpdateDate;
    if (response != null) {
      normalUpdateDate = DateTime.parse(response);
    }
    return normalUpdateDate;
  }

  Future<String?> getSkipBuildNo() async {
    final SharedPreferences preferenceManager =
    await SharedPreferences.getInstance();
    final response = preferenceManager.getString('build_skip_no');
    String? buildSkipNo;
    if (response != null) {
      buildSkipNo = (response);
    }
    return buildSkipNo;
  }

  void launchAndroidAppStore() async {
    const url = 'market://details?id=com.lsinextgen.diverseyp';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      launchAndroidAppWebStore();
    }
  }

  void launchAndroidAppWebStore() async {
    const url = 'market://details?id=com.lsinextgen.diverseyp';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchiOSAppStore() async {
    String appUrl = 'https://apps.apple.com/app/6740776777';

    if (await canLaunchUrl(Uri.parse(appUrl))) {
      await launchUrl(Uri.parse(appUrl));
    } else {
      throw 'Could not launch $appUrl';
    }
  }

  Future<bool> isPopUpDateArrived() async {
    final normalUpdateDate = await getNormalUpdatePopUpDate();
    if (normalUpdateDate != null) {
      if (DateTime.now().isAfter(normalUpdateDate)) {
        return true;
      } else {
        final buildNo = await getSkipBuildNo();
        final serverBuildNo = await retriveBuildNumberFromServer();
        return buildNo != serverBuildNo;
      }
    } else {
      return true;
    }
  }
}
