import 'package:flutter/material.dart';
import 'package:thboooks/States/helper_user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Username';
  String _email = 'Email';
  String _phone = 'Phone';
  String _biography = '';
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Save the updated profile information
    // You can add your own logic here
    _toggleEditing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          textAlign: TextAlign.end,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32.0),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 64.0,
                      // backgroundImage: AssetImage(''),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            _isEditing ? Icons.save : Icons.edit,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          onPressed: _toggleEditing,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              if (_isEditing)
                TextField(
                  controller: TextEditingController(text: _name),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _name = value;
                  },
                )
              else
                Text(
                  _name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8.0),
              if (_isEditing)
                TextField(
                  controller: TextEditingController(text: _email),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _email = value;
                  },
                )
              else
                Text(
                  _email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 8.0),
              if (_isEditing)
                TextField(
                  controller: TextEditingController(text: _phone),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _phone = value;
                  },
                )
              else
                Text(
                  _phone,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 16.0),
              Text(
                'Biography',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              if (_isEditing)
                TextField(
                  controller: TextEditingController(text: _biography),
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  onChanged: (value) {
                    _biography = value;
                  },
                )
              else
                Text(
                  _biography,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              const SizedBox(height: 32.0),
              const Divider(),
              const SizedBox(height: 16.0),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, '/Settings');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Log Out'),
            onPressed: () {
              logoutUserInUI(context); // Add logout logic here
            },
          ),
        ],
      );
    },
  );
}
