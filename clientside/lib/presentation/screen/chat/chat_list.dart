import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/chat/messaging_page.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/presentation/widget/user_profile_image_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

class ChatUserList extends StatelessWidget {
  const ChatUserList({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<ChatUserListBloc>()
        .add(FetchChatUserListEvent(token: getAccessToken(context)));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(30, 120),
        child: Container(
          color: ColorConstant.primary_color_dark(),
          child: Column(
            children: [
              HomePageBottonAppBar("Chat"),
              Container(
                height: 45,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                // width: double.infinity,
                child: CustomTextFormField(
                  width: MediaQuery.of(context).size.width / 1.2,
                  borderDecoration: InputBorder.none,
                  filled: false,
                  textStyle: const TextStyle(fontSize: 15),
                  hintText: "Search Chat",
                  prefix: const Icon(Icons.search),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ChatUserListBloc, ChatUserListState>(
          builder: (context, state) {
            if (state is ChatUserListEmpty) {
              return ErrorFetchingData(message: "Nothing to read", btnName: "");
            }
            if (state is ChatUserListLoaded) {
              return _buildUserList(state.userModel, context);
            } else if (state is ChatUserListError) {
              return _buildError(context);
            } else if (state is ChatUserListLoading) {
              return _buildLoading();
            } else {
              // Handle other states or retry logic
              return _buildError(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserList(List<UserModel> users, BuildContext contextt) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, int index) {
        final user = users[index];
        return InkWell(
          child: _buildUserListItem(user, contextt),
          onTap: () {
            int myId = 0;
            FetchProfileState profileState =
                context.read<FetchProfileBloc>().state;
            if (profileState is FetchProfileLoadedState) {
              myId = profileState.userModel.id!;
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          model: user,
                          id: user.id!,
                          myId: myId,
                        )));
          },
        );
      },
    );
  }

  Widget _buildUserListItem(UserModel user, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                UserProfileImageCircleAvatar(
                  key: key,
                  profileUrl: user.profile,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLabel(
                        text: user.full_name!,
                        padding: EdgeInsets.all(0),
                      ),
                      TextFieldLabel(
                        text: "is this the last message",
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occurred while fetching data"),
          ElevatedButton(
            onPressed: () {
              context
                  .read<ChatUserListBloc>()
                  .add(FetchChatUserListEvent(token: getAccessToken(context)));
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }
}

HomePageBottonAppBar(String text) {
  return AppBar(
    backgroundColor: ColorConstant.primary_color_dark(),
    centerTitle: true,
    title: TextFieldLabel(
      padding: EdgeInsets.only(left: 10),
      // alignment: Alignment.center,
      text: text,
      colorr: Colors.white,
      fontsize: 20,
    ),
    actions: [
      PopupMenuButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem(
              child: Text('Option 1'),
              // Add your functionality for option 1
            ),
            PopupMenuItem(
              child: Text('Option 2'),
              // Add your functionality for option 2
            ),
            // Add more PopupMenuItems as needed
          ];
        },
      ),
    ],
  );
}
