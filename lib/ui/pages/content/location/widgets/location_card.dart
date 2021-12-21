import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:red_blackboard/ui/widgets/card.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final double lat, long;
  final double? distance;
  final VoidCallback? onUpdate;
  final IconButton topLeftWidget;

  // PostCard constructor
  LocationCard(
      {Key? key,
      required this.title,
      required this.lat,
      required this.long,
      this.distance,
      this.onUpdate,
      required this.topLeftWidget})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters

  Widget topRightIconButton(Color primaryColor) {
    if (onUpdate != null) {
      return IconButton(
        icon: Icon(
          Icons.restart_alt_outlined,
          color: primaryColor,
        ),
        onPressed: onUpdate,
      );
    } else {
      return const SizedBox(
        height: 1,
        width: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("locationCard"),
      title: title,
      // topLeftWidget widget as an Icon
      topLeftWidget:
          Padding(padding: const EdgeInsets.all(24.0), child: topLeftWidget),
      // topRightWidget widget as an IconButton or null
      topRightWidget: topRightIconButton(primaryColor),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latitud:',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Longitud:',
                style: Theme.of(context).textTheme.headline3,
              ),
              if (distance != null)
                Text(
                  'Distancia:',
                  style: Theme.of(context).textTheme.headline3,
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$lat',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '$long',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              if (distance != null)
                Text(
                  '$distance Km',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
            ],
          ))
        ],
      ),
      /* extraContent: GridView.count(
        crossAxisCount: 2,
        children: [
          Center(
            child:
          ),

        ),


        ],
      ), */
    );
  }
}
