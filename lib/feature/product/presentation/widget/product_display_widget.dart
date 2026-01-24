import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import '../../../../global_imports.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class ProductDisplayWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductDisplayWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          AppButton.text(
            text: 'Back to Search',
            onPressed: () {
              context.read<ProductCubit>().emit(ProductInitial());
            },
            color: AppColor.primaryColor,
            height: 40,
          ),
          20.gap,
          
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CacheNetworkImagePlus(
              imageUrl: product.image,
              width: double.infinity,
              height: 300.h,
              
            ),
          ),
          20.gap,
          
          // Product Name and Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AutoSizeText(
                  product.name,
                  style: AppTextStyle.style24B,
                  maxLines: 2,
                  minFontSize: 18,
                  maxFontSize: 24,
                ),
              ),
              16.gap,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AutoSizeText(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTextStyle.style20B.copyWith(
                    color: AppColor.white,
                  ),
                  maxLines: 1,
                  minFontSize: 16,
                  maxFontSize: 20,
                ),
              ),
            ],
          ),
          20.gap,
          
          // Divider
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          20.gap,
          
          // Description Title
          Text(
            'Description',
            style: AppTextStyle.style18B,
          ),
          12.gap,
          
          // Product Description
          AutoSizeText(
            product.description,
            style: AppTextStyle.style16.copyWith(
              color: Colors.grey[700],
              height: 1.5,
            ),
            maxLines: 20,
            minFontSize: 14,
            maxFontSize: 16,
          ),
        ],
      ),
    );
  }
}
