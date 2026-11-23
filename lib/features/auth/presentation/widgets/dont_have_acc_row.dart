import 'package:exam/config/routes/page_routes_name.dart';
import 'package:exam/core/theme/ui_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class DontHaveAccRow extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const DontHaveAccRow({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(width: 4.w),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
