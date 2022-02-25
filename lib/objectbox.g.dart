// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/ProductModel.dart';
import 'models/TestModel.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4558992127983979527),
      name: 'TestModels',
      lastPropertyId: const IdUid(2, 869397511233867059),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2770837018491551187),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 869397511233867059),
            name: 'name',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 7568069754412295509),
      name: 'ProductModel',
      lastPropertyId: const IdUid(17, 3104947349210666391),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6300341212679213715),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2001042459831589314),
            name: 'created_at',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 9065905068234495306),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2745979997580810728),
            name: 'category_id',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8774350188371732620),
            name: 'user_id',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7623625727780486536),
            name: 'country_id',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7649515957598153623),
            name: 'city_id',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7304217890906660039),
            name: 'price',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 6758390463886144952),
            name: 'slug',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3607157192460521326),
            name: 'status',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 8523982134068258452),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 6528027794562767334),
            name: 'quantity',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 5756770503238482632),
            name: 'images',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 5463420964850294392),
            name: 'thumbnail',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 3294040232240422906),
            name: 'attributes',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 411093232627770976),
            name: 'sub_category_id',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 3104947349210666391),
            name: 'fixed_price',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 7568069754412295509),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    TestModels: EntityDefinition<TestModels>(
        model: _entities[0],
        toOneRelations: (TestModels object) => [],
        toManyRelations: (TestModels object) => {},
        getId: (TestModels object) => object.id,
        setId: (TestModels object, int id) {
          object.id = id;
        },
        objectToFB: (TestModels object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = TestModels()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..name = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 6, '');

          return object;
        }),
    ProductModel: EntityDefinition<ProductModel>(
        model: _entities[1],
        toOneRelations: (ProductModel object) => [],
        toManyRelations: (ProductModel object) => {},
        getId: (ProductModel object) => object.id,
        setId: (ProductModel object, int id) {
          object.id = id;
        },
        objectToFB: (ProductModel object, fb.Builder fbb) {
          final created_atOffset = fbb.writeString(object.created_at);
          final nameOffset = fbb.writeString(object.name);
          final category_idOffset = fbb.writeString(object.category_id);
          final user_idOffset = fbb.writeString(object.user_id);
          final country_idOffset = fbb.writeString(object.country_id);
          final city_idOffset = fbb.writeString(object.city_id);
          final priceOffset = fbb.writeString(object.price);
          final slugOffset = fbb.writeString(object.slug);
          final statusOffset = fbb.writeString(object.status);
          final descriptionOffset = fbb.writeString(object.description);
          final quantityOffset = fbb.writeString(object.quantity);
          final imagesOffset = fbb.writeString(object.images);
          final thumbnailOffset = fbb.writeString(object.thumbnail);
          final attributesOffset = fbb.writeString(object.attributes);
          final sub_category_idOffset = fbb.writeString(object.sub_category_id);
          final fixed_priceOffset = fbb.writeString(object.fixed_price);
          fbb.startTable(18);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, created_atOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addOffset(3, category_idOffset);
          fbb.addOffset(4, user_idOffset);
          fbb.addOffset(5, country_idOffset);
          fbb.addOffset(6, city_idOffset);
          fbb.addOffset(7, priceOffset);
          fbb.addOffset(8, slugOffset);
          fbb.addOffset(9, statusOffset);
          fbb.addOffset(10, descriptionOffset);
          fbb.addOffset(11, quantityOffset);
          fbb.addOffset(12, imagesOffset);
          fbb.addOffset(13, thumbnailOffset);
          fbb.addOffset(14, attributesOffset);
          fbb.addOffset(15, sub_category_idOffset);
          fbb.addOffset(16, fixed_priceOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ProductModel()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..created_at = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 6, '')
            ..name = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 8, '')
            ..category_id = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 10, '')
            ..user_id = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 12, '')
            ..country_id = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 14, '')
            ..city_id = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 16, '')
            ..price = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 18, '')
            ..slug = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 20, '')
            ..status = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 22, '')
            ..description = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 24, '')
            ..quantity = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 26, '')
            ..images = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 28, '')
            ..thumbnail = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 30, '')
            ..attributes = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 32, '')
            ..sub_category_id = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 34, '')
            ..fixed_price = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 36, '');

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [TestModels] entity fields to define ObjectBox queries.
class TestModels_ {
  /// see [TestModels.id]
  static final id =
      QueryIntegerProperty<TestModels>(_entities[0].properties[0]);

  /// see [TestModels.name]
  static final name =
      QueryStringProperty<TestModels>(_entities[0].properties[1]);
}

/// [ProductModel] entity fields to define ObjectBox queries.
class ProductModel_ {
  /// see [ProductModel.id]
  static final id =
      QueryIntegerProperty<ProductModel>(_entities[1].properties[0]);

  /// see [ProductModel.created_at]
  static final created_at =
      QueryStringProperty<ProductModel>(_entities[1].properties[1]);

  /// see [ProductModel.name]
  static final name =
      QueryStringProperty<ProductModel>(_entities[1].properties[2]);

  /// see [ProductModel.category_id]
  static final category_id =
      QueryStringProperty<ProductModel>(_entities[1].properties[3]);

  /// see [ProductModel.user_id]
  static final user_id =
      QueryStringProperty<ProductModel>(_entities[1].properties[4]);

  /// see [ProductModel.country_id]
  static final country_id =
      QueryStringProperty<ProductModel>(_entities[1].properties[5]);

  /// see [ProductModel.city_id]
  static final city_id =
      QueryStringProperty<ProductModel>(_entities[1].properties[6]);

  /// see [ProductModel.price]
  static final price =
      QueryStringProperty<ProductModel>(_entities[1].properties[7]);

  /// see [ProductModel.slug]
  static final slug =
      QueryStringProperty<ProductModel>(_entities[1].properties[8]);

  /// see [ProductModel.status]
  static final status =
      QueryStringProperty<ProductModel>(_entities[1].properties[9]);

  /// see [ProductModel.description]
  static final description =
      QueryStringProperty<ProductModel>(_entities[1].properties[10]);

  /// see [ProductModel.quantity]
  static final quantity =
      QueryStringProperty<ProductModel>(_entities[1].properties[11]);

  /// see [ProductModel.images]
  static final images =
      QueryStringProperty<ProductModel>(_entities[1].properties[12]);

  /// see [ProductModel.thumbnail]
  static final thumbnail =
      QueryStringProperty<ProductModel>(_entities[1].properties[13]);

  /// see [ProductModel.attributes]
  static final attributes =
      QueryStringProperty<ProductModel>(_entities[1].properties[14]);

  /// see [ProductModel.sub_category_id]
  static final sub_category_id =
      QueryStringProperty<ProductModel>(_entities[1].properties[15]);

  /// see [ProductModel.fixed_price]
  static final fixed_price =
      QueryStringProperty<ProductModel>(_entities[1].properties[16]);
}
