import 'dart:convert';

import 'package:Rchain/encryption/hex_to_binary.dart';
import 'package:crypto/crypto.dart';

class Encryption {
  static String hashIt(
      {required timeStamp,
      required previous_hash,
      required data,
      required difficulty,
      required nonce}) {
    var hash = sha256
        .convert(utf8.encode('$timeStamp$previous_hash$data$difficulty$nonce'))
        .toString();

    // print(binary);

    return hash;
  }
}
