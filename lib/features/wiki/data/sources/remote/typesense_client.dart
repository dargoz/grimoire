import 'package:typesense/typesense.dart';

class TypeSenseClient {
  late Client client;

  TypeSenseClient() {
    const host = 'typesense.apps.ocpdev.dti.co.id';
    const protocol = Protocol.https;
    final config = Configuration(
      // Replace with your configuration
      'Hu52dwsas2AdxdE',
      nodes: {
        Node(
          protocol,
          host,
        ),
      },
      numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
      connectionTimeout: const Duration(seconds: 2),
    );
    client = Client(config);
  }
}
