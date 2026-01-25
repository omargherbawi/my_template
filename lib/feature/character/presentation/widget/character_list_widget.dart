import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';
import '../screens/character_detail_screen.dart';
import 'character_card_widget.dart';

class CharacterListWidget extends StatelessWidget {
  final CharacterResponse characterResponse;

  const CharacterListWidget({
    super.key,
    required this.characterResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info header
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Characters: ${characterResponse.info.count}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Page 1 of ${characterResponse.info.pages}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        // Character list
        Expanded(
          child: characterResponse.results.isEmpty
              ? const Center(
                  child: Text(
                    'No characters found',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: characterResponse.results.length,
                  itemBuilder: (context, index) {
                    final character = characterResponse.results[index];
                    return CharacterCardWidget(
                      character: character,
                      onTap: () {
                        context.push('${AppRoutes.characterDetail}?id=${character.id}');
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}