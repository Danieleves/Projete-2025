import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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

var ips = "172.20.10.2:5000";

void main() {
  runApp(MaterialApp(home: TelaInicial()));
}

class TelaInicial extends StatelessWidget {
  final List<Cadastro> usuarios = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      backgroundColor: const Color(0xFF21C5C1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 15 * heightFactor),
            Center(
              child: Image.asset(
                'image/dermapetbottomless.png',
                width: 400 * widthFactor,
                height: 400 * heightFactor,
                fit: BoxFit.cover,
              ),
            ),
            // Botão
            Padding(
              padding: EdgeInsets.only(bottom: 30.0 * heightFactor),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF49D5D2),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: 60 * widthFactor,
                    vertical: 20 * heightFactor,
                  ),
                  textStyle: TextStyle(fontSize: 23 * widthFactor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(usuarios: usuarios),
                    ),
                  );
                },
                child: const Text("Iniciar"),
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
  final List<Cadastro> usuarios;
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

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
                  height: 600.0 * heightFactor,
                  width: 340.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      //logo
                      Padding(
                        padding: EdgeInsets.only(top: 10.0 * heightFactor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60 * widthFactor),
                          child: Container(
                            height: 120 * heightFactor,
                            width: 120 * widthFactor,
                            child: Image.asset(
                              'image/dermapet.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80 * heightFactor),
                      //Textfield User
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 200 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: userController,
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      //Textfield password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 200 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: senhaController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 40 * heightFactor),
                      //botao
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0 * heightFactor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40 * widthFactor,
                              vertical: 10 * heightFactor,
                            ),
                            textStyle: TextStyle(fontSize: 18 * widthFactor),
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
                                  builder: (context) =>
                                      PrimeiraTela(usuarios: widget.usuarios),
                                  settings: RouteSettings(name: 'PrimeiraTela'),
                                ),
                              );
                            }
                          },
                          child: Text("Login"),
                        ),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60 * widthFactor,
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                          SizedBox(width: 10 * widthFactor),
                          Text(
                            'OU',
                            style: TextStyle(fontSize: 16 * widthFactor),
                          ),
                          SizedBox(width: 10 * widthFactor),
                          SizedBox(
                            width: 60 * widthFactor,
                            child: Divider(color: Colors.black, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 20 * heightFactor),
                      GestureDetector(
                        onTap: () {
                          userController.clear();
                          senhaController.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Signup(usuarios: widget.usuarios),
                            ),
                          );
                        },
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16 * widthFactor,
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

class Cadastro {
  String phone;
  String email;
  String usuario;
  String senha;
  String confirm;
  Cadastro({
    required this.phone,
    required this.email,
    required this.usuario,
    required this.senha,
    required this.confirm,
  });
}

class Signup extends StatefulWidget {
  final List<Cadastro> usuarios;
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

  //conexão backend
  Future<String?> cadastrarUsuario() async {
    final url = Uri.parse("http://$ips/adduser");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": usuarioController.text,
        "senha": senhaController.text,
        "email": emailController.text,
      }),
    );
    print(usuarioController.text);
    print(senhaController.text);
    print(emailController.text);

    if (response.statusCode == 200) {
      print("Usuário cadastrado com sucesso!");
      return null;
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("Erro ao cadastrar: ${data['mensagem']}");
      return data['mensagem']; // Retorna a mensagem de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

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
                  height: 650.0 * heightFactor,
                  width: 340.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      //logo
                      Padding(
                        padding: EdgeInsets.only(top: 15.0 * heightFactor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60 * widthFactor),
                          child: Container(
                            height: 120 * heightFactor,
                            width: 120 * widthFactor,
                            child: Image.asset(
                              'image/dermapet.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80 * heightFactor),
                      //Textfield mobile number
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 220 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: phoneController,
                            inputFormatters: [mobileFormatter],
                            decoration: InputDecoration(
                              hintText: 'Número de telefone',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      //Textfield email
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 220 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      //Textfield user
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 220 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: usuarioController,
                            decoration: InputDecoration(
                              hintText: 'Usuário',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      //Textfield Password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 220 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: senhaController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 20 * heightFactor),
                      //Textfield Confirm password
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: (Container(
                          height: 40 * heightFactor,
                          width: 220 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: confirmController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Confirme a senha',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20 * widthFactor),
                          ),
                        )),
                      ),
                      SizedBox(height: 40 * heightFactor),
                      //botao
                      Padding(
                        padding: EdgeInsets.all(10.0 * widthFactor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40 * widthFactor,
                              vertical: 10 * heightFactor,
                            ),
                            textStyle: TextStyle(fontSize: 18 * widthFactor),
                          ),
                          onPressed: () async {
                            final novocadastro = Cadastro(
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
                              return;
                            }
                            String? erro = await cadastrarUsuario();
                            if (erro != null) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(erro)));
                              return;
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
                            fontSize: 16 * widthFactor,
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
} //backend

class Laudo {
  String animal;
  String dono;
  int idade;
  String sexo;
  String raca;
  double peso;
  String data;
  int id;
  String? observacao;
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
    required this.observacao,
    required this.fotoPath,
  });
}

