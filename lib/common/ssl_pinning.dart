// di lib/utils/ssl_pinning.dart
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SslPinning {
  static Future<IOClient> get ioClient async {
    final sslCert =
        await rootBundle.load('assets/certificates/certificates.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    final client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    print('SSL TRIGGERED ON SSL PINNING');
    return IOClient(client);
  }
}
