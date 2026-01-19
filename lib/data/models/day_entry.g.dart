// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDayEntryCollection on Isar {
  IsarCollection<DayEntry> get dayEntrys => this.collection();
}

const DayEntrySchema = CollectionSchema(
  name: r'DayEntry',
  id: -7422842651439757852,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'dateOnly': PropertySchema(
      id: 2,
      name: r'dateOnly',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _dayEntryEstimateSize,
  serialize: _dayEntrySerialize,
  deserialize: _dayEntryDeserialize,
  deserializeProp: _dayEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'dateOnly': IndexSchema(
      id: -3043929693708716332,
      name: r'dateOnly',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateOnly',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dayEntryGetId,
  getLinks: _dayEntryGetLinks,
  attach: _dayEntryAttach,
  version: '3.1.0+1',
);

int _dayEntryEstimateSize(
  DayEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.content.length * 3;
  return bytesCount;
}

void _dayEntrySerialize(
  DayEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDateTime(offsets[2], object.dateOnly);
}

DayEntry _dayEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DayEntry();
  object.content = reader.readString(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.id = id;
  return object;
}

P _dayEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dayEntryGetId(DayEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dayEntryGetLinks(DayEntry object) {
  return [];
}

void _dayEntryAttach(IsarCollection<dynamic> col, Id id, DayEntry object) {
  object.id = id;
}

extension DayEntryQueryWhereSort on QueryBuilder<DayEntry, DayEntry, QWhere> {
  QueryBuilder<DayEntry, DayEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhere> anyDateOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateOnly'),
      );
    });
  }
}

extension DayEntryQueryWhere on QueryBuilder<DayEntry, DayEntry, QWhereClause> {
  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> dateOnlyEqualTo(
      DateTime dateOnly) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateOnly',
        value: [dateOnly],
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> dateOnlyNotEqualTo(
      DateTime dateOnly) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateOnly',
              lower: [],
              upper: [dateOnly],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateOnly',
              lower: [dateOnly],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateOnly',
              lower: [dateOnly],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateOnly',
              lower: [],
              upper: [dateOnly],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> dateOnlyGreaterThan(
    DateTime dateOnly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateOnly',
        lower: [dateOnly],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> dateOnlyLessThan(
    DateTime dateOnly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateOnly',
        lower: [],
        upper: [dateOnly],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterWhereClause> dateOnlyBetween(
    DateTime lowerDateOnly,
    DateTime upperDateOnly, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateOnly',
        lower: [lowerDateOnly],
        includeLower: includeLower,
        upper: [upperDateOnly],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DayEntryQueryFilter
    on QueryBuilder<DayEntry, DayEntry, QFilterCondition> {
  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateOnlyEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateOnlyGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateOnlyLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> dateOnlyBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOnly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DayEntryQueryObject
    on QueryBuilder<DayEntry, DayEntry, QFilterCondition> {}

extension DayEntryQueryLinks
    on QueryBuilder<DayEntry, DayEntry, QFilterCondition> {}

extension DayEntryQuerySortBy on QueryBuilder<DayEntry, DayEntry, QSortBy> {
  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByDateOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOnly', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> sortByDateOnlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOnly', Sort.desc);
    });
  }
}

extension DayEntryQuerySortThenBy
    on QueryBuilder<DayEntry, DayEntry, QSortThenBy> {
  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByDateOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOnly', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByDateOnlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOnly', Sort.desc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DayEntryQueryWhereDistinct
    on QueryBuilder<DayEntry, DayEntry, QDistinct> {
  QueryBuilder<DayEntry, DayEntry, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DayEntry, DayEntry, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DayEntry, DayEntry, QDistinct> distinctByDateOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOnly');
    });
  }
}

extension DayEntryQueryProperty
    on QueryBuilder<DayEntry, DayEntry, QQueryProperty> {
  QueryBuilder<DayEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DayEntry, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<DayEntry, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DayEntry, DateTime, QQueryOperations> dateOnlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOnly');
    });
  }
}
