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
            SizedBox(height: 15),
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
                                settings: RouteSettings(name: 'PrimeiraTela'),
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
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 40),
                      //botao
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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

class Informacoes {
  String dono;
  String animal;
  int data;
  Informacoes(this.dono, this.animal, this.data);
}

class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  List<Informacoes> cards = [];

  void criarTeste() {
    setState(() {
      cards.add(Informacoes("Gabriel", "Theo", 27));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => preencherInfos()),
          ).then((_) {
            criarTeste();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/backgrounddp2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              SizedBox(height: 100),
              Column(
                children: [
                  for (var card in cards) ...[
                    Center(
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 130.0, width: 350.0),
                            Text('Nome $card.nome'),
                            Text('animal $card.animal'),
                            Text('data $card.data'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 45),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class preencherInfos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 900.0,
                  width: 400.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Início de um novo teste',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Preencha a esse questionário para continuar',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 90),
                      //Textfield Nome do Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nome do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Dono do Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Dono do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Idade do Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Idade do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Sexo do Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Sexo do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Raça do Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Raça do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //textfield Peso do animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Peso do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Remédio dado
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Remédio dado',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Hora em que o remédio foi aplicado
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Hora em que o remédio foi aplicado',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Área em que o remédio foi aplicado
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Área em que o remédio foi aplicado',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )),
                      ),
                      SizedBox(height: 60),
                      //botao
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                              MaterialPageRoute(builder: (context) => Foto()),
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
            //Navigator.pop(context); voltar para a tela inicial
          ),
        ],
      ),
    );
  }
}

class Foto extends StatefulWidget {
  @override
  _FotoState createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  List<String> fotos = [];

  void atualizarFoto() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  height: 900.0,
                  width: 400.0,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('PrimeiraTela'),
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