class PrimeiraTela extends StatefulWidget {
  final List<Cadastro> usuarios;
  PrimeiraTela({required this.usuarios, Key? key}) : super(key: key);
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  List<Laudo> cards = [];
  List<Clientes> cadastro = [];

  @override
  void initState() {
    super.initState();
    carregarLaudos();
  }

  void carregarLaudos() async {
    try {
      final laudos = await reqLaudos();
      setState(() {
        cards = laudos;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Laudo>> reqLaudos() async {
    final url = Uri.parse("http://$ips/listar");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Laudo(
        id: json['id'],
        animal: json['animal'],
        dono: json['dono'],
        idade: json['idade'],
        sexo: json['sexo'],
        raca: json['raca'],
        peso: (json['peso'] as num).toDouble(),
        data: json['data'],
        observacao: json['observacao'],
        fotoPath: json['fotoPath'],
      )).toList();
    } else {
      throw Exception("Erro ao carregar laudos: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroCliente(cards: cards, cadastro: cadastro),
            ),
          ).then((recarregar) {
            if (recarregar == true) { //adaptado para receber os laudos do back e carregar a pagina
              carregarLaudos();
            }
          });
        },
        child: Icon(Icons.add),
      ),
      body:
    Stack(
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
              SizedBox(height: 100 * heightFactor),
              Column(
                children: [
                  for (int i = 0; i < cards.length; i++) ...[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesLaudo(laudo: cards[i]),
                            ),
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: 130.0 * heightFactor,
                            width: 330.0 * widthFactor,
                            child: Padding(
                              padding: EdgeInsets.all(8.0 * widthFactor),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Exame: ${i + 1}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16 * widthFactor,
                                          ),
                                        ),
                                        SizedBox(height: 15 * heightFactor),
                                        Text(
                                          'Dono: ${cards[i].dono}',
                                          style: TextStyle(
                                            fontSize: 14 * widthFactor,
                                          ),
                                        ),
                                        Text(
                                          'Animal: ${cards[i].animal}',
                                          style: TextStyle(
                                            fontSize: 14 * widthFactor,
                                          ),
                                        ),
                                        Text(
                                          'Data: ${cards[i].data}',
                                          style: TextStyle(
                                            fontSize: 14 * widthFactor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10 * widthFactor),
                                  Expanded(
                                    flex: 1,
                                    child: cards[i].fotoPath != null //Ver oq o back retorna da imagem
                                        ? Image.file(
                                            File(cards[i].fotoPath!),
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                          )
                                        : Container(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * heightFactor),
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

//tela com lógica de configurações
/* class _PrimeiraTelaState extends State<PrimeiraTela> {
  List<Laudo> cards = [];
  List<Clientes> cadastro = [];
  bool _tconfiguracoes = false;

  void criarTeste() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CadastroCliente(cards: cards, cadastro: cadastro),
            ),
          ).then((_) {
            criarTeste();
          });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/backgrounddp2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //alteração tela de config
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                setState(() {
                  _tconfiguracoes = true;
                });
              },
            ),
          ),
          ListView(
            children: [
              SizedBox(height: 100),
              Column(
                children: [
                  for (int i = 0; i < cards.length; i++) ...[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalhesLaudo(laudo: cards[i]),
                            ),
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: 130.0,
                            width: 350.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2, // ocupa 2/3 do card
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Card: ${i + 1}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Text('Dono: ${cards[i].dono}'),
                                        Text('Animal: ${cards[i].animal}'),
                                        Text('Data: ${cards[i].data}'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ), // espaçamento entre texto e imagem
                                  Expanded(
                                    flex: 1, // ocupa 1/3 do card
                                    child: cards[i].fotoPath != null
                                        ? Image.file(
                                            File(cards[i].fotoPath!),
                                            fit: BoxFit
                                                .cover, // preenche o espaço
                                            height:
                                                double.infinity, // Adequação
                                          )
                                        : Container(
                                            color: Colors.grey,
                                          ), // placeholder
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ],
              ),
            ],
          ),

          if (_tconfiguracoes)
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tconfiguracoes = false;
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      width: larguraTela * 0.4,
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: larguraTela * 0.6,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Configurações',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(child:
                             Row(
                                 children: [
                                   Align(
                                     alignment: Alignment.bottomRight,
                                     child: IconButton(
                                       icon: Icon(Icons.account_circle_outlined),
                                       onPressed: () {
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (context) => Account(usuarios: widget.usuarios),
                                           ),
                                         );
                                       },
                                     ),
                                   ),
                                 ]
                             )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

        ],
      ),
      ),
    );
  }
} */

class Clientes {
  String nome;
  String nomeanimal;
  String telefone;
  String email;
  String endereco;
  int id;

  Clientes({
    required this.nome,
    required this.nomeanimal,
    required this.telefone,
    required this.email,
    required this.endereco,
    required this.id,
  });
}

class CadastroCliente extends StatefulWidget {
  final List<Laudo> cards;
  final List<Clientes> cadastro;
  CadastroCliente({Key? key, required this.cards, required this.cadastro})
    : super(key: key);

  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {

  @override
  void initState() {
    super.initState();
    carregarClientes();
  }

  void carregarClientes() async {
    try {
      final clientes = await reqClientes();
      setState(() {
        final novosClientes = clientes.where((c) => !widget.cadastro.any((a) => a.id == c.id)).toList();
        widget.cadastro.addAll(novosClientes);
      });

    } catch (e) {
      debugPrint(e.toString());
    }
  }


  Future<List<Clientes>> reqClientes() async {
    final url = Uri.parse("http://$ips/listar");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Clientes(
        id: json['id'],
        nome: json['nome'],
        nomeanimal: json['nomeanimal'],
        telefone: json['telefone'],
        email: json['email'],
        endereco: json['endereco'],

      )).toList();
    } else {
      throw Exception("Erro ao carregar clientes: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final recarregar = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientesInfos(
                cards: widget.cards,
                cadastro: widget.cadastro,
              ),
            ),
          );

          if (recarregar == true) {
            carregarClientes();

            await Navigator.push<Laudo>(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PreencherInfos(
                      cards: widget.cards,
                      cadastro: widget.cadastro,
                      fotos: [],
                    ),
              ),
            );
            Navigator.pop(context, true);
          }
        },
        child: Icon(Icons.add, size: 24 * widthFactor),
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
              SizedBox(height: 70 * heightFactor),
              Column(
                children: [
                  for (int i = 0; i < widget.cadastro.length; i++) ...[
                    Center(
                      child: Card(
                        child: SizedBox(
                          height: 130.0 * heightFactor,
                          width: 350.0 * widthFactor,
                          child: Padding(
                            padding: EdgeInsets.all(8.0 * widthFactor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Card: ${i + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16 * widthFactor,
                                  ),
                                ),
                                SizedBox(height: 10 * heightFactor),
                                Text(
                                  'Animal: ${widget.cadastro[i].nomeanimal}',
                                  style: TextStyle(fontSize: 14 * widthFactor),
                                ),
                                Text(
                                  'Dono: ${widget.cadastro[i].nome}',
                                  style: TextStyle(fontSize: 14 * widthFactor),
                                ),
                                Text(
                                  'Endereço: ${widget.cadastro[i].endereco}',
                                  style: TextStyle(fontSize: 14 * widthFactor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * heightFactor),
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

class ClientesInfos extends StatefulWidget {
  final List<Laudo> cards;
  final List<Clientes> cadastro;
  ClientesInfos({required this.cards, required this.cadastro, Key? key})
    : super(key: key);

  @override
  _ClientesInfosState createState() => _ClientesInfosState();
}

class _ClientesInfosState extends State<ClientesInfos> {
  //controllers de armazenamento textfield
  TextEditingController nomeController = TextEditingController();
  TextEditingController nomeAnimalController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  //conexão backend
  Future<int> adicionarCliente() async {
    final url = Uri.parse("http://$ips/clientes");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usuarioid": 10,
        "nome": nomeController.text,
        "nomeanimal": nomeAnimalController.text,
        "telefone": telefoneController.text,
        "email": emailController.text,
        "endereco": enderecoController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("Cliente cadastrado com sucesso!");
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("Erro ao cadastrar: ${data['mensagem']}");
      return data['mensagem']; // Retorna a mensagem de erro
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

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
          SafeArea(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30 * widthFactor),
                child: Container(
                  height: 750.0 * heightFactor,
                  width: 350.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 40 * heightFactor),
                      Text(
                        'Cadastre um novo cliente',
                        style: TextStyle(fontSize: 30 * widthFactor),
                      ),
                      SizedBox(height: 70 * heightFactor),
                      //Textfields
                      _buildTextField(
                        nomeController,
                        'Nome do cliente',
                        widthFactor,
                        heightFactor,
                      ),
                      SizedBox(height: 12 * heightFactor),
                      _buildTextField(
                        nomeAnimalController,
                        'Nome do animal',
                        widthFactor,
                        heightFactor,
                      ),
                      SizedBox(height: 12 * heightFactor),
                      _buildTextField(
                        telefoneController,
                        'Telefone',
                        widthFactor,
                        heightFactor,
                        inputFormatters: [mobileFormatter],
                      ),
                      SizedBox(height: 12 * heightFactor),
                      _buildTextField(
                        emailController,
                        'Email',
                        widthFactor,
                        heightFactor,
                      ),
                      SizedBox(height: 12 * heightFactor),
                      _buildTextField(
                        enderecoController,
                        'Endereço',
                        widthFactor,
                        heightFactor,
                      ),
                      Spacer(),
                      //botão
                      Padding(
                        padding: EdgeInsets.all(10.0 * widthFactor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40 * widthFactor,
                              vertical: 10 * heightFactor,
                            ),
                            textStyle: TextStyle(fontSize: 18 * widthFactor),
                          ),
                          onPressed: () async {
                            if (nomeController.text.isEmpty ||
                                nomeAnimalController.text.isEmpty ||
                                telefoneController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                enderecoController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Preencha todos os campos'),
                                ),
                              );
                              return;
                            }
                            else {
                              await adicionarCliente();
                              nomeController.clear();
                              nomeAnimalController.clear();
                              telefoneController.clear();
                              emailController.clear();
                              enderecoController.clear();

                              Navigator.pop(context, true);
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

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    double widthFactor,
    double heightFactor, {
    List<TextInputFormatter>? inputFormatters,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40 * widthFactor),
      child: Container(
        height: 40 * heightFactor,
        width: 330 * widthFactor,
        color: Colors.grey[300],
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12 * widthFactor),
        child: TextField(
          controller: controller,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            isCollapsed: true,
          ),
          style: TextStyle(fontSize: 20 * widthFactor),
        ),
      ),
    );
  }
}  //backend

class PreencherInfos extends StatefulWidget {
  final List<Laudo> cards;
  final List<Clientes> cadastro;
  final List<String> fotos;
  PreencherInfos({
    required this.cards,
    required this.cadastro,
    required this.fotos,
    Key? key,
  }) : super(key: key);
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

  //conexão backend
  Future<Laudo?> adicionarLaudo(String fotoPath) async {
    final url = Uri.parse("http://$ips/cadastrar");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        //"animal": animalController.text,
        //"dono": donoController.text,
        //"idade": idadeController.text,
        "sexo": sexoController.text,
        "raca": racaController.text,
        //"peso": pesoController.text,
        //"data": dataController.text,
        "fotoPath": fotoPath,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final int idGerado = data["id"];

      final novoLaudo = Laudo(
        id: idGerado,
        animal: animalController.text,
        dono: donoController.text,
        idade: int.tryParse(idadeController.text) ?? 0,
        sexo: sexoController.text,
        raca: racaController.text,
        peso: double.tryParse(pesoController.text) ?? 0,
        data: dataController.text,
        observacao: null,
        fotoPath: fotoPath,
      );

      print("Exame cadastrado com sucesso!");
      return novoLaudo;
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("Erro ao cadastrar: ${data['mensagem']}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                borderRadius: BorderRadius.circular(30 * widthFactor),
                child: Container(
                  height: 750.0 * heightFactor,
                  width: 350.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 40 * heightFactor),
                      Text(
                        'Início de um novo teste',
                        style: TextStyle(fontSize: 30 * widthFactor),
                      ),
                      SizedBox(height: 10 * heightFactor),
                      Text(
                        'Preencha esse questionário sobre o animal para continuar',
                        style: TextStyle(fontSize: 14 * widthFactor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60 * heightFactor),

                      //Textfield data
                      campoTexto(dataController, "dd/mm/aaaa", widthFactor,
                          heightFactor, formatter: dataFormatter),

                      SizedBox(height: 15 * heightFactor),
                      campoTexto(
                          animalController, "Nome do animal", widthFactor,
                          heightFactor),
                      SizedBox(height: 15 * heightFactor),
                      campoTexto(donoController, "Dono do animal", widthFactor,
                          heightFactor),
                      SizedBox(height: 15 * heightFactor),
                      campoTexto(
                          idadeController, "Idade do animal", widthFactor,
                          heightFactor),
                      SizedBox(height: 15 * heightFactor),
                      campoTexto(sexoController, "Sexo do animal", widthFactor,
                          heightFactor),
                      SizedBox(height: 15 * heightFactor),
                      campoTexto(racaController, "Raça do animal", widthFactor,
                          heightFactor),
                      SizedBox(height: 15 * heightFactor),
                      campoTexto(pesoController, "Peso do animal", widthFactor,
                          heightFactor),

                      const Spacer(),

                      //botao
                      Padding(
                        padding: EdgeInsets.all(10.0 * widthFactor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40 * widthFactor,
                              vertical: 10 * heightFactor,
                            ),
                            textStyle: TextStyle(fontSize: 18 * widthFactor),
                          ),
                          onPressed: () async {
                            final novoLaudo = Laudo(
                              animal: animalController.text,
                              dono: donoController.text,
                              idade: int.tryParse(idadeController.text) ?? 0,
                              sexo: sexoController.text,
                              raca: racaController.text,
                              peso: double.tryParse(pesoController.text) ?? 0,
                              data: dataController.text,
                              id: widget.cards.length + 1,
                              observacao: null,
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
                                const SnackBar(
                                  content: Text('Preencha todos os campos'),
                                ),
                              );
                              return;
                            } else
                            if (int.tryParse(idadeController.text) == 0 ||
                                double.tryParse(pesoController.text) == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Preencha os campos corretamente',
                                  ),
                                ),
                              );
                              return;
                            } else {
                              final fotoPath = await Navigator.push<String?>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Foto(
                                        cards: [novoLaudo], // laudo temporário
                                        cadastro: widget.cadastro,
                                        index: 0,
                                      ),
                                ),
                              );
                              if (fotoPath != null && fotoPath.isNotEmpty) {
                                final novoLaudo = await adicionarLaudo(
                                    fotoPath);

                                if (novoLaudo != null) {
                                  setState(() {
                                    widget.cards.add(novoLaudo);
                                    animalController.clear();
                                    donoController.clear();
                                    idadeController.clear();
                                    sexoController.clear();
                                    racaController.clear();
                                    pesoController.clear();
                                    dataController.clear();
                                  });
                                  Navigator.pop(context, novoLaudo);
                                }
                              }
                            }
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

  Widget campoTexto(TextEditingController controller, String hint,
      double widthFactor, double heightFactor,
      {TextInputFormatter? formatter}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40 * widthFactor),
      child: Container(
        height: 40 * heightFactor,
        width: 330 * widthFactor,
        color: Colors.grey[300],
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 12 * widthFactor),
        child: TextField(
          controller: controller,
          inputFormatters: formatter != null ? [formatter] : null,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            isCollapsed: true,
          ),
          style: TextStyle(fontSize: 20 * widthFactor),
        ),
      ),
    );
  }
}// backend

class Foto extends StatefulWidget {
  final List<Laudo> cards;
  final List<Clientes> cadastro;
  final int index;
  const Foto({
    required this.cards,
    required this.cadastro,
    required this.index,
    Key? key,
  }) : super(key: key);
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/backgrounddp.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30 * widthFactor),
                child: Container(
                  height: 750.0 * heightFactor,
                  width: 350.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 50 * heightFactor),
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
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 130 * heightFactor),
                      if (fotoPath != null)
                        Container(
                          width: 280 * widthFactor,
                          height: 280 * heightFactor,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20 * widthFactor,
                            ),
                            border: Border.all(color: Colors.black),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.file(File(fotoPath!), fit: BoxFit.cover),
                        )
                      else
                        Container(
                          width: 280 * widthFactor,
                          height: 280 * heightFactor,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              16 * widthFactor,
                            ),
                            border: Border.all(color: Colors.black12),
                            color: Colors.grey.shade200,
                          ),
                          child: const Text(
                            'Nenhuma foto',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(10.0 * widthFactor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF49D5D2),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40 * widthFactor,
                              vertical: 10 * heightFactor,
                            ),
                            textStyle: TextStyle(fontSize: 18 * widthFactor),
                          ),
                          onPressed: () {
                            if (fotoPath != null) {
                              Navigator.pop(context, fotoPath);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Uma foto precisa ser anexada para dar andamento ao exame",
                                  ),
                                ),
                              );
                              return;
                            }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao iniciar câmera: $erro')),
        );
        Navigator.pop(context);
      }
    }
  }

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

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Câmera', style: TextStyle(fontSize: 20 * widthFactor)),
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
                      Positioned(
                        bottom: 32 * heightFactor,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: EdgeInsets.all(18 * widthFactor),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              try {
                                await _initFuture;
                                final file = await controller.takePicture();
                                if (!mounted) return;
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
                            child: Icon(
                              Icons.camera_alt,
                              size: 32 * widthFactor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro: ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * widthFactor,
                      ),
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

class Account extends StatefulWidget {
  final List<Cadastro> usuarios;

  Account({required this.usuarios, Key? key}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                  height: 400.0,
                  width: 300.0,
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
                            child: Icon(Icons.account_circle),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          height: 40,
                          width: 380,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12),
                          child: Text('xx: ${widget.usuarios}'),
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
} //mexer

class DetalhesLaudo extends StatefulWidget {
  final Laudo laudo;
  DetalhesLaudo({required this.laudo, Key? key}) : super(key: key);
  @override
  _DetalhesLaudoState createState() => _DetalhesLaudoState();
}

class _DetalhesLaudoState extends State<DetalhesLaudo> {
  TextEditingController observacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    observacaoController.text = widget.laudo.observacao ?? '';
  }

  //Gerar PDF
  Future<Uint8List> generatePdf(String observacao) async {
    final pdf = pw.Document();

    pw.ImageProvider? imageProvider;
    if (widget.laudo.fotoPath != null && File(widget.laudo.fotoPath!).existsSync()) {
      final imageFile = File(widget.laudo.fotoPath!);
      final imageBytes = await imageFile.readAsBytes();
      imageProvider = pw.MemoryImage(imageBytes);
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Laudo - Exame Dermatológico',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blueGrey800,
                  ),
                ),
              ),

              pw.SizedBox(height: 24),

              pw.Text('Dados do Paciente:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),

              pw.Text('Dono: ${widget.laudo.dono}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Animal: ${widget.laudo.animal}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Idade: ${widget.laudo.idade}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Sexo: ${widget.laudo.sexo}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Raça: ${widget.laudo.raca}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Peso: ${widget.laudo.peso}', style: pw.TextStyle(fontSize: 14)),
              pw.Text('Data do Exame: ${widget.laudo.data}', style: pw.TextStyle(fontSize: 14)),

              pw.SizedBox(height: 24),
              // OBSERVAÇÕES
              pw.Text('Observações:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text(
                observacao.isNotEmpty ? observacao : 'Nenhuma observação registrada.',
                style: pw.TextStyle(fontSize: 14),
              ),

              if (imageProvider != null) ...[
                pw.Text('Imagem do Exame:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Image(imageProvider, height: 200, fit: pw.BoxFit.contain),
                ),
                pw.SizedBox(height: 24),
              ],

              pw.Spacer(),
              pw.Text('Assinatura do(a) Veterinário(a): _______________________________', style: pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 10),

              pw.Text('CRMV-SP 12345', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  //Salvar pdf
  Future<void> savePdfToDownloads(Uint8List pdfBytes) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          status = await Permission.storage.request();
          if (!status.isGranted) {
            throw Exception("Permissão de armazenamento não concedida");
          }
        }
      }

      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      final filePath = '${downloadsDir.path}/laudo_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);

      await file.writeAsBytes(pdfBytes);

      await OpenFile.open(file.path);
      print('PDF salvo em: ${file.path}');
    } catch (e) {
      print('Erro ao salvar PDF: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final widthFactor = screenWidth / 360;
    final heightFactor = screenHeight / 808;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                borderRadius: BorderRadius.circular(30 * widthFactor),
                child: Container(
                  height: 880.0 * heightFactor,
                  width: 350.0 * widthFactor,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 20 * heightFactor),
                      Text(
                        'Detalhes do Exame ',
                        style: TextStyle(fontSize: 30 * widthFactor),
                      ),
                      SizedBox(height: 20 * heightFactor),

                      // Dono
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Dono: ${widget.laudo.dono}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Animal
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Animal: ${widget.laudo.animal}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Idade
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Idade do animal: ${widget.laudo.idade}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Sexo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Sexo do animal: ${widget.laudo.sexo}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Raça
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Raça do animal: ${widget.laudo.raca}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Peso
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Peso do animal: ${widget.laudo.peso}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * heightFactor),

                      // Data
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 40 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: Text(
                            'Data do Exame: ${widget.laudo.data}',
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * heightFactor),

                      // Foto
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12 * widthFactor),
                        child: Container(
                          height: 110 * heightFactor,
                          width: 330 * widthFactor,
                          child: widget.laudo.fotoPath != null
                              ? Image.file(
                            File(widget.laudo.fotoPath!),
                            fit: BoxFit.fill,
                          )
                              : Container(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20 * heightFactor),

                      // Observação
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40 * widthFactor),
                        child: Container(
                          height: 130 * heightFactor,
                          width: 330 * widthFactor,
                          color: Colors.grey[300],
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 12 * widthFactor),
                          child: TextField(
                            controller: observacaoController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText:
                              'Adicione observações caso seja necessário: ',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 15 * widthFactor),
                          ),
                        ),
                      ),
                      Spacer(),
                      // Botões
                      Padding(
                        padding: EdgeInsets.all(9.0 * widthFactor),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF49D5D2),
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3 * heightFactor,
                                  ),
                                  textStyle: TextStyle(fontSize: 13 * widthFactor),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    widget.laudo.observacao = observacaoController.text;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('PDF gerado! Abrindo visualização')),
                                    );
                                    final observacao = widget.laudo.observacao ?? '';
                                    final pdfData = await generatePdf(observacao);
                                    await savePdfToDownloads(pdfData);
                                    await Printing.layoutPdf(
                                        onLayout: (PdfPageFormat format) async => pdfData,
                                    );

                                },
                                child: const Text("Baixar PDF"),
                              ),
                            ),
                            SizedBox(width: 10 * widthFactor),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF49D5D2),
                                  foregroundColor: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3 * heightFactor,
                                  ),
                                  textStyle: TextStyle(fontSize: 13 * widthFactor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context,);
                                },
                                child: const Text("Voltar"),
                              ),
                            ),
                          ],
                        ),
                      )
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

