import 'package:flutter/material.dart';
import 'package:tform/tform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/ui/widgets/select_image.dart';

class CustomPhotosWidget extends StatelessWidget {

  const CustomPhotosWidget({
    Key? key,
    required this.row,
  }) : super(key: key);

  final TFormRow row;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text(
              row.title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(80),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (row.state as List).length,
                itemBuilder: (context, index) {
                  return SelectImageView(
                    selected: (path) async {
                      row.state[index]["picurl"] = path;
                      print(path);
                    },
                  );
                },
            ),
          ),
        ],
      ),
    );
  }

}