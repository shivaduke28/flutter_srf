# フォーマット
.PHONY: format
format:
	@echo "🎨 Formatting code..."
	@dart format lib/ test/

# 静的解析
.PHONY: analyze
analyze:
	@echo "🔍 Analyzing code..."
	@dart analyze

# テスト
.PHONY: test
test:
	@echo "🧪 Running tests..."
	@flutter test

# コード生成
.PHONY: build
build:
	@echo "🏗️ Running code generation..."
	@dart run build_runner build --delete-conflicting-outputs

# アプリ実行
.PHONY: run
run:
	@echo "🚀 Running Flutter app on macOS..."
	@flutter run -d macos

# watchモードでコード生成
.PHONY: watch
watch:
	@echo "👀 Watching for code generation..."
	@dart run build_runner watch --delete-conflicting-outputs