import 'package:Rchain/api/route_manager.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class ApiServer {
  final Router _app;
  ApiServer() : _app = Router();

  Handler get _router => _app
    ..get(
        '/',
        (Request request) => Response.ok('<h1>Welcome to RAMA CHAIN</h1>',
            headers: {'Content-Type': 'text/html'}))
    ..mount('/api/', RouteManager().router);

  Handler get handler =>
      const Pipeline().addMiddleware(logRequests()).addHandler(_router);
}
