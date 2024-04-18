import 'package:flutter/material.dart';
import 'package:getstream_test_one/channel_list_screen.dart';
import 'package:getstream_test_one/stream_keys.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = StreamChatClient(apiKey, logLevel: Level.INFO);

  final channel = client.channel('messaging');

  WidgetsFlutterBinding.ensureInitialized();

  await client.connectUser(User(id: 'broker-mindit'), userToken);
  await channel.watch();

  runApp(MyApp(
    client: client,
    channel: channel,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.client,
    required this.channel,
  });

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) {
          return StreamChat(
            client: client,
            child: widget,
          );
        },
        home: ChannelListScreen());
  }
}
