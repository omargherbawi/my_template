import '../../../../global_imports.dart';
import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';
import '../widget/character_detail_widget.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;

  const CharacterDetailScreen({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Character Details'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => getIt<CharacterCubit>()..getCharacter(characterId),
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharacterDetailLoaded) {
              return CharacterDetailWidget(character: state.character);
            } else if (state is CharacterError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.title ?? 'Error',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CharacterCubit>().getCharacter(characterId);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}