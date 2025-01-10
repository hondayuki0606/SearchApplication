import 'package:flutter/material.dart';

enum Flavor {
  DEVELOP,
  STAGING,
  PRODUCTION,
}

class Config {
  static Flavor environment = Flavor.DEVELOP;

  static String getString() {
    switch (environment) {
      case Flavor.DEVELOP:
        return "DEVELOP";
      case Flavor.STAGING:
        return "STAGING";
      case Flavor.PRODUCTION:
        return "PRODUCTION";
      default:
        return "環境エラー";
    }
  }
}