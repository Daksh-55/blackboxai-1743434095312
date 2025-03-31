import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readconnect/providers/book_provider.dart';

class RequestBookScreen extends ConsumerStatefulWidget {
  const RequestBookScreen({super.key});

  @override
  ConsumerState<RequestBookScreen> createState() => _RequestBookScreenState();
}

class _RequestBookScreenState extends ConsumerState<RequestBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _requestNote = '';
  bool _isSubmitting = false;

  Future<void> _submitRequest(Book book) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isSubmitting = true);
    try {
      // TODO: Implement request submission logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate network call
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book request submitted successfully')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting request: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = ModalRoute.of(context)!.settings.arguments as Book;

    return Scaffold(
      appBar: AppBar(title: Text('Request ${book.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Additional Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onSaved: (value) => _requestNote = value ?? '',
              ),
              const SizedBox(height: 24),
              Text(
                'Book Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.book),
                title: Text(book.title),
                subtitle: Text(book.author),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => _submitRequest(book),
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Submit Request'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}