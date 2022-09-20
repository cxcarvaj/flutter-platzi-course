import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/ui/widgets/button_bar.dart';

import '../../model/user.dart';
import '../widgets/user_info.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  ProfileHeader({Key? key, required this.user});
  @override
  Widget build(BuildContext context) {
    //UserBloc userBloc;
    //userBloc = BlocProvider.of(context);

    final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          UserInfo(user),
          ButtonsBar()
        ],
      ),
    );
  }
}

// Widget showProfileData(AsyncSnapshot snapshot) {
//   if (!snapshot.hasData || snapshot.hasError) {
//     print('User is not logged in');
//     return Container(
//       margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
//       child: Column(
//         children: [
//           CircularProgressIndicator(),
//           Text("We couldn't load the info, please log in!"),
//         ],
//       ),
//     );
//   } else {
//     print('User has logged in');
//     // print(snapshot.data);
//     final user = UserModel(
//         name: snapshot.data.displayName,
//         email: snapshot.data.email,
//         photoURL: snapshot.data.photoURL);
//     final title = Text(
//       'Profile',
//       style: TextStyle(
//           fontFamily: 'Lato',
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 30.0),
//     );

//     return Container(
//       margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[title],
//           ),
//           UserInfo(user),
//           ButtonsBar()
//         ],
//       ),
//     );
//   }
// }
