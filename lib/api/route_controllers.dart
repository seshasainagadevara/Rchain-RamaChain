import 'dart:convert';
import 'dart:io';

import 'package:Rchain/blockchain/blockcahin.dart';
import 'package:shelf/shelf.dart';

class RouteControllers {
  final Blockchain _blockchain;
  RouteControllers() : _blockchain = Blockchain();

//get blocks
  Response getBlocks(Request request) => Response.ok(_jsonBlocks);

//mine block
  Future<Response> mineBlock(Request request) async {
    if (request.headers['Content-Type'] == 'application/json') {
      try {
        var content = await utf8.decoder.bind(request.read()).join();
        var data = jsonDecode(content) as Map;
        _blockchain.addBlock(data);

        return Response.ok(_jsonBlocks);
      } catch (e) {
        stdout.writeln(e.toString());
        return Response.internalServerError();
      }
    }
    return Response.notFound('must send in json format ');
  }

  String get _jsonBlocks =>
      '${jsonEncode(_blockchain.blockchain.map((e) => e.toJson()).toList())}';
}
