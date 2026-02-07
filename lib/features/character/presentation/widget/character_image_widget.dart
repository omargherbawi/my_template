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
          placeholder: (_, __) => Container(
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.person, size: 80, color: Colors.grey),
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.broken_image_outlined, size: 80, color: Colors.grey),
            ),
          ),
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
