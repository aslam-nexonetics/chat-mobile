import 'package:chat_mobile/core/theme/app_colors.dart';
import 'package:chat_mobile/fetures/collections/domain/entities/collection_entity.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_cubit.dart';
import 'package:chat_mobile/fetures/collections/presentation/cubit/collections_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: [
          // Header with Search
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: CupertinoSearchTextField(
              placeholder: '   Search collections...',
              placeholderStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              style: const TextStyle(color: Colors.white),
              controller: _searchController,
              onChanged:
                  (query) =>
                      context.read<CollectionsCubit>().searchCollections(query),
              padding: const EdgeInsets.symmetric(vertical: 10),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                color: AppColors.disabled2,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          // Collection List
          Expanded(
            child: BlocBuilder<CollectionsCubit, CollectionsState>(
              builder: (context, state) {
                if (state is CollectionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (state is CollectionsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.exclamationmark_circle,
                          size: 64,
                          color: AppColors.textPrimary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.7),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              () =>
                                  context
                                      .read<CollectionsCubit>()
                                      .refreshCollections(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (state is CollectionsLoaded) {
                  if (state.filteredCollections.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            state.searchQuery.isEmpty
                                ? CupertinoIcons.collections
                                : CupertinoIcons.search,
                            size: 64,
                            color: AppColors.textPrimary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.searchQuery.isEmpty
                                ? 'No collections found'
                                : 'No collections match your search',
                            style: TextStyle(
                              color: AppColors.textPrimary.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          if (state.searchQuery.isNotEmpty) ...[
                            const SizedBox(height: 8),
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
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<CollectionsCubit>().refreshCollections();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: ListView.builder(
                        itemCount: state.filteredCollections.length,
                        itemBuilder: (context, index) {
                          final collection = state.filteredCollections[index];
                          return _buildCollectionCard(
                            collection: collection,
                            onTap: () => _showJoinDialog(context, collection),
                          );
                        },
                      ),
                    ),
                  );
                }

                return const Center(child: Text('Something went wrong'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionCard({
    required Collection collection,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.circle_grid_3x3,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            // Collection Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collection.collectionName ?? "Unnamed Collection",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    collection.collectionType,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Join Button
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context, Collection collection) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Join Collection',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            'Do you want to join "${collection.collectionName}"?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                // TODO: Implement join collection logic
                // You might want to add a join collection usecase and call it here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Join'),
            ),
          ],
        );
      },
    );
  }
}
