import 'package:flutter/material.dart';
import 'package:getstream_test_one/channel_screen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListScreen extends StatefulWidget {
  const ChannelListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChannelListScreen> createState() => _ChannelListScreenState();
}

class _ChannelListScreenState extends State<ChannelListScreen> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    channelStateSort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamChannelListView(
        controller: _listController,
        onChannelTap: (channel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return StreamChannel(
                  channel: channel,
                  child: const ChannelScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
