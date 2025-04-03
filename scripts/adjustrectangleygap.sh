#!/bin/bash
#
##########
# This script adjusts Rectangle's gap at the top of the screen to account for sketchybar's placement.##########
#
defaults write com.knollsoft.Rectangle screenEdgeGapTopNotch -int 1
killall Rectangle
open /Applications/Rectangle.app
