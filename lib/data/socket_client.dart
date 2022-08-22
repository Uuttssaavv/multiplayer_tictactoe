import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketClientProvider = Provider((_) => SocketClient());

class SocketClient {
  late final IO.Socket? socket;

  SocketClient() {
    socket = IO.io(
      'http://localhost:3000',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );
    socket!.connect();
  }
}
