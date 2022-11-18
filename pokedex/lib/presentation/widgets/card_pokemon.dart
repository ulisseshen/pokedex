// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/domain/pokemon_entity.dart';
import 'package:pokedex/presentation/widgets/shimmer_widget.dart';

class PokedexCard extends StatelessWidget {
  const PokedexCard({
    super.key,
    required this.pokemonEntity,
    required this.index,
    this.animate = false,
  });

  final PokemonEntity pokemonEntity;
  final int index;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ScaleAnimationContainer(
      index: index,
      performAnimation: animate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ImageContainer(
            backgroundColor: pokemonEntity.backgroundColor,
            child: SvgPicture.network(
              pokemonEntity.svgSprite,
              height: 80,
              width: 80,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("#${pokemonEntity.id}", style: textTheme.bodySmall),
                Text(
                  pokemonEntity.name,
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(pokemonEntity.type, style: textTheme.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PokedexCardShimmer extends StatelessWidget {
  const PokedexCardShimmer({
    super.key,
    required this.index,
    required this.animate,
  });

  final int index;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationContainer(
      index: index,
      performAnimation: animate,
      child: Column(
        children: [
          _ImageContainer(
            backgroundColor: Colors.white,
            child: ShimmerWidget(
              child: Container(
                height: 70,
                width: 70,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ShimmerWidget(
              child: Column(
                children: const [
                  _ShimmerPlaceholderCard(height: 12),
                  SizedBox(height: 2),
                  _ShimmerPlaceholderCard(height: 14),
                  SizedBox(height: 10),
                  _ShimmerPlaceholderCard(height: 12),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScaleAnimationContainer extends StatefulWidget {
  const ScaleAnimationContainer({
    super.key,
    required this.performAnimation,
    required this.index,
    required this.child,
  });

  final bool performAnimation;
  final int index;
  final Widget child;

  @override
  State<ScaleAnimationContainer> createState() =>
      _ScaleAnimationContainerState();
}

class _ScaleAnimationContainerState extends State<ScaleAnimationContainer> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();

    if (widget.performAnimation) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration(
                milliseconds: widget.index == 0 ? 0 : 60 * widget.index))
            .then(
          (value) {
            setState(() {
              _animate = true;
            });
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 400),
      scale: widget.performAnimation
          ? _animate
              ? 1
              : 0
          : 1,
      child: widget.child,
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    required this.backgroundColor,
    this.child,
  });

  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: 105,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(-5, 5),
          )
        ],
      ),
      child: Center(child: child),
    );
  }
}

class _ShimmerPlaceholderCard extends StatelessWidget {
  const _ShimmerPlaceholderCard({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 14,
      width: width ?? double.infinity,
      color: Colors.white,
    );
  }
}
