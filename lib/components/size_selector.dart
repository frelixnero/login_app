// import 'package:flutter/material.dart';
// import 'package:login_app/models/food.dart';
// import 'package:login_app/service/size_selector/size_selector_service.dart';
// import 'package:provider/provider.dart';

// class SizeSelector extends StatefulWidget {
//   final Food food;
//   const SizeSelector({super.key, required this.food});

//   @override
//   State<SizeSelector> createState() => _SizeSelectorState();
// }

// class _SizeSelectorState extends State<SizeSelector> {
//   // size selector
//   SizeSelectorService sizeSelectorService = SizeSelectorService();

//   void checkSize(String pastrySize, String foodWidgetSize) {
//     if (!SizeSelectorService().isSelected(pastrySize, widget.food)) {
//       Provider.of<SizeSelectorService>(
//         context,
//         listen: true,
//       ).updateSize(pastrySize);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         sizeWidget(context, "small", "S"),
//         sizeWidget(context, "medium", "M"),
//         sizeWidget(context, "large", "L"),
//         sizeWidget(context, "extraLarge", "XL"),
//       ],
//     );
//   }

//   Widget sizeWidget(
//     BuildContext context,
//     String pastrySize,
//     String iconLetter,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         print("Current Size${sizeSelectorService.currentSize}");
//         checkSize(pastrySize, widget.food.foodSize.pastrySize);
//       },
//       child: Material(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//           height: 50,
//           width: 50,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color:
//                 sizeSelectorService.isSelected(pastrySize, widget.food)
//                     ? Theme.of(context).colorScheme.primaryContainer
//                     : Theme.of(context).colorScheme.onTertiary,
//           ),
//           child: Text(iconLetter),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:login_app/models/food.dart';
import 'package:login_app/service/size_selector/size_selector_service.dart';
import 'package:provider/provider.dart';

class SizeSelector extends StatefulWidget {
  final Food food;
  const SizeSelector({super.key, required this.food});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  // TO Check size
  void checkSize(BuildContext context, String pastrySize) {
    final selectorService = Provider.of<SizeSelectorService>(
      context,
      listen: false,
    );

    if (!selectorService.isSelected(pastrySize, widget.food)) {
      selectorService.updateSize(pastrySize, widget.food);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectorService = context.watch<SizeSelectorService>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 5),
        sizeWidget(context, selectorService, "small", "S"),
        SizedBox(width: 5),
        sizeWidget(context, selectorService, "medium", "M"),
        SizedBox(width: 5),
        sizeWidget(context, selectorService, "large", "L"),
        SizedBox(width: 5),
        sizeWidget(context, selectorService, "extraLarge", "XL"),
      ],
    );
  }

  Widget sizeWidget(
    BuildContext context,
    SizeSelectorService service,
    String pastrySize,
    String iconLetter,
  ) {
    final isCurrentSize = service.isSelected(pastrySize, widget.food);

    return GestureDetector(
      onTap: () {
        // Call the logic using the context and pastry size

        checkSize(context, pastrySize);
        print("Current Size${service.currentSize(widget.food)}");
      },
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 55,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isCurrentSize
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.onTertiary,
          ),
          alignment: Alignment.center,
          child: Text(
            iconLetter,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
