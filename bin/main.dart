import 'dart:io';

import 'package:Rchain/api/api_server.dart';
import 'package:Rchain/blockchain/blockcahin.dart';
import 'package:Rchain/blockchain/chain_constants.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> arguments) async {
  // final ApiServer api_server = ApiServer();
  // final HttpServer server = await serve(api_server.handler, HOST, PORT);
  // print('server running on ${server.port} at ${server.address}');

  var chain = Blockchain();
  chain.addBlock({'data': 'seshasai'});
  print('block last: ${chain.blockchain.last}');

  var prevTimeStamp, nextTimeStamp, nextBlock, timeDiff, average;

  final time = [];

  for (var i = 0; i < 10000; ++i) {
    prevTimeStamp = chain.blockchain.last.timeStamp;
    chain.addBlock({'data': 'block ${i}'});
    nextBlock = chain.blockchain.last;
    nextTimeStamp = nextBlock.timeStamp;
    timeDiff = nextTimeStamp - prevTimeStamp;
    time.add(timeDiff);
    average = time.reduce((value, element) => value + element) / time.length;
    print(
        'Time to mine the block: $timeDiff .ms --- Difficulty: ${nextBlock.difficulty} --- Average Time: $average .ms');
  }

  //   ..addBlock('hello man block 1')
  //   ..addBlock('helo block 2');

  // var chain2 = Blockchain()
  //   ..addBlock('block 3')
  //   ..addBlock('block 4')
  //   ..addBlock('block 5')
  //   ..addBlock('block 6');

  // var res = chain.isValidChain(chain.blockchain);
  // print(res);

  // chain.replaceChain(chain2.blockchain);
}
