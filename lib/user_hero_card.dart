import 'package:flutter/material.dart';
import 'package:workshop_template/YOUR_CUSTOMIZATION_HERE/demo_data.dart';

class UserHeroCard extends StatelessWidget {
  final UserData userData;
  final bool isOnDetailedPage;

  const UserHeroCard(
      {Key? key, required this.userData, required this.isOnDetailedPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Theme.of(context).colorScheme.secondary;
    return Hero(
        tag: '${userData.key} ${userData.photoAsset}',
        child: Container(
          decoration: !isOnDetailedPage
              ? BoxDecoration(
                  border: Border.all(color: borderColor, width: 2.0),
                  borderRadius:
                      BorderRadius.circular(isOnDetailedPage ? 37.5 : 75))
              : null,
          height: isOnDetailedPage ? 75 : 150,
          width: isOnDetailedPage ? 75 : 150,
          child: CircleAvatar(
            backgroundImage: AssetImage(userData.photoAsset),
            backgroundColor: Colors.transparent,
          ),
        ));
  }
}
