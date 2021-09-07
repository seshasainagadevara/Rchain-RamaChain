import 'package:Rchain/blockchain/chain_constants.dart';
import 'package:Rchain/encryption/hex_to_binary.dart';
import 'package:meta/meta.dart';

import '../encryption/encrypt.dart';

@immutable
class Block {
  final timeStamp;
  final previous_hash;
  final the_hash;
  final data;
  final nonce;
  final difficulty;

  const Block(
      {required this.timeStamp,
      required this.the_hash,
      required this.data,
      required this.previous_hash,
      required this.difficulty,
      required this.nonce});

//creating genesys block with factory
  factory Block.genesys() => const Block(
      timeStamp: 00000000000000,
      the_hash: '0x2e20a0d030',
      data: [],
      previous_hash: '0000000000000',
      nonce: 0,
      difficulty: 3);

//creating / mining new block with factory
  factory Block.mineBlock({required Block previousBlock, required data}) {
    dynamic timeStamp, the_hash;
    var previous_hash = previousBlock.the_hash;
    var difficulty = previousBlock.difficulty;
    var nonce = 0;

    do {
      nonce++;
      timeStamp = DateTime.now().millisecondsSinceEpoch;
      difficulty = Block.difficultyTuner(
          original_block: previousBlock, time_stamp: timeStamp);
      the_hash = Encryption.hashIt(
        timeStamp: timeStamp,
        data: data,
        difficulty: difficulty,
        nonce: nonce,
        previous_hash: previous_hash,
      );
    } while ((HexToBinary(the_hash).hex_to_bin()).substring(0, difficulty) !=
        '0' * difficulty);

    return Block(
        timeStamp: timeStamp,
        the_hash: the_hash,
        data: data,
        nonce: nonce,
        difficulty: difficulty,
        previous_hash: previous_hash);
  }

  static int difficultyTuner(
      {required Block original_block, required time_stamp}) {
    var difficulty = original_block.difficulty;

    if (difficulty < 1) return 1;

    if ((time_stamp - original_block.timeStamp) > MINE_RATE) {
      return difficulty - 1;
    }
    return difficulty + 1;
  }

  Map<String, dynamic> toJson() => {
        'timeStamp': timeStamp,
        'the_hash': the_hash,
        'data': data,
        'previous_hash': previous_hash,
        'difficulty': difficulty,
        'nonce': nonce
      };

  @override
  String toString() => '''
   ===Block===
   Timetamp: $timeStamp,
   Previous Hash: $previous_hash,
   The Hash: $the_hash,
   The data: $data
  ''';
}
