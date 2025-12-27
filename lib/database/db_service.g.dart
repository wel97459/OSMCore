// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatDatabase)
const chatDatabaseProvider = ChatDatabaseProvider._();

final class ChatDatabaseProvider
    extends $FunctionalProvider<ChatDatabase, ChatDatabase, ChatDatabase>
    with $Provider<ChatDatabase> {
  const ChatDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatDatabaseHash();

  @$internal
  @override
  $ProviderElement<ChatDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatDatabase create(Ref ref) {
    return chatDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatDatabase>(value),
    );
  }
}

String _$chatDatabaseHash() => r'cb61d9ee120068bf9901717d78e75e643a30f892';
