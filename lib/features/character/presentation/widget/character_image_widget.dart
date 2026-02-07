import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';

class CharacterImage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterImage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: character.image,
          width: double.infinity,
          height: 330,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 50,
          left: 10,
          child: IconButton(
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        Positioned(
          top: 270,
          left: 120,
          child: Text(
            character.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
