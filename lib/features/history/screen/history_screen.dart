import 'package:flutter/material.dart';
import 'package:xo_app/data/services/game_record_dao.dart';
import 'package:xo_app/features/history/widgets/history_card.dart';

import '../../game/bloc/record/game_record_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<List<MoveRecord>> _games = [];

  @override
  void initState() {
    super.initState();
    _loadGameHistory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadGameHistory() async {
    final games = await GameRecordDao().loadAllGameRecords();
    for (var game in games) {
      debugPrint('Game moves: $game');
    }
    setState(() {
      _games = games;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Text(
          'Game History',
          style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
      ),
      body: _games.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: HistoryCard(moves: _games[index]),
          );
        },
      ),
    );
  }
}
