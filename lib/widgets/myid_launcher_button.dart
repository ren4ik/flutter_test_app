import 'package:flutter/material.dart';
import 'package:myid/myid.dart';

class MyIDLauncherButton extends StatelessWidget {
  final String sessionId;
  final String clientHash;
  final String clientHashId;

  const MyIDLauncherButton({
    super.key,
    required this.sessionId,
    required this.clientHash,
    required this.clientHashId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
          SnackBar(content: Text('MyID result: ${result.status}')),
        );
      },
      child: const Text('Start Verification'),
    );
  }
}
