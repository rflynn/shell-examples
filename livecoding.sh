#!/bin/sh

# You are tasked with writing an application that maps numbers entered on a
# phone’s dial pad to English words.
# For example, the number 228 could map to “cat” or “bat” (or any other word
# composed of letters that have a dial pad value of 228).
#
# [1     ] [2 abc] [3  def]
# [4  ghi] [5 jkl] [6  mno]
# [7 pqrs] [8 tuv] [9 wxyz]

# Your application should have a user interface that allows a user to enter a
# number and then displays the corresponding word.
printf "number: "
read number

numpat=$(echo "$number" |\
   sed -e 's/1//g'       -e 's/2/[abc]/g' -e 's/3/[def]/g'  \
       -e 's/4/[ghi]/g'  -e 's/5/[jkl]/g' -e 's/6/[mno]/g'  \
       -e 's/7/[pqrs]/g' -e 's/8/[tuv]/g' -e 's/9/[wxyz]/g')

grep "^$numpat$" /usr/share/dict/words || echo "no results for $number"

