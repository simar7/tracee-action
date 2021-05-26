#!/bin/bash

workdir="$1"
token="$2"
fail_on_diff="$3"
create_pr="$4"

echo "Checking results..."
cmp --silent $workdir/out/tracee.profile ./tracee.profile
rc=$?
if [ $rc -ne 0 ]; then
  echo "Differences found..."
  diff "$workdir"/out/tracee.profile ./tracee.profile
  if [ $create_pr = "true" ]; then
    echo "Creating a commit with all changes..."
    cp $workdir/out/tracee.profile .
    git config --global user.email "opensource@aquasec.com"
    git config --global user.name "Tracee Bot"
    gh auth login --with-token <<<"$token"
    git fetch --all
    git checkout -B 'tracee-profile-update' origin/$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
    git add tracee.profile
    git commit -m 'update tracee.profile'
    git push -f --set-upstream origin tracee-profile-update
    gh pr create --title "Updates to tracee.profile" --body "List of runtime programs executed during this pipeline run. Powered by Tracee"
    echo "PR Created"
  fi

  if [ $fail_on_diff = "true" ]; then
    exit 1
  else
    exit 0
  fi
else
  echo "No profile differences found"
  exit 0
fi