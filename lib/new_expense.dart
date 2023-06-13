import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  /*
  var _enteredtitle = '';
  void _saveTitleInput(String inputValue) {
    _enteredtitle = inputValue;
  }
  */
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
// the method below removes titleController from the memory when the method is closed.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '\$',
                label: Text('Amount'),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // move component to end of row
            crossAxisAlignment:
                CrossAxisAlignment.center, //center componen horizontally
            children: [
              const Text('Selected date'),
              IconButton(
                  onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))
            ],
          ),
          Expanded(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                    onPressed: () {
                      print(_titleController.text);
                    },
                    child: const Text('Save Expense')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
