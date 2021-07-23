import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart_model.dart';
import 'package:provider_shopper/models/catalog_model.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBer(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(index)))
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );
    return TextButton(
        onPressed: isInCart
            ? null
            : () {
                var cart = context.read<CartModel>();
                cart.add(item);
              },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null;
          }),
        ),
        child: isInCart
            ? const Icon(
                Icons.check,
                semanticLabel: "ADDED",
              )
            : const Text("ADD"));
  }
}

class _MyAppBer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("Catalog"),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, "/cart"),
        )
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  const _MyListItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context
        .select<CatalogModel, Item>((catalog) => catalog.getByPosition(index));
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                item.name,
                style: textTheme,
              ),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
