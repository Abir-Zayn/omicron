import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


/*
  Summarize :
  the Environment class provides a structured way to manage and 
  access environment-specific configurations, 
  making it easier to handle different settings 
  for development and production builds.
*/

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiKey {
    return dotenv.env['API_KEY'] ?? 'API_KEY not found';
  }

  static String get baseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'BASE_URL not found';
  }

  static String get googleAPIKey {
    return dotenv.env['MAPS_API_KEY'] ?? 'MAPS_API_KEY not found';
  }
}
