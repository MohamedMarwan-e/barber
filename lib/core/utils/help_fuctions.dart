import 'dart:developer';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';


/// Helper to handle URL launch failures
Future<void> _launchUrlWithFallback(Uri uri, {LaunchMode mode = LaunchMode.externalApplication}) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: mode);
  } else {
    log('Error: Cannot launch ${uri.toString()}');
  }
}

Future<void> launchInBrowser(String url) async {
  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}

Future<void> shareApp({required String text}) async {
  await Share.share(
      text ,
      subject: appName,
    );
}

/// Send WhatsApp message
Future<void> whatsAppMessage({required String text}) async {
  final Uri whatsappUri = Uri.parse('whatsapp://send?text=${Uri.encodeComponent(text)}');

  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri);
  } else {
    // await FlutterShareMe().shareToWhatsApp(msg: text);
    log('Error: can not open whatsapp');
  }
}

/// Launch custom URL with error handling
Future<void> launchCustomUrl(String? url) async {
  if (url != null) {
    final Uri uri = Uri.parse(url);
    await _launchUrlWithFallback(uri);
  } else {
    log('Error: URL is null');
  }
}

/// Make a phone call
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  await _launchUrlWithFallback(phoneUri);
}

/// Launch email with pre-filled subject and body
Future<void> launchEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {
      'subject': 'Hello',
      'body': 'Hi, there!',
    },
  );
  await _launchUrlWithFallback(emailUri);
}