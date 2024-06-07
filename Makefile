NAME := GoodMacAppIcon

BUNDLE_ID := at.niw.$(NAME)

PROJECT_PATH := Applications/$(NAME).xcodeproj

BUILD_PATH := .build

ARCHIVE_PATH := $(BUILD_PATH)/archive
ARCHIVE_PRODUCT_BUNDLE_PATH := $(ARCHIVE_PATH).xcarchive/Products/Applications/$(NAME).app

RELEASE_ARCHIVE_PATH := $(BUILD_PATH)/$(NAME).zip

.DEFAULT_GOAL = release

.PHONY: clean
clean:
	git clean -dfX

$(ARCHIVE_PRODUCT_BUNDLE_PATH):
	xcodebuild \
		-project "$(PROJECT_PATH)" \
		-configuration Release \
		-scheme "$(NAME)" \
		-derivedDataPath "$(BUILD_PATH)" \
		-archivePath "$(ARCHIVE_PATH)" \
		archive

.PHONY: archive
archive: $(ARCHIVE_PRODUCT_BUNDLE_PATH)

$(RELEASE_ARCHIVE_PATH): $(ARCHIVE_PRODUCT_BUNDLE_PATH)
	ditto -c -k --sequesterRsrc --keepParent "$<" "$@"

.PHONY: release
release: $(RELEASE_ARCHIVE_PATH)
