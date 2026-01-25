import '../../../../global_imports.dart';
import '../cubit/product_cubit.dart';
import '../widget/product_input_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Rick &Morty Character'),
      ),
      body: BlocProvider(
        create: (context) => getIt<ProductCubit>(),
        child: const ProductInputWidget(),
      ),
    );
  }
}
