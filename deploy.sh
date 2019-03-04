#!/usr/bin/env bash

set -ex

cwd=$(pwd)

# Update writeups
cd content/writeups/
git checkout master
git pull
find -type f -name README.md -delete
cd "$cwd"

# Reset public dir
cd public/
git checkout master
find -not \( -name 'CNAME' -o -name '.git' \) -delete
cd "$cwd"

# Re-generated
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
