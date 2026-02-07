import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';

class CharacterItem extends StatelessWidget {
  final CharacterEntity character;
  const CharacterItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        context.push(AppRoutes.characterDetailPath(character.id));
      },
      child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              child: CachedNetworkImage(imageUrl: character.image, width: 180, height: 150, fit: BoxFit.cover,)),
            Container(
              width: 180,
              height: 90,
              decoration: const BoxDecoration(
               
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
                color: Color.fromARGB(255, 221, 248, 222),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Text(character.name, style:  const TextStyle(fontSize: 18 , fontWeight: FontWeight.bold ,color: Colors.black)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      
                        Text(  
                          character.status,
                          style:  const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const Text(  
                          '-',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                         Text(  
                          character.species,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                          Container(
                          width: 10,
                          height: 10,
                          decoration:  BoxDecoration(
                            color:character.status == "Alive" ? Colors.green : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],  
                    ),
                  ],
                ),
              ),
            ),
          ],
        
      ),
    );
  }
}
