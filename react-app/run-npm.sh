#!/bin/sh

npm install || exit

npm run proto || exit

npm run start || exit