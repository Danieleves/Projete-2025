import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaInicial()));
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21C5C1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: Image.asset(
                  'image/dermapetbottomless.png',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            // Botão
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF49D5D2),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  textStyle: TextStyle(fontSize: 23),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text("Iniciar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //background
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/backgrounddp.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //foreground
          SafeArea(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 600.0,
                  width: 400.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      //logo
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Container(
                            height: 120,
                            width: 120,
                            child: Image.asset(
                              'image/dermapet.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      //Textfield User
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 40),
                      //botao
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrimeiraTela(),
                              ),
                            );
                          },
                          child: Text("Login"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                          SizedBox(width: 10),
                          Text('OU'),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //background
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/backgrounddp.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //foreground
          SafeArea(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 700.0,
                  width: 400.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      //logo
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Container(
                            height: 120,
                            width: 120,
                            child: Image.asset(
                              'image/dermapet.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      //Textfield email/mobile number
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email/Número de telefone',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield CRMV
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'CRMV',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield user
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Confirm password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 200,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirme a senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 40),
                      //botao
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text("Confirmar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimeiraTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
          title: Text(
              'Derma Pet'
          ),
              centerTitle: true,
      )
    );
  }
}
