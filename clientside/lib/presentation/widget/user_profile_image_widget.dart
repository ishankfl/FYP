import 'package:bookme/constant/server.dart';
import 'package:flutter/material.dart';

class UserProfileImageCircleAvatar extends StatelessWidget {
  final String? profileUrl;

  const UserProfileImageCircleAvatar({Key? key, this.profileUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 30,
      // minRadius: 100,
      backgroundImage: NetworkImage(profileUrl != null
          ? ServerUrl.ipaddress() + profileUrl.toString().substring(1)
          : "https://th.bing.com/th/id/R.e94860c29ac0062dfe773f10b3ce45bf?rik=SCqlsHg1S8oFDA&pid=ImgRaw&r=0"),
    );
  }
}
