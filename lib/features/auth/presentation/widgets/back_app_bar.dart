import 'package:exam/core/constants/app_icons.dart';
import 'package:exam/core/theme/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (context.canPop()) context.pop();
        },
        icon: SvgPicture.asset(
          AppIcons.backArrow,
          width: AppSizes.iconSm,
          height: AppSizes.iconSm,
        ),
      ),
      title: Text(title),
    );
  }
}