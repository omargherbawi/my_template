import '../../../../global_imports.dart';
import '../cubit/character_detail_cubit.dart';
import '../cubit/character_detail_state.dart';
import '../widget/character_image_widget.dart';
import '../widget/info_row_widget.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailCubit, CharacterDetailState>(
      builder: (context, state) {
        if (state is CharacterDetailLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CharacterDetailError) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        }
        if (state is CharacterDetailLoaded) {
          final character = state.character;
          return Scaffold(
            body: Column(
              children: [
                CharacterImage(character: character),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 226, 246, 202),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Information",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: const Color.fromARGB(255, 190, 189, 189),
                            thickness: 1,
                            height: 20,
                          ),
                        ),
                        InfoRow(title: "Gender", value: character.gender),
                        InfoRow(title: "Species", value: character.species),
                        InfoRow(title: "Status", value: character.status),
                        InfoRow(
                            title: "Episode",
                            value: character.episodes.length.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }
}
