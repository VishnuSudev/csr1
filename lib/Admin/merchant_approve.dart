import 'package:csr/firebase.dart';
import 'package:flutter/material.dart';

class merchantApprove extends StatefulWidget {
  const merchantApprove({super.key});

  @override
  State<merchantApprove> createState() => _merchantApproveState();
}

class _merchantApproveState extends State<merchantApprove> {
  List<Map<String, dynamic>> _userDataList = [];
 
  @override
  void initState() {
    super.initState();
    _getUserDataListByName('status', 'false');
  }

  Future<void> _getUserDataListByName(String key, String value) async {
    List<Map<String, dynamic>> userDataList =
        await AuthService().getUserDataListByName(key, value);
    setState(() {
      _userDataList = userDataList;
    });
  }

  Future<void> approve(String id) async {
    await AuthService().update('status', "true", id, context);
    await _getUserDataListByName('status', 'false');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rgistered Merchant List'),
      ),
      body: _userDataList.isNotEmpty
          ? ListView.builder(
              itemCount: _userDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(_userDataList[index]['name']),
                    subtitle: Text(_userDataList[index]['address']),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Approve this merchant'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    approve(_userDataList[index]['id']);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.gpp_good),
                    ),
                  ),
                );
              },
            )
          : Column(
            children: const [
              Center(
                  child: CircularProgressIndicator(),
                ),
                Text("no data"),
            ],
          ),
    );
  }
}
