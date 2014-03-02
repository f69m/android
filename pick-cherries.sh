#!/bin/sh

set -e

# [1/2] libc: support using old property system via makefile flag
# URL: https://gerrit.omnirom.org/3389
( cd bionic; \
  git fetch https://gerrit.omnirom.org/android_bionic refs/changes/89/3389/4 && \
  git cherry-pick FETCH_HEAD )

# [2/2] init: support using old property system via makefile flag
# URL: https://gerrit.omnirom.org/3390
( cd system/core; \
  git fetch https://gerrit.omnirom.org/android_system_core refs/changes/90/3390/5 && \
  git cherry-pick FETCH_HEAD )

# [1/3] support old property system in recovery
# URL: https://gerrit.omnirom.org/5543
( cd bionic; \
  git fetch https://gerrit.omnirom.org/android_bionic refs/changes/43/5543/3 && \
  git cherry-pick FETCH_HEAD )

# [3/3] support old property system in recovery
# URL: https://gerrit.omnirom.org/5545
( cd build; \
  git fetch https://gerrit.omnirom.org/android_build refs/changes/45/5545/4 && \
  git cherry-pick FETCH_HEAD )

# [2/3] support old property system in recovery
# URL: https://gerrit.omnirom.org/5544
( cd system/core; \
  git fetch https://gerrit.omnirom.org/android_system_core refs/changes/44/5544/5 && \
  git cherry-pick FETCH_HEAD )

# [2/2] adbd: link with libc_oldprops for recovery
# URL: https://gerrit.omnirom.org/5929
( cd build; \
  git fetch https://gerrit.omnirom.org/android_build refs/changes/29/5929/1 && \
  git cherry-pick FETCH_HEAD )

# [1/2] adbd: link with libc_oldprops for recovery
# URL: https://gerrit.omnirom.org/5935
( cd system/core; \
  git fetch https://gerrit.omnirom.org/android_system_core refs/changes/35/5935/1 && \
  git cherry-pick FETCH_HEAD )

