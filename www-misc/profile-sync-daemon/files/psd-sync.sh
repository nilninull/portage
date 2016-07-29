#!/bin/sh

for s in /etc/init.d/psd.*; do
    $s resync
done
