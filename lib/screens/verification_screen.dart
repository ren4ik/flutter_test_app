import 'package:flutter/material.dart';
import 'package:myid/myid.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  void startMyIdFlow(BuildContext context) async {
    final result = await MyIdClient.start(
      config: MyIdConfig(
        sessionId: 'demo-session-id',
        clientHash: 'client-hash',
        clientHashId: 'client-hash-id',
        environment: MyIdEnvironment.TESTING,
        entryType: MyIdEntryType.IDENTIFICATION,
      ),
      iosAppearance: MyIdIOSAppearance(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('MyID finished: ${result.status}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => startMyIdFlow(context),
          child: const Text('Start Verification'),
        ),
      ),
    );
  }
}
