import '../../../../global_imports.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'product_display_widget.dart';

class ProductInputWidget extends StatefulWidget {
  const ProductInputWidget({super.key});

  @override
  State<ProductInputWidget> createState() => _ProductInputWidgetState();
}

class _ProductInputWidgetState extends State<ProductInputWidget> {
  final TextEditingController _productIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _productIdController.dispose();
    super.dispose();
  }

  void _fetchProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      final productId = int.tryParse(_productIdController.text.trim());
      if (productId != null) {
        context.read<ProductCubit>().getProduct(productId);
      } else {
        // Show error if invalid number
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid product ID'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        // If product is loaded, show product display
        if (state is ProductLoaded) {
          return ProductDisplayWidget(product: state.product);
        }

        // Otherwise show input form
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                40.gap,
                
                // Title
                Text(
                  'Enter Product ID',
                  style: AppTextStyle.style24B,
                  textAlign: TextAlign.center,
                ),
                30.gap,
                
                // Product ID Text Field
                AppTextFormField(
                  controller: _productIdController,
                  label: 'Product ID',
                  hintText: 'Enter product ID number',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a product ID';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _fetchProduct(),
                ),
                24.gap,
                
                // Fetch Button
                BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final isLoading = state is ProductLoading;
                    return AppButton.text(
                      text: isLoading ? 'Loading...' : 'Get Product',
                      onPressed: isLoading ? null : _fetchProduct,
                      color: AppColor.secondaryColor,
                    );
                  },
                ),
                
                // Error Message
                if (state is ProductError) ...[
                  20.gap,
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.red[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700]),
                        12.gap,
                        Expanded(
                          child: Text(
                            state.message,
                            style: AppTextStyle.style14.copyWith(
                              color: Colors.red[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
