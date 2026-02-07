import 'package:flutter/material.dart';

import '../../../../global_imports.dart';
import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';
import '../widget/character_item.dart';

class AllCharacterScreen extends StatelessWidget {
  const AllCharacterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 97, 233, 102),
        title:  const Column(
          children: [
             Text(
              'Rick & Morty Characters',
              
              style: TextStyle(color: Colors.black),
            ),
              SizedBox(height: 10),
            TextField(
              cursorColor: Colors.black,
              textAlign: TextAlign.start,
              decoration:  InputDecoration(
                hintText: 'search',
                hintStyle:  TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                suffixIcon:  Icon(Icons.search, color: Colors.black,) ,
                
                border:  OutlineInputBorder(
                  
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              ),
            ),
          ],
        ),
      ),
      body:
          BlocBuilder<CharacterCubit, CharacterState>(
            builder: (context, state) {
              if (state is CharacterLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CharacterError) {
                return Center(child: Text(state.message));
              }
              if (state is CharacterLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 244,
                  ),
                  itemCount: state.characters.length,
                  itemBuilder: (context, index) => CharacterItem(character: state.characters[index]),
                );
              }
              return const SizedBox.shrink();
            },
          ),
    );
  }
}
