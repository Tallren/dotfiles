#!/bin/bash
#
##########
# This script adjusts Rectangle's gap at the top of the screen to account for sketchybar's placement.##########
#
defaults write com.knollsoft.Rectangle screenEdgeGapTop -int 25
killall Rectangle
open /Applications/Rectangle.app
