
import '../../../../global_imports.dart';

class InfoRow extends StatelessWidget {
  final String title ;
  final String value ;
  const InfoRow({
    super.key, required this.title, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: 
             
                Text(value),
       
            ),
          
          const SizedBox(width: 40),
          Text(":$title" , style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.grey)),
        ],
      ),
    );
  }
}
