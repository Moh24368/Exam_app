import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/core/theme/ui_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class DontHaveAccRow extends StatelessWidget {
  const DontHaveAccRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          UiStrings.dontHaveAccount,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(width: 4.w),
        TextButton(
          onPressed: () {
            context.goNamed(PageRoutesName.signup);
          },
          child: Text(
            UiStrings.signUp,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
