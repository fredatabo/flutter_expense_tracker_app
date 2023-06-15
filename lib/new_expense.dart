import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart'; // to get the date formatter

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

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
  DateTime? _selectedDate; // initializing null or empty variable
  Category _selectedCategory = Category.leisure;
// the method below removes titleController from the memory when the method is closed.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('plese enter a valid amount, date or title'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
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
              Text(_selectedDate == null
                  ? 'no date selected'
                  : formater.format(_selectedDate!)),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          Expanded(
            child: Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toString().toUpperCase(),
                            )))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
