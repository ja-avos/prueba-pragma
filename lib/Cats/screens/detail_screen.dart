import 'package:flutter/material.dart';
import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatelessWidget {
  final Cat? cat;
  const DetailScreen({Key? key, this.cat}) : super(key: key);

  String snakeCaseToTitleCase(String text) {
    final words = text.split('_');
    return words
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget buildInfoTile(String title, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          snakeCaseToTitleCase(title),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value.toString()),
        ),
        const Divider(),
      ],
    );
  }

  Widget buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cat?.additionalProperties.keys
              .map((e) => buildInfoTile(e, cat!.additionalProperties[e]!))
              .toList() ??
          [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    cat?.name ?? 'No breed',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 0,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          cat?.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: cat!.image!,
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
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoTile("ID", cat?.id ?? ''),
                    buildInfoTile("Description", cat?.description ?? ''),
                    buildInfoTile("Origin", cat?.origin ?? ''),
                    buildInfoTile(
                        "Intelligence", cat?.intelligence.toString() ?? ''),
                    buildAdditionalInfo()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
