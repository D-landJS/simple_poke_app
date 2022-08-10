import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_poke_app/models/pokemon.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text(pokemon.name!),
        centerTitle: true,
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext ctx) => Stack(
        children: [
          Positioned(
            height: MediaQuery.of(ctx).size.height / 1.5,
            width: MediaQuery.of(ctx).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(ctx).size.height * 0.12,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 70.0,
                    ),
                    Text(
                      pokemon.name!,
                      style: GoogleFonts.amaranth(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    Text(
                      "Height: ${pokemon.height}",
                      style: GoogleFonts.amaranth(),
                    ),
                    Text(
                      "Weight: ${pokemon.weight}",
                      style: GoogleFonts.amaranth(),
                    ),
                    Text("Types",
                        style:
                            GoogleFonts.amaranth(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type!
                          .map((t) => FilterChip(
                              backgroundColor: Colors.amber,
                              label: Text(
                                t,
                                style: GoogleFonts.amaranth(),
                              ),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                    Text('Weakness',
                        style:
                            GoogleFonts.amaranth(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses!
                          .map((w) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(
                                w,
                                style:
                                    GoogleFonts.amaranth(color: Colors.white),
                              ),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                    Text('Next Evolution',
                        style:
                            GoogleFonts.amaranth(fontWeight: FontWeight.bold)),
                    pokemon.nextEvolution == null
                        ? noEvolution(Colors.red)
                        : nextEvolution(Colors.green)
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img!,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(pokemon.img!))),
              ),
            ),
          )
        ],
      );

  Widget nextEvolution(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: pokemon.nextEvolution!
          .map((n) => FilterChip(
              backgroundColor: color,
              label: Text(
                n.name!,
                style: GoogleFonts.amaranth(color: Colors.white),
              ),
              onSelected: (b) {}))
          .toList(),
    );
  }

  Widget noEvolution(Color color) {
    return Text(
      'This is the most evolved form of this Pokemon',
      style: GoogleFonts.amaranth(fontSize: 12.0, color: Colors.redAccent),
    );
  }
}
