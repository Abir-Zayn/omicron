// import 'package:flutter/material.dart';
// import 'package:omicron/pages/cart/controllers/cart_notifier.dart';
// import 'package:provider/provider.dart';

// class CartCounter extends StatelessWidget {
//   const CartCounter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartNotifier>(
//       builder: (context, cartNotifier, child) {
//         return Row(
//           children: [
//             IconButton(
//               onPressed: cartNotifier.decrement,
//               icon: const Icon(Icons.remove),
//             ),
//             Text('${cartNotifier.quantity}'),
//             IconButton(
//               onPressed: cartNotifier.increment,
//               icon: const Icon(Icons.add),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }