import 'package:flutter/material.dart';

class MultipleCardFlow extends StatelessWidget {
  const MultipleCardFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF8e9bb5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                  child: Text(
                                'Buscar Ciudad',
                                style: TextStyle(color: Colors.white),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
