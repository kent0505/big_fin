import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/info_dialog.dart';
import '../../../core/widgets/svg_widget.dart';

class IconScreen extends StatefulWidget {
  const IconScreen({super.key});

  static const routePath = '/IconScreen';

  @override
  State<IconScreen> createState() => _IconScreenState();
}

class _IconScreenState extends State<IconScreen> {
  String _iconName = 'icon1';

  void getIconName() async {
    try {
      _iconName = await FlutterDynamicIconPlus.alternateIconName ?? 'icon1';
    } catch (e) {
      logger(e);
    }
    setState(() {});
  }

  void showInfo() {
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) {
        return InfoDialog(title: l.notAvailable);
      },
    );
  }

  void setIcon(String iconName) async {
    try {
      if (await FlutterDynamicIconPlus.supportsAlternateIcons && isIOS()) {
        await FlutterDynamicIconPlus.setAlternateIconName(
          iconName: iconName,
          isSilent: true,
        );
        setState(() {
          _iconName = iconName;
        });
      } else {
        showInfo();
      }
    } catch (e) {
      logger(e);
      showInfo();
    }
  }

  @override
  void initState() {
    super.initState();
    getIconName();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: Appbar(title: l.selectIcon),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _IconTile(
            iconName: 'icon1',
            current: _iconName,
            asset: Assets.icon1,
            onPressed: setIcon,
          ),
          _IconTile(
            iconName: 'icon2',
            current: _iconName,
            asset: Assets.icon2,
            onPressed: setIcon,
          ),
          _IconTile(
            iconName: 'icon3',
            current: _iconName,
            asset: Assets.icon3,
            onPressed: setIcon,
          ),
          _IconTile(
            iconName: 'icon4',
            current: _iconName,
            asset: Assets.icon4,
            onPressed: setIcon,
          ),
          _IconTile(
            iconName: 'icon5',
            current: _iconName,
            asset: Assets.icon5,
            onPressed: setIcon,
          ),
          _IconTile(
            iconName: 'icon6',
            current: _iconName,
            asset: Assets.icon6,
            onPressed: setIcon,
          ),
        ],
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({
    required this.iconName,
    required this.current,
    required this.asset,
    required this.onPressed,
  });

  final String iconName;
  final String current;
  final String asset;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final active = iconName == current;

    return Container(
      height: 96,
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: active
            ? null
            : () {
                onPressed(iconName);
              },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(asset),
            ),
            Spacer(),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? colors.accent : null,
                border: Border.all(
                  width: 2,
                  color: active ? colors.accent : colors.textSecondary,
                ),
              ),
              child: active
                  ? Center(
                      child: SvgWidget(
                        Assets.check,
                        width: 15,
                        color: colors.bg,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
