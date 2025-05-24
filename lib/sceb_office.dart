import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SCEBOffice extends StatefulWidget {
  const SCEBOffice({super.key});

  @override
  State<SCEBOffice> createState() => _SCEBOfficeState();
}

class _SCEBOfficeState extends State<SCEBOffice> {
  final CollectionReference officersCollection =
      FirebaseFirestore.instance.collection('officers');

  Future<void> _showAddEditDialog({DocumentSnapshot? document}) async {
    final idController = TextEditingController(text: document?['id'] ?? '');
    final emailController = TextEditingController(text: document?['email'] ?? '');
    final nameController = TextEditingController(text: document?['name'] ?? '');
    final passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(document == null ? 'Add Officer' : 'Edit Officer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                if (document == null)
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final id = idController.text.trim();
                final email = emailController.text.trim();
                final name = nameController.text.trim();
                final password = passwordController.text.trim();

                if (id.isEmpty || email.isEmpty || name.isEmpty || (document == null && password.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }

                try {
                  if (document == null) {
                    // Create Firebase Auth user
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await officersCollection.add({
                      'id': id,
                      'email': email,
                      'name': name,
                    });
                  } else {
                    await officersCollection.doc(document.id).update({
                      'id': id,
                      'email': email,
                      'name': name,
                    });
                  }

                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.message}')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add Officer',
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/QR-CODE-BG.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -98,
            left: 0,
            right: 0,
            child: Transform(
              transform: Matrix4.identity()..scale(1.1, 1.1, 1.0),
              child: Image.asset(
                'assets/purple-top-shape-vector.png',
                height: screenHeight * 0.30,
              ),
            ),
          ),
          Positioned(
            bottom: -70,
            left: -5,
            right: 0,
            child: Transform(
              transform: Matrix4.identity()..scale(1.1, 1.1, 1.0),
              child: Image.asset(
                'assets/purple-bottom-shape-vector.png',
                height: screenHeight * 0.30,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.06,
            left: screenWidth * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/ic-back.png',
                height: screenHeight * 0.05,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.25,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Officers',
                  style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: 36,
                    color: Color(0xFF0B1AF2),
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: officersCollection.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error loading officers.',
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final data = snapshot.data!;
                      if (data.docs.isEmpty) {
                        return Center(
                          child: Text(
                            'No officers found to display.',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: data.docs.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final doc = data.docs[index];
                          final officer = doc.data()! as Map<String, dynamic>;

                          return ListTile(
                            tileColor: Colors.white.withOpacity(0.9),
                            title: Text(
                              officer['name'] ?? '',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${officer['id'] ?? ''}',
                                    style: const TextStyle(fontFamily: 'Poppins')),
                                Text('Email: ${officer['email'] ?? ''}',
                                    style: const TextStyle(fontFamily: 'Poppins')),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _showAddEditDialog(document: doc),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this officer?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await officersCollection.doc(doc.id).delete();
                                      // Optionally delete from Firebase Auth too if needed.
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
