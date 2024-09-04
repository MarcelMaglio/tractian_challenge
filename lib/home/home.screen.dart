import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tractian_challenge/companies/companies.store.dart';
import 'package:tractian_challenge/home/itens.page.dart';
import 'package:tractian_challenge/models/companies.json.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../helpers/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final companiesStore = CompaniesStore();
  late DateTime currentBackPressTime;

  @override
  void initState() {
    _inicializarCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/tractian-texto.png',
                  fit: BoxFit.cover),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: SizeConfig.of(context).dynamicScaleSize(size: 24),
                  ),
                  onPressed: () {
                    _showExitConfirmationDialog(context);
                  },
                ),
              )
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF141C2C),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Selecione a empresa',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.of(context).dynamicScaleSize(size: 20),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF141C2C),
            ),
          ),
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              if (companiesStore.companiesList != null) {
                return ListView.builder(
                    itemCount: companiesStore.companiesList!.length,
                    itemBuilder: (context, index) {
                      final r = companiesStore.companiesList![index];
                      return buildAnimationConfiguration(index, r, context);
                    });
              } else if (companiesStore.error != null) {
                return _erroAoBuscarCompanies();
              }
              return Center(
                child: SpinKitWave(
                  color: const Color(0xFF141C2C),
                  size: SizeConfig.of(context).dynamicScaleSize(size: 33),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _erroAoBuscarCompanies() {
    // Implementação do erro aqui
    return Container();
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar saída'),
          content:
              const Text('Você tem certeza de que deseja sair do aplicativo?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sair'),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        );
      },
    );
  }

  AnimationConfiguration buildAnimationConfiguration(
      int index, CompaniesJson r, BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 10),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            color: Colors.white,
            height: SizeConfig.of(context).dynamicScaleSize(size: 100),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: const Duration(milliseconds: 700),
                          child: ItensPage(id: r.id!, nomeEmpresa: r.name!)),
                    );
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: SizedBox(
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(
                            SizeConfig.of(context).dynamicScaleSize(size: 16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.officeBuildingOutline,
                              color: Colors.white,
                              size: SizeConfig.of(context)
                                  .dynamicScaleSize(size: 25),
                            ),
                            SizedBox(
                              width: SizeConfig.of(context)
                                  .dynamicScaleSize(size: 8),
                            ),
                            Expanded(
                              child: Text(
                                r.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.of(context)
                                      .dynamicScaleSize(size: 20),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _inicializarCompanies() async {
    await companiesStore.getCompanies();
  }
}
