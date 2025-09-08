import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var dataFormatter = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var mobileFormatter = MaskTextInputFormatter(
  mask: '+## (##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

void main() async {
  runApp(MaterialApp(home: TelaInicial()));
   /*Exemplo POST → envia dados para /process do Flask
  File file = File('C:/Users/gabri/Downloads/projete/client/bin/img2.jpeg');
    List<int> imageBytes = await file.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    var postUrl = Uri.parse('http://127.0.0.1:5000/process');

    var postResponse = await http.post(
      postUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": "Gabriel",
        "imagem":base64Image
      }), // Dados enviados em JSON
    );
  print('Resposta POST: ${postResponse.body}'); */
}

class TelaInicial extends StatelessWidget {
  final List<cadastro> usuarios = [];
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
                    MaterialPageRoute(
                      builder: (context) => Login(usuarios: usuarios),
                    ),
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

class Validar {
  String user;
  String senha;
  Validar({required this.user, required this.senha});
}

class Login extends StatefulWidget {
  final List<cadastro> usuarios;
  const Login({required this.usuarios, Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Validar> validacao = [];
  TextEditingController userController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
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
                            controller: userController,
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: senhaController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            final novoValidar = Validar(
                              user: userController.text,
                              senha: senhaController.text,
                            );
                            validacao.add(novoValidar);
                            var usuarioValido = widget.usuarios.any(
                              (c) =>
                                  c.usuario == userController.text &&
                                  c.senha == senhaController.text,
                            );

                            if (!usuarioValido) {
                              //ver isso mais a fundo, o any
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Usuario ou senha incorretos'),
                                ),
                              );
                              return;
                            } else if (userController.text.isEmpty ||
                                senhaController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Preencha os campos corretamente',
                                  ),
                                ),
                              );
                              return;
                            } else if (usuarioValido) {
                              userController.clear();
                              senhaController.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrimeiraTela(),
                                  settings: RouteSettings(name: 'PrimeiraTela'),
                                ),
                              );
                            }
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
                          userController.clear();
                          senhaController.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup(usuarios: widget.usuarios),),
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

class cadastro {
  String phone;
  String email;
  String usuario;
  String senha;
  String confirm;
  cadastro({
    required this.phone,
    required this.email,
    required this.usuario,
    required this.senha,
    required this.confirm,
  });
}

