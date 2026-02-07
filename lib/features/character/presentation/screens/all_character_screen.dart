
import '../../../../global_imports.dart';
import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';
import '../widget/character_item.dart';

class AllCharacterScreen extends StatefulWidget {
  const AllCharacterScreen({super.key});

  @override
  State<AllCharacterScreen> createState() => _AllCharacterScreenState();
}

class _AllCharacterScreenState extends State<AllCharacterScreen> {
    final ScrollController scrollController = ScrollController();
    @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
  if (scrollController.position.pixels >=
      scrollController.position.maxScrollExtent - 200) {
    context.read<CharacterCubit>().getAllCharacters();
  }
});

  }

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
          RefreshIndicator(
            color: Colors.green,
            onRefresh: () async {
              context.read<CharacterCubit>().getAllCharacters(refresh: true);
            },
            child: BlocBuilder<CharacterCubit, CharacterState>(
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
    controller: scrollController,

    itemCount: state.characters.length + 1,

    itemBuilder: (context, index) {

      if (index == state.characters.length) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(color: Colors.green),
          ),
        );
      }

      return CharacterItem(
        character: state.characters[index],
      );
    },
  );
}

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
return const SizedBox.shrink();
              },
            ),
          ),
    );
  }
}
