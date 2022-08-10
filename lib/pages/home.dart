import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_poke_app/models/pokemon.dart';
import 'package:simple_poke_app/pages/pokemon_detail.dart';
import 'package:simple_poke_app/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub = PokeHub();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future fetchData() async {
    setState(() {
      isLoading = true;
    });
    ApiServices.getPokemons().then((res) {
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);

        pokeHub = PokeHub?.fromJson(result);
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load Pokemon');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
        backgroundColor: const Color(0xEB0E999E),
      ),
      body: isLoading ? _loading() : _pokeUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _pokeUI() {
    return GridView.count(
      crossAxisCount: 2,
      children: pokeHub.pokemon!
          .map((poke) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokeDetail(pokemon: poke),
                        ));
                  },
                  child: Hero(
                    tag: poke.img!,
                    child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(poke.img!))),
                            ),
                            Text(
                              poke.name!,
                              style: GoogleFonts.amaranth(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _loading() {
    final modal = Stack(
      children: const [
        Opacity(
          opacity: 0.8,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.greenAccent,
          ),
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );

    return modal;
  }
}