class Signup extends StatefulWidget {
  final List<cadastro> usuarios;
  const Signup({required this.usuarios, Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  Future<void> cadastrarUsuario() async {
    final url = Uri.parse("http://127.0.0.1:5000/cadastrar");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usuario": usuarioController.text,
        "senha": senhaController.text,
        "email": emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("Usuário cadastrado com sucesso!");
    } else {
      print("Erro ao cadastrar: ${response.body}");
    }
  }

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
                        padding: EdgeInsets.only(top: 15.0),
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
                      //Textfield mobile number
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          height: 40,
                          width: 220,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: phoneController,
                            inputFormatters: [mobileFormatter],
                            decoration: InputDecoration(
                              hintText: 'Número de telefone',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //Textfield CRMV
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 220,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield user
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 220,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: usuarioController,
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 220,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: senhaController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      //Textfield Confirm password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: (Container(
                          height: 40,
                          width: 220,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: confirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirme a senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            final novocadastro = cadastro(
                              phone: phoneController.text,
                              email: emailController.text,
                              usuario: usuarioController.text,
                              senha: senhaController.text,
                              confirm: confirmController.text,
                            );
                            if (senhaController.text !=
                                confirmController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Senhas não coincidem')),
                              );
                              return;
                            } else if (phoneController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                usuarioController.text.isEmpty ||
                                senhaController.text.isEmpty ||
                                confirmController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Preencha todos os campos'),
                                ),
                              );
                            } else {
                              widget.usuarios.add(novocadastro);
                              phoneController.clear();
                              emailController.clear();
                              usuarioController.clear();
                              senhaController.clear();
                              confirmController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cadastrado com sucesso!'),
                                ),
                              );
                              cadastrarUsuario();
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Confirmar"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(usuarios: []),
                            ),
                          );
                        },
                        child: Text(
                          'voltar',
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

class Laudo {
  String animal;
  String dono;
  int idade;
  String sexo;
  String raca;
  double peso;
  int data;
  int id;
  String? fotoPath;
  Laudo({
    required this.animal,
    required this.dono,
    required this.idade,
    required this.sexo,
    required this.raca,
    required this.peso,
    required this.data,
    required this.id,
    required this.fotoPath,
  });
}

class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  List<Laudo> cards = [];

  void criarTeste() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreencherInfos(cards: cards),
            ),
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
                  for (int i = 0; i < cards.length; i++) ...[
                    Center(
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 130.0, width: 350.0),
                            Text('Card: ${i + 1}'),
                            Text('Animal: ${cards[i].animal}'),
                            Text('Data: ${cards[i].data}'),
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

class PreencherInfos extends StatefulWidget {
  final List<Laudo> cards;
  PreencherInfos({required this.cards, Key? key}) : super(key: key);
  @override
  _PreencherInfosState createState() => _PreencherInfosState();
}

class _PreencherInfosState extends State<PreencherInfos> {
  //controllers de armazenamento textfield
  TextEditingController animalController = TextEditingController();
  TextEditingController donoController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController racaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController fotopathController = TextEditingController();
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
                      SizedBox(height: 60),
                      //Textfield data
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: TextField(
                            controller: dataController,
                            inputFormatters: [dataFormatter],
                            decoration: InputDecoration(
                              hintText: 'dd/mm/aaaa',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                            controller: animalController,
                            decoration: InputDecoration(
                              hintText: 'Nome do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: donoController,
                            decoration: InputDecoration(
                              hintText: 'Dono do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: idadeController,
                            decoration: InputDecoration(
                              hintText: 'Idade do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: sexoController,
                            decoration: InputDecoration(
                              hintText: 'Sexo do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: racaController,
                            decoration: InputDecoration(
                              hintText: 'Raça do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: pesoController,
                            decoration: InputDecoration(
                              hintText: 'Peso do animal',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            final novoLaudo = Laudo(
                              animal: animalController.text,
                              dono: donoController.text,
                              idade: int.tryParse(idadeController.text) ?? 0,
                              sexo: sexoController.text,
                              raca: racaController.text,
                              peso: double.tryParse(pesoController.text) ?? 0,
                              data: int.tryParse(dataController.text) ?? 0,
                              id: widget.cards.length + 1,
                              fotoPath: null,
                            );
                            if (animalController.text.isEmpty ||
                                donoController.text.isEmpty ||
                                idadeController.text.isEmpty ||
                                sexoController.text.isEmpty ||
                                racaController.text.isEmpty ||
                                pesoController.text.isEmpty ||
                                dataController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Preencha todos os campos'),
                                ),
                              );
                              return;
                            } else if (int.tryParse(idadeController.text) ==
                                    0 ||
                                double.tryParse(pesoController.text) == 0 ||
                                int.tryParse(dataController.text) == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Preencha os campos corretamente',
                                  ),
                                ),
                              );
                              return;
                            } else {
                              widget.cards.add(novoLaudo);
                              animalController.clear();
                              donoController.clear();
                              idadeController.clear();
                              sexoController.clear();
                              racaController.clear();
                              pesoController.clear();
                              dataController.clear();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Foto(
                                    cards: widget.cards,
                                    index: widget.cards.length - 1,
                                  ),
                                ),
                              );
                            }
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

class Foto extends StatefulWidget {
  final List<Laudo> cards;
  final int index;
  const Foto({required this.cards, required this.index, Key? key})
    : super(key: key);
  @override
  _FotoState createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  List<String> fotos = [];
  String? fotoPath;

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
                      SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () async {
                          final path = await Navigator.push<String?>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CapturaCamera(),
                            ),
                          );
                          if (path != null && mounted) {
                            setState(() {
                              fotoPath = path;
                              widget.cards[widget.index].fotoPath = path;
                            });
                          }
                        },
                        child: Icon(Icons.camera_alt, color: Colors.black),
                      ),
                      SizedBox(height: 120),
                      if (fotoPath != null)
                        Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.file(File(fotoPath!), fit: BoxFit.cover),
                        )
                      else
                        Container(
                          width: 320,
                          height: 320,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black12),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text(
                            'Nenhuma foto',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      Spacer(),
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
                          child: const Text("Confirmar"),
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

class CapturaCamera extends StatefulWidget {
  const CapturaCamera({Key? key}) : super(key: key);

  @override
  State<CapturaCamera> createState() => _CapturaCameraState();
}

class _CapturaCameraState extends State<CapturaCamera>
    with WidgetsBindingObserver {
  //mixin
  CameraController? _controller;
  Future<void>? _initFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        back,
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      _controller = controller;
      _initFuture = controller.initialize();
      setState(() {});
    } catch (erro) {
      //Permissão negada
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao iniciar câmera: $erro')),
        );
        Navigator.pop(context);
      }
    }
  }

  // Para o preview na mudança de estado
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Câmera'),
        centerTitle: true,
      ),
      body: controller == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Center(child: CameraPreview(controller)),
                      // Botão da camera
                      Positioned(
                        bottom: 32,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(18),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              try {
                                await _initFuture;
                                final file = await controller.takePicture();
                                if (!mounted) return;
                                // Retorna o caminho da foto para a tela "foto"
                                Navigator.pop(context, file.path);
                              } catch (erro) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao tirar foto: $erro'),
                                  ),
                                );
                              }
                            },
                            child: const Icon(Icons.camera_alt, size: 32),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }
}
