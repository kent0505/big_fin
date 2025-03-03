import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/config/constants.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_color.dart';
import '../widgets/category_icon.dart';
import '../models/cat.dart';
import '../widgets/title_text.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, this.cat});

  static const routePath = '/CategoryScreen';

  final Cat? cat;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final titleController = TextEditingController();

  int assetID = 0;
  int colorID = 0;
  bool active = true;

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

  void onAdd() {
    final cat = Cat(
      id: widget.cat?.id ?? getTimestamp(),
      title: titleController.text,
      assetID: assetID,
      colorID: colorID,
    );
    context.read<CategoryBloc>().add(
          widget.cat == null ? AddCategory(cat: cat) : EditCategory(cat: cat),
        );
    Navigator.pop(context);
  }

  void onDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          title: 'Are you sure?',
          description: 'You won’t be able to undo this action.',
          leftTitle: 'Delete',
          rightTitle: 'Cancel',
          onYes: () {
            context.read<CategoryBloc>().add(DeleteCategory(cat: widget.cat!));
            context.pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.cat?.title ?? '';
    assetID = widget.cat?.assetID ?? 0;
    colorID = widget.cat?.colorID ?? 0;
    if (widget.cat == null) active = false;
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        title: widget.cat == null ? l.addCategory : l.editCategory,
        right: widget.cat == null
            ? null
            : Button(
                onPressed: onDelete,
                child: SvgWidget(
                  Assets.delete,
                  color: Colors.white,
                ),
              ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TitleText(l.typeTitle),
                SizedBox(height: 8),
                TxtField(
                  controller: titleController,
                  hintText: l.categoryHint,
                  onChanged: (_) {
                    checkActive();
                  },
                ),
                SizedBox(height: 12),
                TitleText(l.chooseIcon),
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
                TitleText(l.chooseColor),
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
              title: widget.cat == null ? l.addCategory : l.editCategory,
              active: active,
              onPressed: onAdd,
            ),
          ),
        ],
      ),
    );
  }
}
