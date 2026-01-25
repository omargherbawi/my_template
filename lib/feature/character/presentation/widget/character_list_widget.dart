import 'dart:async';
import '../../../../global_imports.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/entities/sub_entities/paginated_response.dart';
import '../cubit/character_cubit.dart';
import 'character_card_widget.dart';

class CharacterListWidget extends StatefulWidget {
  final List<CharacterEntity> characters;
  final Pagination pagination;
  final bool isLoadingMore;

  const CharacterListWidget({
    super.key,
    required this.characters,
    required this.pagination,
    this.isLoadingMore = false,
  });

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  final ScrollController scrollController = ScrollController();
  Timer? _scrollDebounceTimer;
  bool _hasTriggeredLoadMore = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    _scrollDebounceTimer?.cancel();
    super.dispose();
  }

  void onScroll() {
    final threshold = scrollController.position.maxScrollExtent - 200;
    final currentPosition = scrollController.position.pixels;
    
    if (currentPosition >= threshold && !_hasTriggeredLoadMore) {
      _scrollDebounceTimer?.cancel();
      
      _hasTriggeredLoadMore = true;
      
      _scrollDebounceTimer = Timer(const Duration(milliseconds: 300), () {
        if (mounted) {
          context.read<CharacterCubit>().loadMoreCharacters().then((_) {
            if (mounted) {
              _hasTriggeredLoadMore = false;
            }
          });
        }
      });
    } else if (currentPosition < threshold - 100) {
      _hasTriggeredLoadMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        double childAspectRatio = 0.75;
        
        if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
          childAspectRatio = 0.8;
        }
        if (constraints.maxWidth > 900) {
          crossAxisCount = 4;
          childAspectRatio = 0.85;
        }
        
        if (widget.characters.isEmpty) {
          return const Center(
            child: Text(
              'No characters found',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final character = widget.characters[index];
                    return CharacterCardWidget(
                      character: character,
                      onTap: () {
                        context.push('${AppRoutes.characterDetail}?id=${character.id}');
                      },
                    );
                  },
                  childCount: widget.characters.length,
                ),
              ),
            ),
            if (widget.isLoadingMore || widget.pagination.hasMore)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: widget.isLoadingMore
                      ? const Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            CircularProgressIndicator(),
                            SizedBox(height: 8),
                            Text(
                              'Loading more characters...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : widget.pagination.hasMore
                          ? const Text(
                              'Scroll to load more...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            )
                          : const Text(
                              'No more characters',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                ),
              ),
          ],
        );
      },
    );
  }
}