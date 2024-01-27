//import 'package:article_summarization/function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Summer',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Article Summarization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = '';
  TextEditingController textController = TextEditingController();
  String displayText = "";
  String output = 'Initial Output';


  Future<String> fetchdata(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(
          color: Colors.white, // Set the desired text color
        ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),  // Adjust the file path accordingly
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextField(
                  onChanged: (value) {
                    url =
                        'http://dc0d-34-87-176-56.ngrok-free.app/api?query=' +
                            value.toString();
                  },
                  cursorColor: Colors.black,
                  controller: textController,
                  maxLines: null,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.8),  // Adjust the opacity as needed
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: "Enter article link",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  output = await fetchdata(url);
                  setState(() {
                    displayText = output;
                  }
                  );

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set the desired background color
                ),
                child: Text("Summarize", style: TextStyle(
                  color: Colors.white, // Set the desired text color
                ),),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    textController.clear();
                    displayText = "";
                  });

                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set the desired background color
                ),
                child: Text("Clear", style: TextStyle(
                  color: Colors.white, // Set the desired text color
                ),),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      displayText,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
