// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CoffeesTable extends Coffees with TableInfo<$CoffeesTable, Coffee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    price,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Coffee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Coffee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Coffee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $CoffeesTable createAlias(String alias) {
    return $CoffeesTable(attachedDatabase, alias);
  }
}

class Coffee extends DataClass implements Insertable<Coffee> {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  const Coffee({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<double>(price);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  CoffeesCompanion toCompanion(bool nullToAbsent) {
    return CoffeesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      price: Value(price),
      imageUrl: Value(imageUrl),
    );
  }

  factory Coffee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Coffee(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<double>(json['price']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<double>(price),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  Coffee copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
  }) => Coffee(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  Coffee copyWithCompanion(CoffeesCompanion data) {
    return Coffee(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      price: data.price.present ? data.price.value : this.price,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Coffee(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, price, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coffee &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.imageUrl == this.imageUrl);
}

class CoffeesCompanion extends UpdateCompanion<Coffee> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<double> price;
  final Value<String> imageUrl;
  const CoffeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  CoffeesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) : name = Value(name),
       description = Value(description),
       price = Value(price),
       imageUrl = Value(imageUrl);
  static Insertable<Coffee> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? price,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  CoffeesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<double>? price,
    Value<String>? imageUrl,
  }) {
    return CoffeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $BlogPostsTable extends BlogPosts
    with TableInfo<$BlogPostsTable, BlogPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlogPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shortDescriptionMeta = const VerificationMeta(
    'shortDescription',
  );
  @override
  late final GeneratedColumn<String> shortDescription = GeneratedColumn<String>(
    'short_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    date,
    shortDescription,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blog_posts';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlogPost> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('short_description')) {
      context.handle(
        _shortDescriptionMeta,
        shortDescription.isAcceptableOrUnknown(
          data['short_description']!,
          _shortDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_shortDescriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlogPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlogPost(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      shortDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $BlogPostsTable createAlias(String alias) {
    return $BlogPostsTable(attachedDatabase, alias);
  }
}

class BlogPost extends DataClass implements Insertable<BlogPost> {
  final int id;
  final String title;
  final String date;
  final String shortDescription;
  final String imageUrl;
  const BlogPost({
    required this.id,
    required this.title,
    required this.date,
    required this.shortDescription,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['date'] = Variable<String>(date);
    map['short_description'] = Variable<String>(shortDescription);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  BlogPostsCompanion toCompanion(bool nullToAbsent) {
    return BlogPostsCompanion(
      id: Value(id),
      title: Value(title),
      date: Value(date),
      shortDescription: Value(shortDescription),
      imageUrl: Value(imageUrl),
    );
  }

  factory BlogPost.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlogPost(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      date: serializer.fromJson<String>(json['date']),
      shortDescription: serializer.fromJson<String>(json['shortDescription']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'date': serializer.toJson<String>(date),
      'shortDescription': serializer.toJson<String>(shortDescription),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  BlogPost copyWith({
    int? id,
    String? title,
    String? date,
    String? shortDescription,
    String? imageUrl,
  }) => BlogPost(
    id: id ?? this.id,
    title: title ?? this.title,
    date: date ?? this.date,
    shortDescription: shortDescription ?? this.shortDescription,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  BlogPost copyWithCompanion(BlogPostsCompanion data) {
    return BlogPost(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      date: data.date.present ? data.date.value : this.date,
      shortDescription: data.shortDescription.present
          ? data.shortDescription.value
          : this.shortDescription,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlogPost(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, date, shortDescription, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlogPost &&
          other.id == this.id &&
          other.title == this.title &&
          other.date == this.date &&
          other.shortDescription == this.shortDescription &&
          other.imageUrl == this.imageUrl);
}

class BlogPostsCompanion extends UpdateCompanion<BlogPost> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> date;
  final Value<String> shortDescription;
  final Value<String> imageUrl;
  const BlogPostsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.shortDescription = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  BlogPostsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String date,
    required String shortDescription,
    required String imageUrl,
  }) : title = Value(title),
       date = Value(date),
       shortDescription = Value(shortDescription),
       imageUrl = Value(imageUrl);
  static Insertable<BlogPost> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? date,
    Expression<String>? shortDescription,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (shortDescription != null) 'short_description': shortDescription,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  BlogPostsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? date,
    Value<String>? shortDescription,
    Value<String>? imageUrl,
  }) {
    return BlogPostsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      shortDescription: shortDescription ?? this.shortDescription,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (shortDescription.present) {
      map['short_description'] = Variable<String>(shortDescription.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlogPostsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('shortDescription: $shortDescription, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
    'login',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAdminMeta = const VerificationMeta(
    'isAdmin',
  );
  @override
  late final GeneratedColumn<bool> isAdmin = GeneratedColumn<bool>(
    'is_admin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_admin" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    login,
    password,
    name,
    isAdmin,
    address,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
        _loginMeta,
        login.isAcceptableOrUnknown(data['login']!, _loginMeta),
      );
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_admin')) {
      context.handle(
        _isAdminMeta,
        isAdmin.isAcceptableOrUnknown(data['is_admin']!, _isAdminMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      login: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isAdmin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_admin'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String login;
  final String password;
  final String name;
  final bool isAdmin;
  final String? address;
  const User({
    required this.id,
    required this.login,
    required this.password,
    required this.name,
    required this.isAdmin,
    this.address,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['login'] = Variable<String>(login);
    map['password'] = Variable<String>(password);
    map['name'] = Variable<String>(name);
    map['is_admin'] = Variable<bool>(isAdmin);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      login: Value(login),
      password: Value(password),
      name: Value(name),
      isAdmin: Value(isAdmin),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      login: serializer.fromJson<String>(json['login']),
      password: serializer.fromJson<String>(json['password']),
      name: serializer.fromJson<String>(json['name']),
      isAdmin: serializer.fromJson<bool>(json['isAdmin']),
      address: serializer.fromJson<String?>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'login': serializer.toJson<String>(login),
      'password': serializer.toJson<String>(password),
      'name': serializer.toJson<String>(name),
      'isAdmin': serializer.toJson<bool>(isAdmin),
      'address': serializer.toJson<String?>(address),
    };
  }

  User copyWith({
    int? id,
    String? login,
    String? password,
    String? name,
    bool? isAdmin,
    Value<String?> address = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    login: login ?? this.login,
    password: password ?? this.password,
    name: name ?? this.name,
    isAdmin: isAdmin ?? this.isAdmin,
    address: address.present ? address.value : this.address,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      login: data.login.present ? data.login.value : this.login,
      password: data.password.present ? data.password.value : this.password,
      name: data.name.present ? data.name.value : this.name,
      isAdmin: data.isAdmin.present ? data.isAdmin.value : this.isAdmin,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('isAdmin: $isAdmin, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, login, password, name, isAdmin, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.login == this.login &&
          other.password == this.password &&
          other.name == this.name &&
          other.isAdmin == this.isAdmin &&
          other.address == this.address);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> login;
  final Value<String> password;
  final Value<String> name;
  final Value<bool> isAdmin;
  final Value<String?> address;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.password = const Value.absent(),
    this.name = const Value.absent(),
    this.isAdmin = const Value.absent(),
    this.address = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String login,
    required String password,
    required String name,
    this.isAdmin = const Value.absent(),
    this.address = const Value.absent(),
  }) : login = Value(login),
       password = Value(password),
       name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? login,
    Expression<String>? password,
    Expression<String>? name,
    Expression<bool>? isAdmin,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (password != null) 'password': password,
      if (name != null) 'name': name,
      if (isAdmin != null) 'is_admin': isAdmin,
      if (address != null) 'address': address,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? login,
    Value<String>? password,
    Value<String>? name,
    Value<bool>? isAdmin,
    Value<String?>? address,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      password: password ?? this.password,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isAdmin.present) {
      map['is_admin'] = Variable<bool>(isAdmin.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('password: $password, ')
          ..write('name: $name, ')
          ..write('isAdmin: $isAdmin, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, totalAmount, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final double totalAmount;
  final String date;
  const Order({
    required this.id,
    required this.totalAmount,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_amount'] = Variable<double>(totalAmount);
    map['date'] = Variable<String>(date);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      totalAmount: Value(totalAmount),
      date: Value(date),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'date': serializer.toJson<String>(date),
    };
  }

  Order copyWith({int? id, double? totalAmount, String? date}) => Order(
    id: id ?? this.id,
    totalAmount: totalAmount ?? this.totalAmount,
    date: date ?? this.date,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalAmount, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.totalAmount == this.totalAmount &&
          other.date == this.date);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<double> totalAmount;
  final Value<String> date;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.date = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required double totalAmount,
    required String date,
  }) : totalAmount = Value(totalAmount),
       date = Value(date);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<double>? totalAmount,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (date != null) 'date': date,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<double>? totalAmount,
    Value<String>? date,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      totalAmount: totalAmount ?? this.totalAmount,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoffeesTable coffees = $CoffeesTable(this);
  late final $BlogPostsTable blogPosts = $BlogPostsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    coffees,
    blogPosts,
    users,
    orders,
  ];
}

typedef $$CoffeesTableCreateCompanionBuilder =
    CoffeesCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      required double price,
      required String imageUrl,
    });
typedef $$CoffeesTableUpdateCompanionBuilder =
    CoffeesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<double> price,
      Value<String> imageUrl,
    });

class $$CoffeesTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CoffeesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoffeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$CoffeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeesTable,
          Coffee,
          $$CoffeesTableFilterComposer,
          $$CoffeesTableOrderingComposer,
          $$CoffeesTableAnnotationComposer,
          $$CoffeesTableCreateCompanionBuilder,
          $$CoffeesTableUpdateCompanionBuilder,
          (Coffee, BaseReferences<_$AppDatabase, $CoffeesTable, Coffee>),
          Coffee,
          PrefetchHooks Function()
        > {
  $$CoffeesTableTableManager(_$AppDatabase db, $CoffeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
              }) => CoffeesCompanion(
                id: id,
                name: name,
                description: description,
                price: price,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required double price,
                required String imageUrl,
              }) => CoffeesCompanion.insert(
                id: id,
                name: name,
                description: description,
                price: price,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CoffeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeesTable,
      Coffee,
      $$CoffeesTableFilterComposer,
      $$CoffeesTableOrderingComposer,
      $$CoffeesTableAnnotationComposer,
      $$CoffeesTableCreateCompanionBuilder,
      $$CoffeesTableUpdateCompanionBuilder,
      (Coffee, BaseReferences<_$AppDatabase, $CoffeesTable, Coffee>),
      Coffee,
      PrefetchHooks Function()
    >;
typedef $$BlogPostsTableCreateCompanionBuilder =
    BlogPostsCompanion Function({
      Value<int> id,
      required String title,
      required String date,
      required String shortDescription,
      required String imageUrl,
    });
typedef $$BlogPostsTableUpdateCompanionBuilder =
    BlogPostsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> date,
      Value<String> shortDescription,
      Value<String> imageUrl,
    });

class $$BlogPostsTableFilterComposer
    extends Composer<_$AppDatabase, $BlogPostsTable> {
  $$BlogPostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BlogPostsTableOrderingComposer
    extends Composer<_$AppDatabase, $BlogPostsTable> {
  $$BlogPostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BlogPostsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlogPostsTable> {
  $$BlogPostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get shortDescription => $composableBuilder(
    column: $table.shortDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$BlogPostsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlogPostsTable,
          BlogPost,
          $$BlogPostsTableFilterComposer,
          $$BlogPostsTableOrderingComposer,
          $$BlogPostsTableAnnotationComposer,
          $$BlogPostsTableCreateCompanionBuilder,
          $$BlogPostsTableUpdateCompanionBuilder,
          (BlogPost, BaseReferences<_$AppDatabase, $BlogPostsTable, BlogPost>),
          BlogPost,
          PrefetchHooks Function()
        > {
  $$BlogPostsTableTableManager(_$AppDatabase db, $BlogPostsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlogPostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlogPostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlogPostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> shortDescription = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
              }) => BlogPostsCompanion(
                id: id,
                title: title,
                date: date,
                shortDescription: shortDescription,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String date,
                required String shortDescription,
                required String imageUrl,
              }) => BlogPostsCompanion.insert(
                id: id,
                title: title,
                date: date,
                shortDescription: shortDescription,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BlogPostsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlogPostsTable,
      BlogPost,
      $$BlogPostsTableFilterComposer,
      $$BlogPostsTableOrderingComposer,
      $$BlogPostsTableAnnotationComposer,
      $$BlogPostsTableCreateCompanionBuilder,
      $$BlogPostsTableUpdateCompanionBuilder,
      (BlogPost, BaseReferences<_$AppDatabase, $BlogPostsTable, BlogPost>),
      BlogPost,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String login,
      required String password,
      required String name,
      Value<bool> isAdmin,
      Value<String?> address,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> login,
      Value<String> password,
      Value<String> name,
      Value<bool> isAdmin,
      Value<String?> address,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAdmin => $composableBuilder(
    column: $table.isAdmin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAdmin => $composableBuilder(
    column: $table.isAdmin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get login =>
      $composableBuilder(column: $table.login, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isAdmin =>
      $composableBuilder(column: $table.isAdmin, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> login = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isAdmin = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                login: login,
                password: password,
                name: name,
                isAdmin: isAdmin,
                address: address,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String login,
                required String password,
                required String name,
                Value<bool> isAdmin = const Value.absent(),
                Value<String?> address = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                login: login,
                password: password,
                name: name,
                isAdmin: isAdmin,
                address: address,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required double totalAmount,
      required String date,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<double> totalAmount,
      Value<String> date,
    });

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
          Order,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) =>
                  OrdersCompanion(id: id, totalAmount: totalAmount, date: date),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double totalAmount,
                required String date,
              }) => OrdersCompanion.insert(
                id: id,
                totalAmount: totalAmount,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, BaseReferences<_$AppDatabase, $OrdersTable, Order>),
      Order,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoffeesTableTableManager get coffees =>
      $$CoffeesTableTableManager(_db, _db.coffees);
  $$BlogPostsTableTableManager get blogPosts =>
      $$BlogPostsTableTableManager(_db, _db.blogPosts);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
}
