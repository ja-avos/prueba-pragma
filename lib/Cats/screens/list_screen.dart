import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_pragma/Cats/bloc/cats_cubit.dart';
import 'package:prueba_pragma/Cats/bloc/cats_state.dart';
import 'package:prueba_pragma/Cats/screens/widgets/cat_card.dart';
import 'package:prueba_pragma/config/request_state.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CatsCubit cubit = BlocProvider.of<CatsCubit>(context);
    cubit.fetchCats();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Catbreeds',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    suffixIcon: Icon(Icons.search),
                    suffixIconColor: Colors.grey,
                  ),
                  onChanged: (value) => cubit.filterCats(value),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<CatsCubit, CatState>(
                  builder: (context, state) {
                    if (state.state == RequestState.LOADING) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.state == RequestState.ERROR) {
                      return Text(state.error ?? '');
                    } else {
                      return ListView.builder(
                        itemCount: state.filteredCats.length,
                        itemBuilder: (context, index) {
                          return CatCard(cat: state.filteredCats[index]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
