#!/usr/bin/env bash

cwd=$(pwd)

# Update writeups
cd content/writeups/
git checkout master
git pull
cd "$cwd"

# Cleanup
find content/writeups/ -type f -name README.md -delete
find public/ -not -name 'CNAME' -delete

# Re-generated
hugo generate --gc --minify

# Publish
git add public/
git commit -m "Update as of $(date '+%Y-%m-%d %H:%M:%S')"
git push
