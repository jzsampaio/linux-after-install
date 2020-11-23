#!/bin/bash

set -ex

tmp_dir=$(mktemp -d)
pushd $tmp_dir

popd
rm -rf $tmp_dir
