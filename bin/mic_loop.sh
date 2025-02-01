#!/bin/bash -xe

arecord -v -f dat - | aplay -v -Vstereo -
