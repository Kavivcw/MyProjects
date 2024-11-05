// class ReturnView extends ConsumerStatefulWidget {
//   const ReturnView({super.key});
//
//   @override
//   ConsumerState<ReturnView> createState() => _ReturnViewState();
// }
//
// class _ReturnViewState extends ConsumerState<ReturnView> {
//   String? _selectedReason;
//
//   int _count = 0;
//
//   void _increment() {
//     setState(() {
//       _count++;
//     });
//   }
//
//   void _decrement() {
//     setState(() {
//       if (_count > 0) {
//         _count--;
//       }
//     });
//   }
//
//   void initState() {
//     super.initState();
//
//     // ref.read(reasonListingNotifier).load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     final _textController = TextEditingController();
//
//     // var reasonReader = ref.watch(reasonListingNotifier);
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
// /*
//                 DropdownButtonFormField<String>(
//                   value: _selectedReason,
//                   icon: const Icon(Icons.arrow_drop_down),
//                   decoration:  InputDecoration(
//                       enabledBorder: OutlineInputBorder( // Border for normal state
//                         borderSide: const BorderSide(color: Colors.red, width: 1.0), // Set width and color
//                         borderRadius: BorderRadius.circular(5.0), // Add rounded corners (optional)
//                       ),
//                     focusedBorder: OutlineInputBorder( // Border for focused state
//                     borderSide: const BorderSide(color: Colors.grey, width: 1.0), // Set width and color
//                     borderRadius: BorderRadius.circular(5.0), // Add rounded corners (optional)
//                   ),// Add dropdown icon
//
//                 ),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedReason = newValue!;
//                 });
//               },
//               items: reasonReader.value?.map((ReasonData data){
//                     return DropdownMenuItem
//               <String>(
//
//                 value: data.reason,
//                 child: Text(data.reason),
//               );
//                   })
//                   .toList(),
//                 ),
// */
//
//                 Container(
//                   height: 60,
//                   width: 400,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                       color: Colors.white,
//                       border: Border.all(color: appthemecolor1)),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         hint: Text(
//                           'Reason',
//                           style: TextStyle(fontSize: 10),
//                         ),
//                         value: _selectedReason,
//                         icon: Icon(
//                           Icons.keyboard_arrow_down_outlined,
//                           size: 20,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedReason = newValue;
//                           });
//                         },
//                         items: [],
//                         // items: reasonReader.value?.map((data) {
//                         //   return DropdownMenuItem<String>(
//                         //     value: data.reason,
//                         //     child: Text(
//                         //       data.reason,
//                         //       style: const TextStyle(fontSize: 10),
//                         //     ),
//                         //   );
//                         // }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 TextFormField(
//                     controller: _textController,
//                     keyboardType: TextInputType.multiline,
//                     maxLines: null, // Allows multiline input
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           // Border for normal state
//                           borderSide:
//                               const BorderSide(color: Colors.red, width: 1.0),
//                           // Set width and color
//                           borderRadius: BorderRadius.circular(
//                               5.0), // Add rounded corners (optional)
//                         ),
//                         hintText: 'More details', // Hint text
//                         border: OutlineInputBorder())),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   children: [
//                     Text('Quality'),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 40),
//                       child: Container(
//                         height: 30,
//                         width: 150,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(color: appthemecolor1)
//                             // color: Colors.pink[100],
//                             ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             GestureDetector(
//                               onTap: _decrement,
//                               child: Icon(
//                                 Icons.remove_circle_outline,
//                                 size: 23,
//                                 color: Colors.red.shade800,
//                               ),
//                             ),
//                             Text(
//                               '$_count',
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 20),
//                             ),
//                             GestureDetector(
//                               onTap: _increment,
//                               child: Icon(
//                                 Icons.add_circle_outline,
//                                 size: 23,
//                                 color: Colors.red.shade800,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 AppButton(title: 'Submit', onPressed: () {})
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
