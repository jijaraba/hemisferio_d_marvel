import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marvel_hemisferio/src/core/forms/character/character_form_state_notifier.dart';
import 'package:marvel_hemisferio/src/core/hooks/curved_animation_hook.dart';
import 'package:marvel_hemisferio/src/core/presentation/viewmodels/common_viewmodel_provider.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/custom_text_field.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/error_container.dart';
import 'package:marvel_hemisferio/src/core/presentation/widgets/widgets.dart';
import 'package:marvel_hemisferio/src/core/res/res.dart';
import 'package:marvel_hemisferio/src/core/utils/common_extensions.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_entity.dart';
import 'package:marvel_hemisferio/src/domain/entities/character_search_entity.dart';
import 'package:marvel_hemisferio/src/presentation/view/widgets/character_item.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final characterData = ref.watch(characterDataPod(
      CharacterSearchData(
        offset: ref.read(pageFilterPod),
        limit: ref.read(limitFilterPod),
        search: ref.read(searchFilterPod),
      ),
    ));
    return Scaffold(
      body: RefreshIndicator(
        color: UIColors.red100,
        onRefresh: () async => ref.refresh(characterDataPod(
          CharacterSearchData(
            offset: ref.read(pageFilterPod),
            limit: ref.read(limitFilterPod),
            search: ref.read(searchFilterPod),
          ),
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///Header
              const _CharacterDetailHeader(),

              ///Characters
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: characterData.when(
                  data: (data) => _CharacterList(
                    characterList: data,
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, s) => ErrorContainer(
                    text: localization.text('common.genericError'),
                    subtitle: localization.text('common.genericErrorSubtitle'),
                    onRetryPress: () => ref.refresh(characterDataPod(
                      CharacterSearchData(
                        offset: ref.read(pageFilterPod),
                        limit: ref.read(limitFilterPod),
                        search: ref.read(searchFilterPod),
                      ),
                    )),
                  ),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          CustomButton(
                            paddingHorizontal: 90,
                            onPressed: () {
                              ref.read(pageFilterPod.notifier).state = ref.read(pageFilterPod.notifier).state + 1;
                            },
                            text: localization.text('common.loadMore'),
                            textColor: UIColors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterDetailHeader extends StatefulHookConsumerWidget {
  const _CharacterDetailHeader({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_CharacterDetailHeader> createState() =>
      _CharacterDetailHeaderState();
}

class _CharacterDetailHeaderState
    extends ConsumerState<_CharacterDetailHeader> {
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

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Image.asset(
                Assets.backgroundHeader,
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                decoration: const BoxDecoration(
                  color: UIColors.darkBlue,
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Expanded(child: _SearchTextField()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CharacterList extends ConsumerWidget {
  const _CharacterList({
    Key? key,
    required this.characterList,
  }) : super(key: key);

  final List<CharacterEntity> characterList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteData = ref.watch(favoriteLocalPod);
    final localization = context.localizations;

    return characterList.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[Text("TODO")],
          )
        : favoriteData.when(
            data: (data) {
              data = data ?? [];
              return ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: <Widget>[
                  for (final item in characterList)
                    CharacterItem(
                      character: item,
                      isFavorite:
                          data.contains(item.id.toString()) ? true : false,
                    ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, s) => ErrorContainer(
              text: localization.text('common.genericError'),
              subtitle: localization.text('common.genericErrorSubtitle'),
              onRetryPress: () => ref.refresh(
                characterDataPod(
                  CharacterSearchData(
                    offset: ref.read(pageFilterPod),
                    limit: ref.read(limitFilterPod),
                    search: ref.read(searchFilterPod),
                  ),
                ),
              ),
            ),
          );
  }
}

class _SearchTextField extends HookConsumerWidget {
  const _SearchTextField({Key? key, this.value}) : super(key: key);

  final String? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localization = context.localizations;

    final characterText = ref.watch(
      characterNotifierPod.select((form) => form.search),
    );
    final characterTextController = useTextEditingController(
      text: characterText.value.isNotEmpty ? characterText.value : value,
    );

    useEffect(
      () {
        if (value != null) {
          Future.microtask(() {
            ref.read(characterNotifierPod.notifier).changeSearch(value!);
          });
        }
        return null;
      },
      [value],
    );

    return CustomTextField(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 6,
      ),
      maxLength: 100,
      textController: characterTextController,
      requiredMessage: localization.text('addressRequiredLabel'),
      inputType: TextInputType.streetAddress,
      action: TextInputAction.next,
      onChange: (value) => ref.read(searchFilterPod.notifier).state = value,
      isRequired: true,
      prefix: const Icon(
        Icons.search,
        color: UIColors.white,
      ),
      textColor: UIColors.white,
      focusedColor: UIColors.white,
      hintColor: UIColors.white,
      borderColor: UIColors.white,
      backgroundColor: UIColors.darkBlue,
    );
  }
}
