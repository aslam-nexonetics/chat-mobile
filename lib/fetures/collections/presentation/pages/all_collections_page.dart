import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_cubit.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_state.dart';
import 'package:chat_mobile/fetures/user/presentation/cubit/user_cubit.dart';
import 'package:chat_mobile/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class AllCollectionsPage extends StatefulWidget {
  const AllCollectionsPage({super.key});

  @override
  _AllCollectionsPageState createState() => _AllCollectionsPageState();
}

class _AllCollectionsPageState extends State<AllCollectionsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load collections when the page initializes
    context.read<CollectionsCubit>().getAllCollections();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get isWebOrDesktop =>
      kIsWeb ||
      Theme.of(context).platform == TargetPlatform.windows ||
      Theme.of(context).platform == TargetPlatform.linux ||
      Theme.of(context).platform == TargetPlatform.macOS;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;

    return Scaffold(
      backgroundColor: isWebOrDesktop ? Colors.grey[50] : null,
      appBar:
          isWebOrDesktop
              ? null
              : AppBar(
                title: const Text(
                  'Add New Collection',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppColors.secondary,
                elevation: 0,
                foregroundColor: AppColors.white,
              ),
      body: Center(
        child: Container(
          width: isLargeScreen ? 1200 : screenWidth,
          margin:
              isWebOrDesktop
                  ? const EdgeInsets.symmetric(horizontal: 24)
                  : EdgeInsets.zero,
          child: Column(
            children: [
              // Web Header
              if (isWebOrDesktop) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 40 : 20,
                    vertical: isLargeScreen ? 40 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius:
                        isWebOrDesktop
                            ? BorderRadius.circular(16)
                            : const BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (Navigator.canPop(context))
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              tooltip: 'Back',
                            ),
                          const SizedBox(width: 8),
                          const Text(
                            'Discover Collections',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Find and join collections that interest you',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                      _buildSearchField(isLargeScreen),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Mobile Header with Search
              if (!isWebOrDesktop)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: _buildSearchField(false),
                ),
              // Collection List
              Expanded(
                child: BlocBuilder<CollectionsCubit, CollectionsState>(
                  builder: (context, state) {
                    if (state is CollectionsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else if (state is CollectionsError) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.exclamationmark_circle,
                                size: isLargeScreen ? 80 : 64,
                                color: AppColors.textPrimary.withOpacity(0.5),
                              ),
                              SizedBox(height: isLargeScreen ? 24 : 16),
                              Text(
                                state.message,
                                style: TextStyle(
                                  color: AppColors.textPrimary.withOpacity(0.7),
                                  fontSize: isLargeScreen ? 18 : 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isLargeScreen ? 24 : 16),
                              ElevatedButton(
                                onPressed:
                                    () =>
                                        context
                                            .read<CollectionsCubit>()
                                            .refreshCollections(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isLargeScreen ? 32 : 24,
                                    vertical: isLargeScreen ? 16 : 12,
                                  ),
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is CollectionsLoaded) {
                      if (state.filteredCollections.isEmpty) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  state.searchQuery.isEmpty
                                      ? CupertinoIcons.collections
                                      : CupertinoIcons.search,
                                  size: isLargeScreen ? 80 : 64,
                                  color: AppColors.textPrimary.withOpacity(0.5),
                                ),
                                SizedBox(height: isLargeScreen ? 24 : 16),
                                Text(
                                  state.searchQuery.isEmpty
                                      ? 'No collections found'
                                      : 'No collections match your search',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: isLargeScreen ? 18 : 16,
                                  ),
                                ),
                                if (state.searchQuery.isNotEmpty) ...[
                                  SizedBox(height: isLargeScreen ? 16 : 8),
                                  TextButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      context
                                          .read<CollectionsCubit>()
                                          .searchCollections('');
                                    },
                                    child: const Text('Clear search'),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<CollectionsCubit>().refreshCollections();
                        },
                        child: _buildCollectionsList(
                          state.filteredCollections,
                          isLargeScreen,
                        ),
                      );
                    }

                    return const Center(child: Text('Something went wrong'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isLargeScreen) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isLargeScreen ? 600 : double.infinity,
      ),
      child: CupertinoSearchTextField(
        placeholder: '   Search collections...',
        placeholderStyle: const TextStyle(color: Colors.white, fontSize: 16),
        style: const TextStyle(color: Colors.white),
        controller: _searchController,
        onChanged:
            (query) =>
                context.read<CollectionsCubit>().searchCollections(query),
        padding: EdgeInsets.symmetric(
          vertical: isLargeScreen ? 14 : 10,
          horizontal: 16,
        ),
        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.white),
        decoration: BoxDecoration(
          color: AppColors.disabled2,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _buildCollectionsList(
    List<Collection> collections,
    bool isLargeScreen,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine grid layout for large screens
    if (isLargeScreen && screenWidth > 1124) {
      return _buildGridLayout(collections, screenWidth);
    } else {
      return _buildListLayout(collections, isLargeScreen);
    }
  }

  Widget _buildGridLayout(List<Collection> collections, double screenWidth) {
    final crossAxisCount = screenWidth > 1400 ? 3 : 2;
    final childAspectRatio = screenWidth > 1400 ? 3.5 : 3.0;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
          return _buildCollectionCard(
            collection: collection,
            onTap: () => showJoinDialog(context, collection),
            isGrid: true,
          );
        },
      ),
    );
  }

  Widget _buildListLayout(List<Collection> collections, bool isLargeScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 40 : 20,
        vertical: isLargeScreen ? 20 : 10,
      ),
      child: ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
          return _buildCollectionCard(
            collection: collection,
            onTap: () => showJoinDialog(context, collection),
            isGrid: false,
          );
        },
      ),
    );
  }

  Widget _buildCollectionCard({
    required Collection collection,
    required VoidCallback onTap,
    required bool isGrid,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(
          vertical: isGrid ? 0 : (isLargeScreen ? 12 : 10),
        ),
        padding: EdgeInsets.all(isLargeScreen ? 20 : 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(isLargeScreen ? 20 : 15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: isLargeScreen ? 20 : 10,
              spreadRadius: isLargeScreen ? 1 : 2,
              offset: const Offset(0, 4),
            ),
          ],
          border:
              isWebOrDesktop
                  ? Border.all(color: Colors.grey.withOpacity(0.1), width: 1)
                  : null,
        ),
        child:
            isGrid
                ? _buildGridCardContent(collection, isLargeScreen)
                : _buildListCardContent(collection, isLargeScreen),
      ),
    );
  }

  Widget _buildListCardContent(Collection collection, bool isLargeScreen) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Container(
          padding: EdgeInsets.all(isLargeScreen ? 12 : 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(isLargeScreen ? 12 : 10),
          ),
          child: Icon(
            CupertinoIcons.circle_grid_3x3,
            color: AppColors.primary,
            size: isLargeScreen ? 36 : 30,
          ),
        ),
        SizedBox(width: isLargeScreen ? 20 : 15),
        // Collection Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                collection.collectionName ?? "Unnamed Collection",
                style: TextStyle(
                  fontSize: isLargeScreen ? 20 : 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isLargeScreen ? 8 : 5),
              Text(
                collection.collectionType,
                style: TextStyle(
                  fontSize: isLargeScreen ? 16 : 14,
                  color: AppColors.textPrimary.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        // Join Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 24 : 16,
              vertical: isLargeScreen ? 12 : 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isLargeScreen ? 25 : 20),
            ),
          ),
          child: Text(
            'Join',
            style: TextStyle(
              fontSize: isLargeScreen ? 16 : 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridCardContent(Collection collection, bool isLargeScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                CupertinoIcons.circle_grid_3x3,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Join',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          collection.collectionName ?? "Unnamed Collection",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Text(
          collection.collectionType,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  void showJoinDialog(BuildContext context, Collection collection) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;

    // Get the cubit instance from the current context
    final collectionsCubit = context.read<CollectionsCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: collectionsCubit, // Provide the cubit to the dialog
          child: BlocConsumer<CollectionsCubit, CollectionsState>(
            listener: (context, state) {
              if (state is CollectionsLoaded) {
                if (state.joinSuccess) {
                  // Close dialog and show success message
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Successfully joined "${collection.collectionName}"',
                      ),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  // Clear the join status
                  context.read<CollectionsCubit>().clearJoinStatus();
                } else if (state.joinError != null) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.joinError!),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            builder: (context, state) {
              final isJoining = state is CollectionsLoaded && state.isJoining;

              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isLargeScreen ? 24 : 20),
                ),
                contentPadding: EdgeInsets.all(isLargeScreen ? 32 : 24),
                title: Text(
                  'Join Collection',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: isLargeScreen ? 24 : 20,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Do you want to join "${collection.collectionName}"?',
                      style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
                    ),
                    if (isJoining) ...[
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Joining collection...'),
                        ],
                      ),
                    ],
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed:
                        isJoining
                            ? null
                            : () {
                              Navigator.of(dialogContext).pop();
                            },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 24 : 16,
                        vertical: isLargeScreen ? 12 : 8,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: isJoining ? Colors.grey : Colors.grey[600],
                        fontSize: isLargeScreen ? 16 : 14,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        isJoining
                            ? null
                            : () async {
                              // Get user ID from UserCubit
                              final userId =
                                  (sl<UserCubit>().state.user?.id ?? 0)
                                      .toString();

                              // Call join collection
                              context.read<CollectionsCubit>().joinCollection(
                                userId: userId,
                                collectionId: (collection.id).toString(),
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isJoining ? Colors.grey : AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isLargeScreen ? 24 : 16,
                        vertical: isLargeScreen ? 12 : 8,
                      ),
                    ),
                    child: Text(
                      isJoining ? 'Joining...' : 'Join',
                      style: TextStyle(
                        fontSize: isLargeScreen ? 16 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
