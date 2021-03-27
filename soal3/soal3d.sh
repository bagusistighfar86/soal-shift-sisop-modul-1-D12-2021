#!/bin/bash

Password=$(date +"%m%d%Y")
zip -r -P "$Password" Koleksi.zip ./Kucing_* ./Kelinci_*
