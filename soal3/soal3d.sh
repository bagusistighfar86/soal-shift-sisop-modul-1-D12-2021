#!/bin/bash

Password=$(date +"%m%d%Y")
zip -rm -P "$Password" Koleksi.zip ./Kucing_* ./Kelinci_*
