#!/bin/sh
# stash any unstaged changes
git stash -q --keep-index

# run Flutter analyze
flutter analyze --no-fatal-infos

if [ $? -ne 0 ]; then
        # unstash the unstashed changes
        git stash pop -q
        exit 1
fi

# and the actual tests
flutter test


if [ $? -ne 0 ]; then
        # unstash the unstashed changes
        git stash pop -q
        exit 1
fi

# unstash the unstashed changes
git stash pop -q
exit 0
