import 'package:flutter/material.dart';
import 'package:peliculas_flutter/models/pelicula_model.dart';

class PeliculaDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20.0,),
                _posterTitulo(context, pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
                _descripcionPelicula(pelicula),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula){
    return SliverAppBar(
      actions: <Widget>[],
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcionPelicula(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}