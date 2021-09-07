import 'dart:convert';

import 'package:Rchain/api/route_controllers.dart';
import 'package:Rchain/blockchain/blockcahin.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RouteManager {
  final Router _app;
  final RouteControllers _routeControllers;

  RouteManager()
      : _app = Router(),
        _routeControllers = RouteControllers();

  Router get router => _app
    ..get('/blocks/', _routeControllers.getBlocks)
    ..post('/mine/', _routeControllers.mineBlock);
}
