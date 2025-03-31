import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readconnect/providers/book_provider.dart';
import 'package:readconnect/widgets/book_card.dart';

class LibraryDashboardScreen extends ConsumerWidget {
  const LibraryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.library_books), text: 'Books'),
              Tab(icon: Icon(Icons.request_page), text: 'Requests'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/add-book');
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Books Tab
            books.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (books) {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return BookCard(
                      book: books[index],
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/book-details',
                        arguments: books[index],
                      ),
                    );
                  },
                );
              },
            ),
            // Requests Tab
            const Center(child: Text('Book requests will appear here')),
          ],
        ),
      ),
    );
  }
}