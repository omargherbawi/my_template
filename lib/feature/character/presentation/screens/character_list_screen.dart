import '../../../../global_imports.dart';
import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';
import '../widget/character_list_widget.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Rick & Morty Characters'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => getIt<CharacterCubit>()..getCharacters(),
        child: BlocBuilder<CharacterCubit, CharacterState>(
          builder: (context, state) {
            if (state is CharacterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharacterListLoaded) {
              return CharacterListWidget(characterResponse: state.characterResponse);
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
                        context.read<CharacterCubit>().getCharacters();
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