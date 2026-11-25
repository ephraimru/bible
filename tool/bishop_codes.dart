// Admin tool for "skip to Bishop" unlock codes.
//
//   Create the key pair (once):
//     dart run tool/bishop_codes.dart keygen <private-key-file>
//   Then put the printed public key in AppConfig.bishopUnlockPublicKey.
//
//   Make a code for a buyer (use the email of their Faith Mission account):
//     dart run tool/bishop_codes.dart sign <private-key-file> <email>
//
// Keep the private key file secret and backed up, and never commit it:
// anyone who has it can unlock Bishop for any account.
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:faith_mission_app/services/bishop_unlock.dart';

Future<void> main(List<String> args) async {
  if (args.length == 2 && args[0] == 'keygen') {
    await _keygen(args[1]);
  } else if (args.length == 3 && args[0] == 'sign') {
    await _sign(args[1], args[2]);
  } else {
    stderr.writeln('Usage:\n'
        '  dart run tool/bishop_codes.dart keygen <private-key-file>\n'
        '  dart run tool/bishop_codes.dart sign <private-key-file> <email>');
    exitCode = 64;
  }
}

Future<void> _keygen(String path) async {
  final file = File(path);
  if (file.existsSync()) {
    stderr.writeln('$path already exists; refusing to overwrite a key.');
    exitCode = 1;
    return;
  }
  final random = Random.secure();
  final seed = List<int>.generate(32, (_) => random.nextInt(256));
  final keyPair = await Ed25519().newKeyPairFromSeed(seed);
  final publicKey = await keyPair.extractPublicKey();
  file.writeAsStringSync('${base64.encode(seed)}\n');
  stdout.writeln('Private key written to $path (keep it secret).');
  stdout.writeln('Public key for AppConfig.bishopUnlockPublicKey:');
  stdout.writeln(base64.encode(publicKey.bytes));
}

Future<void> _sign(String keyPath, String email) async {
  final seed = base64.decode(File(keyPath).readAsStringSync().trim());
  if (seed.length != 32) {
    stderr.writeln('$keyPath is not a Faith Mission private key.');
    exitCode = 1;
    return;
  }
  final code = await BishopUnlock.sign(email, seed);
  if (!await BishopUnlock.verify(code, email)) {
    stderr.writeln('Warning: this key does not match the public key built '
        'into the app, so the app will reject this code.');
  }
  stdout.writeln(code);
}
