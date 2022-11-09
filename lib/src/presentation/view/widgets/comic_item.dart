import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/src/core/res/res.dart';
import 'package:marvel_hemisferio/src/domain/entities/item_entity.dart';

class ComicItem extends ConsumerStatefulWidget {
  final ItemEntity comic;

  const ComicItem({
    Key? key,
    required this.comic,
  }) : super(key: key);

  @override
  ConsumerState<ComicItem> createState() => _ComicItemState();
}

class _ComicItemState extends ConsumerState<ComicItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/home/comic/${widget.comic.getComicID}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 3),
        width: 40,
        height: 20,
        decoration: const BoxDecoration(
          color: UIColors.red100,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:4, left: 6),
          child: Text(
            widget.comic.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
