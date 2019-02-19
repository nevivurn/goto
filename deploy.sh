#!/usr/bin/env bash

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
find public/ -not \( -name 'CNAME' -o -name '.git' \) -delete
cd "$cwd"

# Re-generated
hugo --gc --minify

# Publish
cd public/
git add .
git commit -m "Update as of $(date '+%Y-%m-%d %H:%M:%S')"
git push
cd "$cwd"
