import 'package:flutter/material.dart';

class SCEBOffice extends StatelessWidget {
  const SCEBOffice({super.key});

  final List<Map<String, String>> officers = const [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: screenWidth * 0.9),
                      child: DataTable(
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                          return const Color(0xFF0B1AF2).withOpacity(0.8);
                        }),
                        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          return Colors.white.withOpacity(0.9);
                        }),
                        columnSpacing: screenWidth * 0.08,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'ID',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                        rows: officers
                            .map(
                              (officer) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                    officer['id']!,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  )),
                                  DataCell(Text(
                                    officer['email']!,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  )),
                                  DataCell(Text(
                                    officer['name']!,
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  if (officers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'No officers found to display.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
