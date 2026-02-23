import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedRating = "Good";
  bool recommend = false;
  String feedback = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback Form")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                value: selectedRating,
                items: ["Excellent", "Good", "Average", "Poor"]
                    .map((rating) => DropdownMenuItem(
                          value: rating,
                          child: Text(rating),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRating = value!;
                  });
                },
                decoration: InputDecoration(labelText: "Rating"),
              ),
              CheckboxListTile(
                title: Text("Would you recommend us?"),
                value: recommend,
                onChanged: (value) {
                  setState(() {
                    recommend = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Your Feedback"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Feedback";
                  }
                  return null;
                },
                onSaved: (value) => feedback = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Feedback Submitted")),
                    );
                  }
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}