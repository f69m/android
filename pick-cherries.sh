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

