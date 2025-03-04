import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_color.dart';
import '../widgets/category_icon.dart';
import '../models/cat.dart';
import '../widgets/title_text.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key, required this.cat});

  final Cat cat;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final titleController = TextEditingController();

  int assetID = 0;
  int colorID = 0;
  bool active = false;

  void checkActive() {
    setState(() {
      active = titleController.text.isNotEmpty && assetID != 0 && colorID != 0;
    });
  }

  void onAsset(int value) {
    assetID = value;
    checkActive();
  }

  void onColor(int value) {
    colorID = value;
    checkActive();
  }

  void onEdit() {
    context.read<CategoryBloc>().add(
          EditCategory(
            cat: Cat(
              id: widget.cat.id,
              title: titleController.text,
              assetID: assetID,
              colorID: colorID,
            ),
          ),
        );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.cat.title;
    assetID = widget.cat.assetID;
    colorID = widget.cat.colorID;
    active = true;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        title: 'Edit category',
        right: Button(
          onPressed: () {},
          child: SvgWidget(Assets.delete),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TitleText('Type title for category'),
                SizedBox(height: 8),
                TxtField(
                  controller: titleController,
                  hintText: 'Ex: Transport',
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                SizedBox(height: 12),
                TitleText('Choose icon for category'),
                SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    CategoryIcon(
                      assetID: 1,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 2,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 3,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 4,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 5,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 6,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 7,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 8,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 9,
                      current: assetID,
                      colorID: colorID,
                      onPressed: onAsset,
                    ),
                    CategoryIcon(
                      assetID: 10,
                      colorID: colorID,
                      current: assetID,
                      onPressed: onAsset,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                TitleText('Choose color for category'),
                SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    CategoryColor(id: 1, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 2, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 3, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 4, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 5, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 6, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 7, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 8, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 9, colorID: colorID, onPressed: onColor),
                    CategoryColor(id: 10, colorID: colorID, onPressed: onColor),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 78 + MediaQuery.of(context).viewPadding.bottom,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: 10,
              left: 16,
              right: 16,
            ),
            color: colors.bg,
            child: MainButton(
              title: 'Edit category',
              active: active,
              onPressed: onEdit,
            ),
          ),
        ],
      ),
    );
  }
}
