import 'package:flutter/material.dart';
import 'package:myid/myid.dart';

class VerificationScreen extends StatelessWidget {
  final String sessionId;
  final String clientHash;
  final String clientHashId;

  const VerificationScreen({
    super.key,
    required this.sessionId,
    required this.clientHash,
    required this.clientHashId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await MyIdClient.start(
              config: MyIdConfig(
                sessionId: sessionId,
                clientHash: clientHash,
                clientHashId: clientHashId,
                environment: MyIdEnvironment.TESTING,
                entryType: MyIdEntryType.IDENTIFICATION,
              ),
              iosAppearance: MyIdIOSAppearance(),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('MyID result: ${result.status.name}')),
            );
          },
          child: const Text('Start MyID Verification'),
        ),
      ),
    );
  }
}
