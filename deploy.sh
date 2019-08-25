#!/usr/bin/env bash

set -ex

cwd="$(pwd)"

# Update writeups
cd content/writeups/
git checkout master
git pull
find -type f -name README.md -delete
find -mindepth 1 -maxdepth 1 -type d -not -execdir test -e '{}/index.md' \; -print0 | xargs -0 rm -r
cd "$cwd"

# Reset site
cd public/
git checkout master
find -not \( -name 'CNAME' -o -name '.git' \) -delete
cd "$cwd"

# Generate site
hugo --gc --minify

# Reset writeups
cd content/writeups/
git checkout master
git reset --hard
cd "$cwd"

# Publish
cd public/
git add .
git commit -m "Update as of $(date '+%Y-%m-%d %H:%M:%S')"
git push
cd "$cwd"
