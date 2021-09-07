import 'package:Rchain/blockchain/block.dart';
import 'package:Rchain/encryption/encrypt.dart';

class Blockchain {
  final List<Block> _chain;

  Blockchain() : _chain = [Block.genesys()];

  Block addBlock(data) {
    var block = Block.mineBlock(previousBlock: _chain.last, data: data);
    _chain.add(block);
    return block;
  }

  bool isValidChain(List<Block> chain) {
    var chain_length = chain.length;

    for (var i = 1; i < chain_length; i++) {
      var present_block = chain[i];
      var previous_block = chain[i - 1];
      var previous_difficulty = previous_block.difficulty;

      if (present_block.previous_hash != previous_block.the_hash ||
          present_block.the_hash !=
              Encryption.hashIt(
                timeStamp: present_block.timeStamp,
                data: present_block.data,
                difficulty: present_block.difficulty,
                nonce: present_block.nonce,
                previous_hash: present_block.previous_hash,
              )) {
        return false;
      }

      if ((previous_difficulty - present_block.difficulty).abs() > 1) {
        return false;
      }
    }

    return true;
  }

  void replaceChain(List<Block> newChain) {
    if (newChain.length <= _chain.length) {
      print('Received new chain is not longer than existing chain');
      return;
    } else if (!isValidChain(newChain)) {
      print('Received chain is not valid');
      return;
    }
    print('New chain is valid so, replacing existing with new chain');
    _chain
      ..clear()
      ..addAll(newChain);
  }

  List<Block> get blockchain => _chain;
}
