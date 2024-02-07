import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hotelflutter/SessionManager.dart';
import 'package:hotelflutter/database.dart';
import 'package:hotelflutter/home_screen.dart';

class Reservation extends StatefulWidget {
  final String imageUrl;
  final String label;
  final double price;
  final String description;
   

  const Reservation({
    required this.imageUrl,
    required this.label,
    required this.price,
    required this.description,
    Key? key, 
  }) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
   DateTime? _startDate=null;
   DateTime? _endDate=null; // Example: 7 days from now
  late  double pri=0;
  int jours=0;
  @override
  void initState() {
    super.initState();
    pri = widget.price;
  }
  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(widget.imageUrl)
            ),
            buttonArrow(),
            scroll()
          ]),
      ),
    );
  }
  buttonArrow(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child:InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
        },
      
      child:Container(
      clipBehavior: Clip.hardEdge,
      height: 55,
      width:  55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25)
      ),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Container(
      height: 55,
      width:  55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25)
      ),
      child: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: Colors.white,
      ),
      )
    )
      )
      )
    );
  }

  scroll(){
    return DraggableScrollableSheet(
      initialChildSize: 0.63,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context,ScrollController){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          
          
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            controller: ScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(
                    height: 5,width: 35,color: Colors.grey,
                  )],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alignement horizontal des éléments
                  children: [
                    Text(
                      
                      widget.label,
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade300),
                      
                    ),
                    Text(
                    (pri ?? widget.price).toString() + " Dh/nuits",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue.shade300),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child:  Divider(
                  height: 4,
                ),
                ),
                Text("Description",
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue.shade300)),
                SizedBox(height: 10,),
                Text(widget.description,
                style: TextStyle(
                  color: Colors.grey.shade600
                )),
                const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child:  Divider(
                  height: 4,
                ),
                ),
                Text("Dure",
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue.shade300)),
                SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    tileColor: Colors.lightBlueAccent, // Couleur de fond bleu ciel
                    title: Text(
                      'Sélectionnez la période',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // Gras
                        color: Colors.black, // Texte en noir sur fond bleu ciel
                      ),
                    ),
                    subtitle: _startDate != null && _endDate != null
                        ? Text(
                            '${_startDate!.day}/${_startDate!.month}/${_startDate!.year} - ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black, // Texte en noir sur fond bleu ciel
                            ),
                          )
                        : Text(''),
                    trailing: Icon(
                      Icons.calendar_today,
                      size: 30, // Taille de l'icône agrandie
                      color: Colors.black, // Couleur de l'icône en noir sur fond bleu ciel
                    ),
                    onTap: _pickDateRange,
                  ),
                  SizedBox(height: 20,),
                  const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child:  Divider(
                  height: 4,
                ),
                ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0), // Ajouter du padding horizontal
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async{
                        Map<String,dynamic>? infos; // Déclaration de la variable infos comme nullable

                        if (_startDate != null && _endDate != null) {
                          infos={
                            "label":widget.label,
                            "prix":pri,
                            "dated":_startDate,
                            "datef":_endDate,
                            "userid":SessionM.userId,
                            "jour":jours,
                          };
                        }

                        if (infos != null) {
                          bool success = await Database().ajouterReservation(infos);
                          if (success) {
                            _showSuccessDialog(); // Affiche le dialogue de réussite
                          } else {
                            _showErrorDialog(); // Affiche le dialogue d'erreur
                          }
                        } else {
                          // Afficher une boîte de dialogue ou un message indiquant que tous les champs doivent être remplis
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.warning, color: Colors.yellow), // icône d'avertissement à gauche du titre
                                    SizedBox(width: 10), // espace entre l'icône et le texte
                                    Text(
                                      'Champs incomplets',
                                      style: TextStyle(
                                        color:  Colors.black, // couleur jaune pour le titre
                                        fontWeight: FontWeight.bold, // texte en gras
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text('Veuillez sélectionner une période pour effectuer la réservation.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Ferme le dialogue
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10), // ajout de rembourrage
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white), // couleur du texte en blanc
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.yellow), // couleur de fond rouge
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        },
                        child: Text('Reserver',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),), // Texte du bouton
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Couleur de fond du bouton
                          textStyle: TextStyle(fontSize: 20), // Style du texte du bouton
                          padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15), // Espacement intérieur du bouton
                        ),
                      ),
                    ),
                  ),

                
            
            
            ],),
          ),
        );
      });
  }
  void _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 365)),
    initialDateRange: DateTimeRange(
      start: _startDate ?? DateTime.now(), // Utilisation de DateTime.now() si _startDate est null
      end: _endDate ?? DateTime.now(), // Utilisation de DateTime.now() si _endDate est null
    ),
  );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;

        Duration difference = _endDate!.difference(_startDate!);
        jours = difference.inDays;
        if (jours >0){
          pri=widget.price*jours;
        }
      });
    }
  }
  void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green), // icône de succès à gauche du titre
            SizedBox(width: 10), // espace entre l'icône et le texte
            Text(
              'Réservation réussie',
              style: TextStyle(
                color: Colors.green, // couleur verte pour le titre
                fontWeight: FontWeight.bold, // texte en gras
              ),
            ),
          ],
        ),
        content: Text('Réservation effectuée avec succès. Merci pour votre confiance !'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())); // Ferme le dialogue et remplace l'écran actuel par HomeScreen
            },
            child: Padding(
              padding: EdgeInsets.all(10), // ajout de rembourrage
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white), // couleur du texte en blanc
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green), // couleur de fond verte
            ),
          ),
        ],
      );
    },
  );
}

  void _showErrorDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red), // icône d'erreur à gauche du titre
            SizedBox(width: 10), // espace entre l'icône et le texte
            Text(
              'Erreur de réservation',
              style: TextStyle(
                color: Colors.red, // couleur rouge pour le titre
                fontWeight: FontWeight.bold, // texte en gras
              ),
            ),
          ],
        ),
        content: Text('Réservation impossible. Veuillez réessayer plus tard.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Ferme le dialogue
            },
            child: Padding(
              padding: EdgeInsets.all(10), // ajout de rembourrage
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white), // couleur du texte en blanc
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red), // couleur de fond rouge
            ),
          ),
        ],
      );
    },
  );
}
}
