#!/bin/bash

# 相対importをpackage importに変換するスクリプト

echo "🔧 相対importをpackage importに修正中..."

# プロジェクトルートからの実行を前提
for file in $(find lib -name "*.dart"); do
    # 一時ファイルを作成
    temp_file=$(mktemp)

    # sedで相対importを変換
    sed -E "s|import '\.\./\.\./|import 'package:flutter_srf/|g" "$file" | \
    sed -E "s|import '\.\./|import 'package:flutter_srf/|g" > "$temp_file"

    # パスの修正（libディレクトリを考慮）
    # lib/ui/components/home_screen.dart -> package:flutter_srf/ui/components/home_screen.dart
    dir_path=$(dirname "$file" | sed 's|^lib/||')

    # 各import行に対して適切なパスに修正
    awk -v dir="$dir_path" '
    /^import '\''package:flutter_srf\// {
        # パッケージimportの場合、相対パスを解決
        match($0, /import '\''package:flutter_srf\/(.+)'\''/, arr)
        if (arr[1]) {
            # ../../../ などの相対パスを解決
            path = arr[1]
            # 現在のディレクトリからの相対位置を計算
            split(dir, curr_parts, "/")
            split(path, path_parts, "/")

            # ../ の数を数える
            up_count = 0
            for (i in path_parts) {
                if (path_parts[i] == "..") up_count++
                else break
            }

            # パスを再構築
            new_path = ""
            # 現在のディレクトリから上に移動
            for (i = 1; i <= length(curr_parts) - up_count; i++) {
                if (curr_parts[i] != "") {
                    if (new_path != "") new_path = new_path "/"
                    new_path = new_path curr_parts[i]
                }
            }

            # 残りのパスを追加
            for (i = up_count + 1; i <= length(path_parts); i++) {
                if (path_parts[i] != "") {
                    if (new_path != "") new_path = new_path "/"
                    new_path = new_path path_parts[i]
                }
            }

            print "import '\''package:flutter_srf/" new_path "'\''"
        } else {
            print $0
        }
    }
    !/^import '\''package:flutter_srf\// {
        print $0
    }
    ' "$temp_file" > "${file}.new"

    # ファイルが変更された場合のみ置き換え
    if ! cmp -s "$file" "${file}.new"; then
        mv "${file}.new" "$file"
        echo "✅ 修正: $file"
    else
        rm "${file}.new"
    fi

    rm "$temp_file"
done

echo "✨ 相対importの修正完了！"