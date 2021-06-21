import 'package:flutter/material.dart';
import 'package:vinto/data/blocs/location.dart';
import 'package:vinto/data/blocs/product/recommended.dart';
import 'package:vinto/utils/data/injection/get_it_config.dart';
import 'package:vinto/widgets/light_Text.dart';

final _location = getIt.get<LocationBloc>();

Widget locationPin() {
  return Row(
    children: [
      Image.asset(
        'assets/icons/Pin.png',
        height: 12,
      ),
      SizedBox(
        width: 10,
      ),
      StreamBuilder<LocationLoadingState>(
        stream: _location.locationStateStream,
        builder: (BuildContext context, snapshot) {
          var _ = _location.location;

          if (_.status == LoadingState.loading) {
            return Container();
          } else {
            return _.place.fold(
              (l) => TextButton.icon(
                  onPressed: () {
                    _location.initLocation();
                  },
                  icon: Icon(Icons.restart_alt_rounded),
                  label: Text("retry")),
              (r) => LightText(
                align: "left",
                size: 12.0,
                text: '${r.street}, ${r.name}',
              ),
            );
          }
        },
      ),
    ],
  );
}
