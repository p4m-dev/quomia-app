import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quomia/utils/app_colors.dart';
import 'package:quomia/widgets/buy/creation_step.dart';

class BuyBoxScreen extends StatefulWidget {
  const BuyBoxScreen({super.key});

  @override
  State<BuyBoxScreen> createState() => _BuyBoxScreenState();
}

class _BuyBoxScreenState extends State<BuyBoxScreen> {
  int _currentStep = 0;
  String _boxType = '';
  String _boxCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light.background,
        appBar: AppBar(
          backgroundColor: AppColors.light.primaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.light.primaryText,
                size: 30,
              ),
              onPressed: () async {}),
          title: Text('Quomia',
              style: TextStyle(
                fontFamily: 'DM Sans',
                color: AppColors.light.info,
                fontSize: 28,
              )),
          actions: [],
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            steps: [
              _buildCustomStep(0, 'Introduzione', _buildIntroStep()),
              _buildCustomStep(1, 'Tipologia', _buildBoxTypeStep()),
              _buildCustomStep(2, 'Categoria', _categoryStep()),
              _buildCustomStep(3, 'Creazione', const CreationStep()),
            ],
            onStepTapped: (int step) {
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              setState(() {
                _currentStep += 1;
              });
            },
            onStepCancel: () {
              setState(() {
                _currentStep -= 1;
              });
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: [
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Avanti'),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Indietro'),
                  ),
                ],
              );
            },
          ),
        ));
  }

  Step _buildCustomStep(int index, String title, Widget content) {
    return Step(
      title: FittedBox(
        child: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ),
      content: content,
      isActive: _currentStep >= index,
      state: _currentStep == index ? StepState.editing : StepState.complete,
    );
  }

  Widget _title(String data) {
    return Text(data,
        style: const TextStyle(
            fontFamily: 'DM Sans', fontSize: 28, fontWeight: FontWeight.w600));
  }

  Widget _subtitle(String data) {
    return Text(data,
        style: TextStyle(
            fontFamily: 'DM Sans',
            fontSize: 16,
            color: AppColors.light.secondaryText));
  }

  Widget _buildIntroStep() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Introduzione'),
        _subtitle(
            'Scopri le potenzialità di Quomia attraverso questo video introduttivo.'),
      ],
    );
  }

  Widget _buildBoxTypeStep() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title('Tipologia Box'),
        const SizedBox(
          height: 5.0,
        ),
        _subtitle('Scegli il box che più ti si addice'),
        const SizedBox(
          height: 10.0,
        ),
        _boxTypeCard(
            'Future',
            'Condividi un momento nel futuro con la persona cara.',
            'https://picsum.photos/seed/37/600'),
        const SizedBox(
          height: 10.0,
        ),
        _boxTypeCard(
            'Rewind',
            'Condividi un momento del passato con la persona cara.',
            'https://picsum.photos/seed/37/600'),
        const SizedBox(
          height: 10.0,
        ),
        _boxTypeCard('Message in a bottle', 'Rendi virale il tuo box.',
            'https://picsum.photos/seed/37/600')
      ],
    );
  }

  Widget _boxTypeCard(String title, String caption, String imagePath) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.light.primaryBackground,
                AppColors.light.secondary
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(-1, 0),
              end: const AlignmentDirectional(1, 0),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w600)),
                    Text(caption,
                        style: const TextStyle(
                            fontFamily: 'DM Sans', fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _boxType = title.toLowerCase();
            _currentStep += 1;
          });
        },
      ),
    );
  }

  Widget _categoryCard(String title, IconData icon) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        child: Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.light.primaryBackground,
                AppColors.light.secondary
              ],
              stops: const [0, 1],
              begin: const AlignmentDirectional(0, -1),
              end: const AlignmentDirectional(0, 1),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 10),
                FaIcon(
                  icon,
                  color: AppColors.light.primaryText,
                  size: 48,
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          setState(() {
            _boxCategory = title.toLowerCase();
            _currentStep += 1;
          });
        },
      ),
    );
  }

  Widget _categoryStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Categoria Box'),
            const SizedBox(height: 5.0),
            _subtitle('Che categoria di Box desideri acquistare?'),
            SizedBox(
              height: 300,
              child: GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                scrollDirection: Axis.vertical,
                children: [
                  _categoryCard('Video', FontAwesomeIcons.video),
                  _categoryCard('Immagine', FontAwesomeIcons.image),
                  _categoryCard('Testo', FontAwesomeIcons.envelopeOpenText),
                  _categoryCard('Audio', FontAwesomeIcons.fileAudio)
                ],
              ),
            ),
          ]),
    );
  }
}
