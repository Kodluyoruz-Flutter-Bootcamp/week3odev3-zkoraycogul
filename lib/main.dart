import 'package:flutter/material.dart';
import 'package:ogrencinot/screens/add_student.dart';

import 'models/students.dart';


void main() {
  runApp(MyApp());
}

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

// void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  List<Student> students = [];

  Student selectedStudent = Student.withId(0, "Koray", "cgl", 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("ZKC Ogrenci Takip Sistemi"),
            backgroundColor: Colors.red),
        body: buildBody());
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      students[index].firstName +
                          " " +
                          students[index].lastName,
                      style: TextStyle(color: Colors.red)),
                  subtitle: Text(
                      "Sinavdan Aldigi Not : " +
                          students[index].grade.toString() +
                          " [" +
                          students[index].getStatus +
                          "]",
                      style: TextStyle(color: Colors.blue)),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://th.bing.com/th/id/R.139146084f0a6bef9768ada24ebee58d?rik=3OGcqm6M%2ftH7UA&pid=ImgRaw&r=0"),
                  ),
                  trailing: bulidStatusIcon(students[index].grade),
                  onTap: () {
                    setState(() {
                      this.selectedStudent = students[index];
                    });

                  },
                  onLongPress: () {
                    print("Uzun basildi.");
                  },
                );
              }),
        ),
        Text(
          "Secili Ogrenci : " +
              selectedStudent.firstName +
              " " +
              selectedStudent.lastName,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Yeni Ogrenci",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAdd(students)),).then((res) => setState((){}));
                  //print("Yeni Ogrenci");
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Guncelle",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
                onPressed: () {
                  print("Guncelle");
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Sil",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    )
                  ],
                ),
                onPressed: () {
                  students.remove(selectedStudent);
                  setState((){});
                  //print("Sil");
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget bulidStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade > 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
