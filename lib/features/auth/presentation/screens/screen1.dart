// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rick_and_morty/generated/l10n.dart';
// import 'package:rick_and_morty/internal/helpers/localization/bloc/localization_bloc.dart';

// class Screen1 extends StatefulWidget {
//   const Screen1({super.key});

//   @override
//   State<Screen1> createState() => _Screen1State();
// }

// class _Screen1State extends State<Screen1> {
//   @override
//   Widget build(BuildContext context) {
// SystemChrome.setSystemUIOverlayStyle(
// const SystemUiOverlayStyle(
// statusBarColor: Colors.transparent,
// ),
// );
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(
//               S.of(context).hello,
//               style: TextStyle(fontSize: 45),
//             ),
//             Text(
//               S.of(context).car,
//               style: TextStyle(fontSize: 45),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Screen2(),
//                   ),
//                 );
//               },
//               child: Text(S.of(context).start),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class Screen2 extends StatelessWidget {
//   const Screen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).hello),
//         centerTitle: true,
//         backgroundColor: Colors.amberAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Screen3(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class Screen3 extends StatelessWidget {
//   const Screen3({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).start),
//         backgroundColor: Colors.yellow,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 context
//                     .read<LocalizationBloc>()
//                     .add(ChangeLocaleEvent(locale: 'ru'));
//               },
//               child: Text('ru'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context
//                     .read<LocalizationBloc>()
//                     .add(ChangeLocaleEvent(locale: 'en'));
//               },
//               child: Text('en'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context
//                     .read<LocalizationBloc>()
//                     .add(ChangeLocaleEvent(locale: 'ky'));
//               },
//               child: Text('ky'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
