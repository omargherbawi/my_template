import '../../../../global_imports.dart';
import '../cubit/character_cubit.dart';
import '../cubit/character_state.dart';
import '../widget/character_list_widget.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CharacterCubit>()..getCharacters(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Rick & Morty Characters'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.green,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search characters...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    ),
                    onChanged: (query) {
                      context.read<CharacterCubit>().searchCharacters(query);
                    },
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<CharacterCubit, CharacterState>(
                  builder: (context, state) {
                    if (state is CharacterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is CharacterListLoaded) {
                      return RefreshIndicator(
                        onRefresh: () => context.read<CharacterCubit>().getCharacters(refresh: true),
                        child: CharacterListWidget(
                          characters: state.characters,
                          pagination: state.pagination,
                          isLoadingMore: state.isLoadingMore,
                        ),
                      );
                    } else if (state is CharacterError) {
                      return RefreshIndicator(
                        onRefresh: () => context.read<CharacterCubit>().getCharacters(refresh: true),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
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
                                      context.read<CharacterCubit>().getCharacters(refresh: true);
                                    },
                                    child: const Text('Retry'),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Pull down to refresh',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
      ),
    ),
    );
  }
}