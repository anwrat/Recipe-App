import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTPExample extends StatefulWidget {
  const HTTPExample({super.key});
  @override
  State<HTTPExample> createState() => _HTTPExampleState();
}

class _HTTPExampleState extends State<HTTPExample> {
  List<dynamic> _users = [];
  String _name = '';
  bool _isloading = false;

  final TextEditingController _nameField = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<Map<String, dynamic>> fetchData() async {
    setState(() {
      _isloading = true;
    });
    final response = await http.get(Uri.parse(
        'https://anish.pockethost.io/api/collections/test_api/records'));
    if (response.statusCode == 200) {
      setState(() {
        _isloading = false;
      });
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      setState(() {
        _isloading = false;
      });
      throw Exception('Failed to fetch data');
    }
  }

// POST request example
  Future<Map<String, dynamic>> postData(Map<String, dynamic> data) async {
    setState(() {
      _isloading = true;
    });
    final response = await http.post(
      Uri.parse('https://anish.pockethost.io/api/collections/test_api/records'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      setState(() {
        _isloading = false;
      });
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      setState(() {
        _isloading = false;
      });
      throw Exception('Failed to post data');
    }
  }

  // Load users from the database
  _loadUsers() async {
    try {
      final data = await fetchData();
      // print('data ' + data.toString());
      final users = data['items'];
      setState(() {
        _users = users;
      });
      print('Data retrieved: $users');
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  // Save a user to the database
  _saveUser(String name) async {
    try {
      final postResponse = await postData({'name': name});
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
    }
    _loadUsers();

// Reload users after inserting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Http Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameField,
              decoration: const InputDecoration(
                labelText: 'Enter user name',
                hintText: "Type Here ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onSubmitted: (value) {
                _saveUser(value);
                _nameField.text = '';
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveUser(_nameField.text);
                _nameField.text = '';
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            const Text('Users:'),
            if (_isloading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_users[index]['name']),
                    );
                  },
                ),
              ),
               const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}