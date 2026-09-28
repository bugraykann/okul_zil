import 'dart:convert';
import 'dart:io';

void main() {
  final base64Png =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=';
  final bytes = base64Decode(base64Png);
  File('assets/icons/app_icon.png').writeAsBytesSync(bytes);
}
