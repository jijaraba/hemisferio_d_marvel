import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/dependencies.dart';
import 'package:marvel_hemisferio/src/core/presentation/theme/theme.dart';
import 'package:marvel_hemisferio/src/core/presentation/viewmodels/common_viewmodel_provider.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/widgets.dart';
import 'package:marvel_hemisferio/src/core/utils/common_extensions.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/presentation/view/widgets/comic_item.dart';
import 'package:marvel_hemisferio/src/presentation/view/widgets/favorite_widget.dart';

class CharacterItem extends ConsumerStatefulWidget {
  final CharacterEntity character;
  final bool isFavorite;

  const CharacterItem(
      {Key? key, required this.character, this.isFavorite = false})
      : super(key: key);

  @override
  ConsumerState<CharacterItem> createState() => _CharacterItemState();
}

class _CharacterItemState extends ConsumerState<CharacterItem> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: 180,
                  height: 175,
                  imageUrl:
                      "${widget.character.thumbnail.path}.${widget.character.thumbnail.extension}",
                  fit: BoxFit.fill,
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.restaurant,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FavoriteWidget(
                    isFavorite: isFavorite,
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      final viewModel =
                          ref.read(preferencesViewModelPod.notifier);

                      if (isFavorite) {
                        viewModel.setFavorite(widget.character.id.toString());
                      } else {
                        viewModel
                            .removeFavorite(widget.character.id.toString());
                        ref.refresh(favoriteLocalPod);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const HSpacing(5),
                            Text(
                              widget.character.name,
                              overflow: TextOverflow.ellipsis,
                              style: textNormal.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.character.description.length >= 80
                                  ? widget.character.description
                                      .substring(0, 80)
                                  : widget.character.description,
                              style: textSmall.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const VSpacing(10),
                            Text(
                              'Comics',
                              style: textNormal.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            const VSpacing(5),
                            SizedBox(
                              height: 50,
                              width: 125,
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                children: <Widget>[
                                  for (final item
                                      in widget.character.comics.items)
                                    ComicItem(comic: item),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
