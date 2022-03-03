import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:reksawaluya/routes/home/components/MenuBox/index.dart';

class PoliklinikView extends StatelessWidget {
  const PoliklinikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuBox(
                  text: 'Informasi\nPoliklinik',
                  icon: LineIcon.desktop(
                    size: 60,
                  )),
              const SizedBox(
                width: 20,
              ),
              MenuBox(
                  text: 'Update\nAntrian',
                  icon: LineIcon.desktop(
                    size: 60,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
