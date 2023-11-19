import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void incriment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counterModel = Provider.of<ConterModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider State Manegement"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Count ${counterModel.count}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => counterModel.incriment(),
                    child: const Text("Increment")),
                ElevatedButton(
                    onPressed: () => counterModel.decrement(),
                    child: const Text("decrement"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
