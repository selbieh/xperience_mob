  // // =============================================================================================== Snacks Service options (Radio Button with counter)
  //                         if (model.optionsSnacks.isNotEmpty) ...[
  //                           const SizedBox(height: 20),
  //                           const Text(
  //                             "Snacks",
  //                             style: TextStyle(color: AppColors.grey),
  //                           ).localize(context),
  //                           Column(
  //                             children: List.generate(
  //                               model.optionsSnacks.length,
  //                               (index) {
  //                                 return ListTile(
  //                                   dense: true,
  //                                   contentPadding: const EdgeInsets.all(0),
  //                                   leading: Radio(
  //                                     value: model.optionsSnacks[index].id,
  //                                     groupValue: model.selectedSnacksGroupValue,
  //                                     onChanged: (value) {
  //                                       model.selectedSnacksGroupValue = value ?? 0;
  //                                       model.setState();
  //                                     },
  //                                   ),
  //                                   title: Text(
  //                                     model.optionsSnacks[index].name ?? "",
  //                                     style: const TextStyle(fontSize: 14),
  //                                     maxLines: 2,
  //                                   ),
  //                                   trailing: model.optionsSnacks[index].id != model.selectedSnacksGroupValue
  //                                       ? null
  //                                       : Wrap(
  //                                           crossAxisAlignment: WrapCrossAlignment.center,
  //                                           children: [
  //                                             IconButton(
  //                                               icon: const Icon(Icons.remove),
  //                                               onPressed: () {
  //                                                 if ((model.optionsSnacks[index].count ?? 0) > 0) {
  //                                                   model.optionsSnacks[index].count = (model.optionsSnacks[index].count ?? 0) - 1;
  //                                                   model.setState();
  //                                                 }
  //                                               },
  //                                             ),
  //                                             Text("${model.optionsSnacks[index].count}", style: const TextStyle(fontSize: 16)),
  //                                             IconButton(
  //                                               icon: const Icon(Icons.add),
  //                                               onPressed: () {
  //                                                 if ((model.optionsSnacks[index].count ?? 0) < 8) {
  //                                                   model.optionsSnacks[index].count = (model.optionsSnacks[index].count ?? 0) + 1;
  //                                                   model.setState();
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ],
  //                                         ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                         ],