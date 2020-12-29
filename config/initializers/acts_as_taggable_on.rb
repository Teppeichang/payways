# タグ付けを削除した後に未使用のタグオブジェクトを削除
ActsAsTaggableOn.remove_unused_tags = true

# タグを小文字で保存
ActsAsTaggableOn.force_lowercase = false

# タグをパラメータ化して保存
#ActsAsTaggableOn.force_parameterize = true

# タグの大文字と小文字を区別
ActsAsTaggableOn.strict_case_match = false

# MySqlで特殊文字を完全に一致させたい場合
#ActsAsTaggableOn.force_binary_collation = true

# テーブル名を指定する場合：
# ActsAsTaggableOn.tags_table = 'aato_tags'
# ActsAsTaggableOn.taggings_table = 'aato_taggings'

# タグの区切り
ActsAsTaggableOn.delimiter = ' '