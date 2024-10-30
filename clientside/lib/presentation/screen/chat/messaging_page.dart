// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Message {
  final String text;
  final bool isMe;

  Message(this.text, this.isMe);
}

class MyAppColors {
  static const Color myMessageBackground = Colors.blue;
  static const Color myMessageText = Colors.white;
  static const Color otherMessageBackground = Colors.grey;
  static const Color otherMessageText = Colors.black;
}

class ChatPage extends StatefulWidget {
  final int id;
  final int myId;
  final UserModel model;

  const ChatPage({
    super.key,
    required this.myId,
    required this.id,
    required this.model,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [Message('model', true)];
  final ScrollController _scrollController = ScrollController();

  late WebSocketChannel channel;
  late WebSocketChannel typingChannel;
  late StreamController<String> typingStreamController;
  late StreamController<String> channelStreamController;
  final FocusNode _loginFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    // Initialize the WebSocket channels in the initState method
    channel = WebSocketChannel.connect(
      Uri.parse(
          '${ServerUrl.websocketIp()}/ws/personalChat/${widget.myId}/${widget.id}/'),
    );
    typingChannel = WebSocketChannel.connect(
      Uri.parse(
          '${ServerUrl.websocketIp()}/ws/typingMessage/${widget.myId}/${widget.id}/'),
    );
    typingStreamController = StreamController<String>.broadcast();
    typingChannel.stream.listen((data) {
      typingStreamController.add(data);
    });
    channelStreamController = StreamController<String>.broadcast();
    channel.stream.listen((data) {
      channelStreamController.add(data);
    });

    _loginFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // print("Focus: " + _loginFocus.hasFocus.toString());
    if (_loginFocus.hasFocus == true) {
      typingChannel.sink.add("");
    } else {
      typingChannel.sink.add("userbacked");
    }
  }

  @override
  void dispose() {
    // typingChannel.sink.add("userbacked");
    channel.sink.close();
    typingChannel.sink.close();
    typingStreamController.close();
    channelStreamController.close();

    super.dispose();
  }

  void _sendMessage(WebSocketChannel channel) {
    String messageText = _messageController.text.trim();
    if (messageText == "") {
      return;
    }
    channel.sink.add('''{
      "message":"$messageText",
      "from":${widget.myId},
      "to":${widget.id}
    }''');
    _messageController.text = "";
  }

  Map stringtoJson(String data) {
    var deccpde = jsonDecode(data);

    return deccpde ?? {};
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    String token = getAccessToken(context);

    context
        .read<IndividualChatBloc>()
        .add(FetchIndividualChatEvent(token: token, toId: "${widget.id}"));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.primary_color_dark(),
        title: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImage(
                imagepath: widget.model.profile!,
                height: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldLabel(
                      colorr: Colors.white,
                      text: "Ishan",
                      padding: const EdgeInsets.all(0),
                      fontsize: 18),
                  StreamBuilder(
                      stream: typingStreamController.stream,
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        // print("typinggg stremaingggggggggg");

                        if (data != null) {
                          var json = stringtoJson(data);
                          dynamic usernameFrom = json['to'];

                          if (widget.myId == usernameFrom) {
                            return TextFieldLabel(
                              colorr: Colors.white,
                              // alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(0),
                              // text_align: TextAlign.end,
                              text: "typing..",
                            );
                          }
                        }
                        return Container();
                      })
                ],
              )
            ]),
        leadingWidth: 30,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            // typingStreamController.close();
            // channelStreamController.close();
            // print("back Pressed");

            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 15, top: 5),
        child: CustomTextFormField(
          // onTap: () {},
          focusNode: _loginFocus, 
                  onChanged: (value) {},
                  controller: _messageController,
          suffix: InkWell(
            child: Icon(Icons.send_rounded),
            onTap: () {
              _sendMessage(channel);

            },
          ),


          //         : const InputDecoration(
          //   hintText: 'Tydecorationpe your message...',
          // ),
            
          
          
        ),
      ),
      body: BlocBuilder<IndividualChatBloc, IndividualChatState>(
        builder: (context, state) {
          if (state is IndividualChatLoaded) {
            bool isMe = false;
            // print(model['username_from']);
            // print('$myId');

            for (int i = 0; i < state.chatModel.length; i++) {
              if (int.parse(state.chatModel[i].sender!) == widget.myId) {
                isMe = true;
              } else {
                isMe = false;
              }
              Message service = new Message(state.chatModel[i].message!, isMe);
              messages.add(service);
            }
            return GestureDetector(
              onTap: () {
                _loginFocus.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: channelStreamController.stream,
                        builder: (context, snapshot) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) => _scrollToBottom());

                          if (snapshot.data != null) {
                            var model = stringtoJson(snapshot.data!);

                            // print(model);
                            bool isMe = false;
                            // print(model['username_from']);
                            // print('${widget.myId}');
                            if (model['username_from'] == widget.myId) {
                              // print("statusssss");
                              isMe = true;
                            }
                            Message message = Message(model['message'], isMe);

                            messages.add(message);
                          }

                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              // print(messages[index].toString());
                              Message message = messages[index];
                              return message.isMe
                                  ? MyMessageWidget(message)
                                  : OtherMessageWidget(message);
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          }

          if (state is IndividualChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (state is IndividualChat) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          if (state is IndividualChatError) {
            ErrorFetchingData(
              message: "Error fetching data",
              btnName: "Retry",
              onPressed: () {
                context.read<IndividualChatBloc>().add(FetchIndividualChatEvent(
                    token: token, toId: "${widget.id}"));
              },
            );
          }
          // context
          //     .read<IndividualChatBloc>()
          //     .add(FetchIndividualChatEvent(token: token, toId: "$id"));
          return ErrorFetchingData(
            message: "",
            btnName: "Retry",
            onPressed: () {
              context.read<IndividualChatBloc>().add(
                  FetchIndividualChatEvent(token: token, toId: "${widget.id}"));
            },
          );
        },
      ),
    );
  }
}

class MyMessageWidget extends StatelessWidget {
  final Message message;

  MyMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: MyAppColors.myMessageBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: MyAppColors.myMessageText),
        ),
      ),
    );
  }
}

class OtherMessageWidget extends StatelessWidget {
  final Message message;

  OtherMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: MyAppColors.otherMessageBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: MyAppColors.otherMessageText),
        ),
      ),
    );
  }
}
