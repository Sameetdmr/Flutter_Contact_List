import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  List<Contact> kisiler = [];

  @override
  void initState() {
    super.initState();
    tumkisiler();
  }

  tumkisiler() async {
    List<Contact> _kisiler = (await ContactsService.getContacts()).toList();
    setState(() {
      kisiler = _kisiler;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Kişiler Listesi"),
        ),
        body: Card(
          color: Colors.grey,
          child: SafeArea(
              top: false,
              bottom: false,
              child: kisiler != null
                  ? ListView.builder(
                      padding: EdgeInsets.all(15),
                      shrinkWrap: true,
                      itemCount: kisiler?.length ?? 0,
                      itemBuilder: (BuildContext context, index) {
                        Contact telefon = kisiler?.elementAt(index);
                        return ListTile(
                          title: Text(telefon.displayName),
                          trailing: Icon(Icons.keyboard_tab),
                          subtitle: Text(telefon.phones.elementAt(0).value),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    KisiDetay(telefon)));
                          },
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
        ));
  }
}

class KisiDetay extends StatelessWidget {
  KisiDetay(this.kisiler);

  final Contact kisiler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kisiler.displayName),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(15)),
          Text(
            kisiler.phones.elementAt(0).value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(15),
              labelText: kisiler.phones.elementAt(0).value,
            ),
          )
        ],
      ),
    );
  }
}
