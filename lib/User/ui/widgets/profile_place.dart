import 'package:flutter/material.dart';
import '../../../Place/model/place.dart';
import 'profile_place_info.dart';

class ProfilePlace extends StatelessWidget {
  Place place;

  ProfilePlace(this.place);

  @override
  Widget build(BuildContext context) {
    final photoCard = Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 70.0),
      height: 220.0,
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            place.urlImage,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                  child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ));
            },
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0))
          ]),
    );

    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: <Widget>[photoCard, ProfilePlaceInfo(place)],
    );
  }
}
