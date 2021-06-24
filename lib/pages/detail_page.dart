import 'package:flutter/material.dart';
import 'package:pokedex_tarde/helpers/poke_helper.dart';
import 'package:pokedex_tarde/models/pokemon_model.dart';
import 'package:pokedex_tarde/widgets/horizontal_bar.dart';
import 'package:pokedex_tarde/widgets/metric_tile.dart';
import 'package:pokedex_tarde/widgets/poke_header.dart';
import 'package:pokedex_tarde/widgets/poke_type_chip.dart';

class DetailPage extends StatefulWidget {
  final PokemonModel pokemon;

  const DetailPage({
    Key key,
    this.pokemon,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: PokeHelper.getColor(widget.pokemon.type1),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            width: 80,
            height: 52,
            child: Center(
              child: Text(
                '#${widget.pokemon.id.toString().padLeft(3, '0')}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PokeHeader(
              imageUrl: widget.pokemon.imageUrl,
              backgroundColor: PokeHelper.getColor(widget.pokemon.type1),
            ),
            _buildMetrics(),
            _buildTypeChips(),
            _buildStatistics(),
          ],
        ),
      ),
    );
  }

  _buildStatistics() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          Text(
            'Statistics',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          HorizontalBar(
            label: 'HP',
            value: widget.pokemon.health,
            foregroundColor:
                PokeHelper.getColor(widget.pokemon.type1).withOpacity(1.0),
          ),
          HorizontalBar(
            label: 'ATK',
            value: widget.pokemon.attack,
            foregroundColor:
                PokeHelper.getColor(widget.pokemon.type1).withOpacity(0.8),
          ),
          HorizontalBar(
            label: 'DEF',
            value: widget.pokemon.defense,
            foregroundColor:
                PokeHelper.getColor(widget.pokemon.type1).withOpacity(0.6),
          ),
          HorizontalBar(
            label: 'SPD',
            value: widget.pokemon.speed,
            foregroundColor:
                PokeHelper.getColor(widget.pokemon.type1).withOpacity(0.4),
          ),
          HorizontalBar(
            label: 'Exp Base',
            value: widget.pokemon.baseexp,
            foregroundColor: PokeHelper.getColor(widget.pokemon.type1).withOpacity(0.4),
          )
        ],
      ),
    );
  }

  _buildTypeChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PokeTypeChip(type: widget.pokemon.type1),
        SizedBox(width: widget.pokemon.type2 != null ? 20.0 : 0.0),
        widget.pokemon.type2 != null
            ? PokeTypeChip(type: widget.pokemon.type2)
            : SizedBox(),
      ],
    );
  }

  _buildMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MetricTile(
          label: 'Weight',
          unit: 'kg',
          value: widget.pokemon.weight / 10.0,
        ),
        MetricTile(
          label: 'Height',
          unit: 'm',
          value: widget.pokemon.height / 10.0,
        ),
      ],
    );
  }
}
