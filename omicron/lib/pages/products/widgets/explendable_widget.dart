import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omicron/pages/products/controllers/product_notfier.dart';
import 'package:omicron/src/common/utils/appColors.dart';
import 'package:omicron/src/widgets/app_style.dart';
import 'package:provider/provider.dart';

//This is a widget that mainly work as the "view all". More specificly
// When a user clicks on the "view all" button, this widget will be displayed the products/items information  in a expendable
//format
class ExplendableWidget extends StatelessWidget {
  const ExplendableWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.justify,
          maxLines: context.watch<ProductNotfier>().description ? 3 : 10,
          style: appStyle(13, AppColors.appGrayDark, FontWeight.w400),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(5.w),
              child: InkWell(
                  onTap: () {
                    context.read<ProductNotfier>().setDescription();
                  },
                  child: Text(
                    context.watch<ProductNotfier>().description
                        ? 'View all'
                        : 'View less',
                    style: appStyle(13, AppColors.appPrimary, FontWeight.w400),
                  )),
            )
          ],
        )
      ],
    );
  }
}
