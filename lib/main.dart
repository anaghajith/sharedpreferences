import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState(){
    super.initState();
    checkifalreadylogin();
  }
  void checkifalreadylogin() async{
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if(newuser == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
  @override
  void dispose(){
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Shared prefernce"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text("Login",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter username"
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter password"
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                  String un = username.text;
                  String pw = password.text;
                  if(un != '' && pw != ''){
                    print("Login Succesfull");
                    logindata.setBool('login', false);
                    logindata.setString('username', un);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState(){
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
    },);
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Shared Preference"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Welcome $username",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
              logindata.setBool('login', true);
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => LoginPage()));
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}

