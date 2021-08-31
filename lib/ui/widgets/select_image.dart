import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';

typedef SelectImage = Future Function(String path);

class SelectImageView extends StatefulWidget {

  const SelectImageView({
    Key? key,
    this.selected,
  }) : super(key: key);

  final SelectImage? selected;

  @override
  State<SelectImageView> createState() => _SelectImageViewState();
}

class _SelectImageViewState  extends State<SelectImageView> {

  final picker = ImagePicker();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        width: ScreenUtil().setWidth(90),
        margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
        color: Colors.grey[200],
        child:  imageUrl != null
          ? Image.file(File(imageUrl!),fit: BoxFit.cover,)
          : const SizedBox.shrink()
        ,
        /*
        Center(
          child: imageUrl != null
              ? Image.file(File(imageUrl!),fit: BoxFit.cover,)
              : const SizedBox.shrink(),
        ),*/
      ),
      onTap: () async {
        final source = await _showBottomSheet();
        if (null == source) return;
        final path = await _getImage(source);
        if (null == path) return;
        widget.selected!(path);
        setState(() {
          imageUrl = path;
        });
      },
    );
  }

  Future<ImageSource?> _showBottomSheet() async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: ScreenUtil().setHeight(160),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  S.of(context).takePhotosText,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context, ImageSource.camera);
                },
              ),
              ListTile(
                title: Text(
                  S.of(context).photoAlbumSelectText,
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Navigator.pop(context, ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text(
                  S.of(context).cancelText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> _getImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(source: source);
      return image?.path;
    } catch(e) {
      print('Pick image error: ${e.toString()}');
    }
    return null;
  }

}