import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:io';
import 'package:camera/camera.dart';

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
                    MaterialPageRoute(
                      builder: (context) => Login(usuarios: []),
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

class validar{
  String user;
  String senha;
  validar({
    required this.user,
    required this.senha,
});

}

class Login extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final List<cadastro> usuarios;
  final List<validar> validacao = [];
  Login({required this.usuarios});
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
                            final novovalidar = validar(
                              user: userController.text,
                              senha: senhaController.text,
                            );
                            validacao.add(novovalidar);
                            userController.clear();
                            senhaController.clear();

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

class cadastro {
  String phone;
  String crmv;
  String usuario;
  String senha;
  cadastro({
  required this.phone,
    required this.crmv,
    required this.usuario,
    required this.senha});
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? confirm;
  List<cadastro> usuarios = [];
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController crmvController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
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
                            controller: crmvController,
                            decoration: InputDecoration(
                              hintText: 'CRMV',
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
                            // confirm: confirmController.text,
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
                          onPressed: () {final novocadastro = cadastro(
                              phone: phoneController.text,
                              crmv: crmvController.text,
                              usuario: usuarioController.text,
                              senha: senhaController.text,
                            );
                            usuarios.add(novocadastro);
                            phoneController.clear();
                            crmvController.clear();
                            usuarioController.clear();
                            senhaController.clear();
                            confirmController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Cadstrado com sucesso!',
                            )),
                          );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(usuarios: usuarios),
                              ),
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

class Laudo {
  String animal;
  String dono;
  int idade;
  String sexo;
  String raca;
  double peso;
  String remedio;
  int hora;
  String area;
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
    required this.remedio,
    required this.hora,
    required this.area,
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

class PreencherInfos extends StatelessWidget {
  final List<Laudo> cards;
  PreencherInfos({required this.cards, Key? key}) : super(key: key);

  //controllers de armazenamento textfield
  final TextEditingController animalController = TextEditingController();
  final TextEditingController donoController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController sexoController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController remedioController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController ideController = TextEditingController();
  final TextEditingController fotopathController = TextEditingController();
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
                            controller: remedioController,
                            decoration: InputDecoration(
                              hintText: 'Remédio dado',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: horaController,
                            decoration: InputDecoration(
                              hintText: 'Hora em que o remédio foi aplicado',
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            style: TextStyle(fontSize: 20),
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
                            controller: areaController,
                            decoration: InputDecoration(
                              hintText: 'Área em que o remédio foi aplicado',
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
                              remedio: remedioController.text,
                              hora: int.tryParse(horaController.text) ?? 0,
                              area: areaController.text,
                              data: int.tryParse(dataController.text) ?? 0,
                              id: cards.length + 1,
                              fotoPath: null,
                            );
                            cards.add(novoLaudo);
                            animalController.clear();
                            donoController.clear();
                            idadeController.clear();
                            sexoController.clear();
                            racaController.clear();
                            pesoController.clear();
                            remedioController.clear();
                            horaController.clear();
                            areaController.clear();
                            dataController.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Foto(cards: cards, index: cards.length - 1),
                              ),
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
