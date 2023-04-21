import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_pragma/Cats/bloc/cats_cubit.dart';
import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  const CatCard({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final catCubit = BlocProvider.of<CatsCubit>(context);

    // Returns a card with the cat's image, name, country, and intelligence
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cat.name, style: const TextStyle(fontSize: 18)),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/detail', arguments: cat),
                    child: const Text("More",
                        style: TextStyle(fontSize: 18, color: Colors.blue)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: cat.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: cat.image!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : const Icon(Icons.pets),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Country: ${cat.origin}",
                      style: const TextStyle(fontSize: 16)),
                  Text("Intelligence: ${cat.intelligence}",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
