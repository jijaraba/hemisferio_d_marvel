import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/src/core/hooks/curved_animation_hook.dart';
import 'package:marvel_hemisferio/src/core/presentation/theme/theme.dart';
import 'package:marvel_hemisferio/src/core/presentation/viewmodels/common_viewmodel_provider.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/error_container.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/widgets.dart';
import 'package:marvel_hemisferio/src/core/res/res.dart';
import 'package:marvel_hemisferio/src/core/utils/common_extensions.dart';
import 'package:marvel_hemisferio/src/domain/entities/comic_entity.dart';

class ComicDetailPage extends StatefulHookConsumerWidget {
  const ComicDetailPage({
    Key? key,
    required this.comicId,
  }) : super(key: key);

  final String comicId;

  @override
  ConsumerState<ComicDetailPage> createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends ConsumerState<ComicDetailPage> {
  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final comicData = ref.watch(
      comicDetailDataPod(
        int.parse(widget.comicId),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: GestureDetector(
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: UIColors.red100.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: UIColors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: comicData.when(
          data: (data) => Column(
            children: <Widget>[
              ///Header
              _ComicDetailHeader(comic: data),
              const VSpacing(30),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  data.first.description,
                  style: textNormal.copyWith(
                    color: UIColors.black,
                  ),
                ),
              )
            ],
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (e, s) => ErrorContainer(
            text: localization.text('common.genericError'),
            onRetryPress: () => ref.refresh(
              comicDetailDataPod(int.parse(widget.comicId)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComicDetailHeader extends StatefulHookConsumerWidget {
  final List<ComicEntity> comic;

  const _ComicDetailHeader({Key? key, required this.comic}) : super(key: key);

  @override
  ConsumerState<_ComicDetailHeader> createState() => _ComicDetailHeaderState();
}

class _ComicDetailHeaderState extends ConsumerState<_ComicDetailHeader> {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final animation = useCurvedAnimation(
      animationController,
      curve: Curves.bounceInOut,
    );

    useMemoized(() => Future<void>(animationController.forward));

    return Stack(
      children: [
        Column(
          children: <Widget>[
            Image.asset(
              Assets.backgroundHeader,
              fit: BoxFit.cover,
              height: 200,
            ),
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: UIColors.darkBlue,
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: UIColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: AspectRatio(
                aspectRatio: 2.5 / 1.1,
                child: ScaleTransition(
                  scale: animation,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 150,
                      height: 150,
                      imageUrl:
                          '${widget.comic.first.thumbnail.path}.${widget.comic.first.thumbnail.extension}',
                      fit: BoxFit.fill,
                      errorWidget: (_, __, ___) => const Icon(
                        Icons.restaurant,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0, top: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const VSpacing(10),
                    Text(
                      widget.comic.first.title,
                      overflow: TextOverflow.ellipsis,
                      style: textNormal.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
