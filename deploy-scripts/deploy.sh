#!/bin/bash
cd ~/Documents/GitHub/inventory/
git reset --hard HEAD
git pull
npm install
pm2 restart dist/src/main.js