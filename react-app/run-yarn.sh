#!/bin/sh

yarn install || exit

npm proto || exit

npm start || exit