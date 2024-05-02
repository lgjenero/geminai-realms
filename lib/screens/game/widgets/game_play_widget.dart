import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';
import 'package:geminai_realms/game/state/game_state.dart';
import 'package:geminai_realms/screens/game/widgets/game_play_input_widget.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class GamePlayWidget extends ConsumerStatefulWidget {
  const GamePlayWidget({super.key});

  @override
  ConsumerState<GamePlayWidget> createState() => _GamePlayWidgetState();
}

class _GamePlayWidgetState extends ConsumerState<GamePlayWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<_GamePlayItem> _items = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _items.addAll(_generateItems(ref.read(gameStateProvider)));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameStateProvider, (previous, next) {
      final items = _generateItems(next);

      if (items.length == _items.length) return;

      if (items.length > _items.length) {
        final toAdd = items.length - _items.length;
        for (int i = toAdd - 1; i >= 0; i--) {
          _items.insert(0, items[i]);
          _listKey.currentState!.insertItem(0);
        }
      } else if (items.length < _items.length) {
        final toRemove = _items.length - items.length;
        for (int i = 0; i < toRemove; i++) {
          _items.removeAt(0);
          _listKey.currentState!
              .removeItem(0, (context, animation) => _items[i].render(context, ref, SizeLayout.small));
        }
      }

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    return SizeLayoutBuilder(
      small: (_, __) => _buildContent(context, SizeLayout.small),
      medium: (_, __) => _buildContent(context, SizeLayout.medium),
      large: (_, __) => _buildContent(context, SizeLayout.large),
    );
  }

  Widget _buildContent(BuildContext context, SizeLayout size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: AnimatedList(
            key: _listKey,
            controller: _scrollController,
            initialItemCount: _items.length,
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            itemBuilder: (context, index, animation) {
              final item = _items[index];
              return FadeTransition(opacity: animation, child: item.render(context, ref, size));
            },
          ),
        ),
        const GamePlayInputWidget(),
      ],
    );
  }

  List<_GamePlayItem> _generateItems(GameStateData data) {
    final items = <_GamePlayItem>[];
    items.add(_GamePlayItem(id: 'reaml', imageUrl: data.gameData.realm.image));

    if (data.gameData.world != null) items.add(_GamePlayItem(id: 'world', text: data.gameData.world));
    if (data.gameData.character != null) items.add(_GamePlayItem(id: 'character', text: data.gameData.character));
    if (data.gameData.intro != null) items.add(_GamePlayItem(id: 'intro', text: data.gameData.intro));

    for (int i = 0; i < data.gameData.chapters.length; i++) {
      final chapter = data.gameData.chapters[i];

      // items.add(_GamePlayItem(id: 'chapter-$i', text: 'Location: ${chapter.location}\n${chapter.situation}'));
      // items.add(_GamePlayItem(id: 'chapter-$i', text: chapter.intro));

      for (int j = 0; j < chapter.events.length; j++) {
        final event = chapter.events[j];
        items.add(_GamePlayItem(
          id: 'chapter-$i-event-$j',
          text: event.callForAction,
          chapter: i,
          event: j,
        ));

        if (event.selectedAction != null) {
          items.add(_GamePlayItem(id: 'chapter-$i-event-$j-action', text: 'You: ${event.selectedAction}'));
          if (event.result != null) {
            items.add(_GamePlayItem(id: 'chapter-$i-event-$j-result', text: event.result));
          }
        }
      }

      if (chapter.finishText != null) {
        items.add(_GamePlayItem(id: 'chapter-$i-finished', text: chapter.finishText));
      }
    }

    if (data.status == GameStatus.died) {
      items.add(_GamePlayItem(id: 'died', died: true));
    } else if (data.status == GameStatus.gameOver) {
      items.add(_GamePlayItem(id: 'gameOver', gameOver: true));
    }

    // print('Generated items: $items');

    return items.reversed.toList();
  }
}

class _GamePlayItem {
  final String id;
  final String? text;
  final String? imageUrl;
  final bool died;
  final bool gameOver;
  final int? chapter;
  final int? event;

  _GamePlayItem(
      {required this.id, this.text, this.imageUrl, this.died = false, this.gameOver = false, this.chapter, this.event});

  @override
  String toString() {
    return 'GamePlayItem(id: $id, text: $text, imageUrl: $imageUrl, died: $died, gameOver: $gameOver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GamePlayItem && (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => id.hashCode;

  Widget render(BuildContext context, WidgetRef ref, SizeLayout size) {
    if (died) {
      final font = AppFonts.instance.realmText(size);
      return Center(
        child: Text(
          '~~ You died ~~',
          style: font.copyWith(color: AppColors.gameForeground, fontSize: font.fontSize! * 2),
        ),
      );
    }

    if (gameOver) {
      final font = AppFonts.instance.realmText(size);
      return Center(
        child: Text(
          '~~ The End ~~',
          style: font.copyWith(color: AppColors.gameForeground, fontSize: font.fontSize! * 2),
        ),
      );
    }

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (imageUrl != null)
          Center(
            child: LimitedBox(
              maxWidth: 400,
              maxHeight: 400,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(imageUrl!, fit: BoxFit.contain),
              ),
            ),
          ),
        if (imageUrl != null && text != null) const SizedBox(height: 12.0),
        if (text != null)
          Text(
            text ?? '',
            style: AppFonts.instance.realmText(size).copyWith(color: AppColors.gameForeground),
          ),
      ],
    );

    if (chapter != null && event != null) {
      content = InkWell(
        onTap: () => ref.read(gameStateProvider.notifier).rewindToEvent(context, size, chapter!, event!),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.gameForeground.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  Text(
                    'Story Branching',
                    style: AppFonts.instance.realmText(size).copyWith(fontSize: 12, color: AppColors.gameForeground),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.fork_right_rounded, color: AppColors.gameForeground, size: 16),
                ],
              ),
              const SizedBox(height: 8),
              content,
            ],
          ),
        ),
      );
    }

    return Padding(padding: const EdgeInsets.fromLTRB(12, 0, 12, 12), child: content);
  }
}
