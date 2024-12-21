import 'package:flutter/material.dart';

class TableYemek extends StatelessWidget {
  const TableYemek({super.key, this.result});

  //final yemekListesi;
  final String? result;
  final int? adetEtsizYemek = 1;
  final int? adetEtliYemek = 1;
  final int? adetYardimciYemek = 1;
  final int? adetEkmek = 1;
  final int? adetSu = 1;

  @override
  Widget build(BuildContext context) {
    var colorCells = Theme.of(context).colorScheme.inverseSurface;
    var colorRows = Theme.of(context).colorScheme.onInverseSurface;
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(
            color: Theme.of(context).colorScheme.onPrimaryContainer),
        //color: Theme.of(context).copyWith().colorScheme.onSurface),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary),
            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Adet',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorCells),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                  child: Text(
                    'Yemek İsmi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorCells),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    child: Text(
                  'Türü',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorCells),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    child: Text(
                  'Kalori (KCAL)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorCells),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    child: Text(
                  'Fiyat (TL.)',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorCells),
                )),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface),
            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(adetEtliYemek.toString())),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('orn'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(color: colorRows),
            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(adetEtsizYemek.toString())),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('titldde1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(result!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(color: colorRows),

            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: const Text('titldddde1')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('titldde1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(color: colorRows),

            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: const Text('t')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(''),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(color: colorRows),

            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: const Text('titldddde1')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('titldde1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
          TableRow(
            decoration: BoxDecoration(color: colorRows),
            //color: Theme.of(context).copyWith().colorScheme.onSecondary),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: const Text('titldddde1')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('titldde1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('title3'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
