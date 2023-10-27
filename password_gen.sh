#!/bin/bash

while getopts "hl:s:" option
do
    case "${option}"
        in
        l)length=${OPTARG};;
        s)style=${OPTARG};;
        h)echo "Generate a significantly random password."
          echo " Default Usage:  ./password_gen.sh"
          echo "          HELP:  ./password_gen.sh -h"
          echo "Modified Usage: ./password_gen.sh [-l length] [-s style]"
          echo ""
          echo "Optional arguments change length -l or style -s as follows:"
          echo "  -l LENGTH:  length of password (default 36)"
          echo "  -s style:   style of password (if ommitted: default A)"
          echo "     A:  (The Default) Letters A-Z a-z  Numbers 0-9 NO SYMBOLS)"
          echo "     S:  Symbols subset !@+*=#$%&  Letters A-Z a-z  Numbers 0-9"
          echo "     H:  Hyphens every 4 characters Letters A-Z a-z Numbers 0-9"
          echo "     L:  letters only  A-Z a-z"
          echo "     U:  uppercase letters only A-Z"
          echo "     C:  Comprehensive.  All printable ASCII characters"
          echo ""
          echo " Examples:  " 
          echo " DEFAULT  password_gen.sh           (36 characters, Letters, Numbers, NO SYMBOLS)"
          echo " ^LENGTH  password_gen.sh -l20      (change length to 20, keep default style)"
          echo " ^ STYLE  password_gen.sh -sS       (change Style: Symbols subset, Letters and Numbers)"
          echo " ^ STYLE  password_gen.sh -sH       (change Stlye: HYPHENS every 4 chars, Letters and Numbers)"
          echo " ^ STYLE  password_gen.sh -sL       (change Style: Letters A-Za-z)"
          echo " ^ STYLE  password_gen.sh -sU       (change Style: Uppercase letters only A-Z)"
          echo " ^  BOTH  password_gen.sh -l40 -sC  (change length to 40, Style: Comprehensive)"
          exit 0;;
    esac
done

if [ "$length"  ]
then
  LENGTH1=$length
else
  LENGTH1="36"
fi

if [ "$style" == "A" ] # Same as Default:  letters, numbers, NO SYMBOLS
then 
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1 ; echo

elif [ "$style" == "S" ]  # SYMBOLS subset, Letters, Numbers
then
    LC_ALL=C tr -dc 'A-Za-z0-9!@+*=#$%&' </dev/random | head -c $LENGTH1 ; echo

elif [ "$style" == "H" ]  #  HYPHENS every 4th character, Letters, Numbers
then
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1 | fold -w4 | paste -sd- ; echo

elif [ "$style" == "L" ]  # Letters only  A-Z a-z
 then
    LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c $LENGTH1 ; echo

elif [ "$style" == "U" ]  # Uppercase Letters only A-Z
then
    LC_ALL=C tr -dc 'A-Z' </dev/random | head -c $LENGTH1 ; echo    

elif [ "$style" == "C" ]  # Comprehensive.  All Printable ASCII characters
then
    LC_ALL=C tr -dc '[:print:]' </dev/random | head -c $LENGTH1 ; echo

else  # DEFAULT  Letters, Numbers, NO SYMBOLS (same as "A")
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1 ; echo 
fi


# note on dev/random and dev/urandom from the luks manpage:
#     Using /dev/random on a  system  without  enough entropy 
#     sources can cause luksFormat to block until the requested 
#     amount of random data is gathered. In a low-entropy situation 
#     (embedded system), this can take a very long time  and  potentially
#     forever. At the same time, using /dev/urandom in a low-entropy situation
#     will produce low-quality keys. This is a serious problem, but solving it 
#     is out of scope  for a mere man-page.  See urandom(4) for more information.

#  CHANGELOG
# 2023-10-27:  Cleaned up documentation.  Added Comprehensive style.
# 2022-08-08:  as this comes from the luks manpage, I'm switching to /dev/random
# in the code above (and no longer using /dev/urandom).

# 2022-08-08: adding cases "S" and "U" to the style choices.






# interesting snippets from around the net:
#  openssl rand -base64 16
# for i in {1..8} ; do head -$(expr $(head -c7 /dev/urandom | od -An -t dL) % $(wc -l < /usr/share/dict/british-english)) /usr/share/dict/british-english | tail -1 ; done
# od -An -x /dev/urandom | head -1
#
