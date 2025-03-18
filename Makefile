#
# Makefile
#
###############################################

.DEFAULT_GOAL := build

###############################################

st:
	open -a SourceTree .
clone:
	git clone git@github.com:mlavergn/snippets.git

signpost:
	open -a CodeRunner.app objc/signpost.m

log:
	open -a CodeRunner.app objc/log.m

oformat:
	xcrun clang-format --style=file:clang-format.cfg -i objc/*.[hm] || true

sformat:
	swiftformat -config swiftformat.cfg **/*.swift

slint:
	swiftlint --config swiftlint.yml
