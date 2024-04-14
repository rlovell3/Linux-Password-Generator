#!/bin/bash

# Define help message
HELP_MESSAGE="Generate a significantly random password.
Default Usage:  ./password_gen.sh
HELP:           ./password_gen.sh -h
Modified Usage: ./password_gen.sh [-l length] [-s style]
Automation:     ./password_gen.sh -a [can add optional -l and -s flags]


Optional arguments change length -l or style -s as follows:
  -l LENGTH:  length of password (default 36)
  -s style:   style of password (if ommitted: default A)
     A:  (The Default) Letters A-Z a-z  Numbers 0-9 NO SYMBOLS)
     S:  Symbols subset !@+*=#$%&  Letters A-Z a-z  Numbers 0-9
     H:  Hyphens every 4 characters Letters A-Z a-z Numbers 0-9
     L:  letters only  A-Z a-z
     U:  uppercase letters only A-Z
     C:  Comprehensive.  All printable ASCII characters

Examples:  
DEFAULT  password_gen.sh           (36 characters, Letters, Numbers, NO SYMBOLS)
^LENGTH  password_gen.sh -l20      (change length to 20, keep default style)
^ STYLE  password_gen.sh -sS       (change Style: Symbols subset, Letters and Numbers)
^ STYLE  password_gen.sh -sH       (change Stlye: HYPHENS every 4 chars, Letters and Numbers)
^ STYLE  password_gen.sh -sL       (change Style: Letters A-Za-z)
^ BOTH   password_gen.sh -l40 -sC  (change length to 40, Style: Comprehensive)"


AUTO=false
LOOP_COUNT=5

# Check for --help option
for arg in "$@"
do
    if [ "$arg" == "--help" ]; then
        # Print help message
        echo "$HELP_MESSAGE"
        exit 0
    fi
done

while getopts "ahl:s:" option
do
    case "${option}"
        in
        a)AUTO=true
          LOOP_COUNT=1;;
        l)length=${OPTARG};;
        s)style=${OPTARG};;
        h)echo "$HELP_MESSAGE"
          exit 0;;
    esac
done

# Establish password length 
if [ "$length" ]; then
    if [ "$length" -lt 8 ] || [ "$length" -gt 100 ]; then
        echo "Error: Length must be between 8 and 100."
        exit 1
    fi
    LENGTH1=$length
else
    LENGTH1="36"
fi

# Primary loop of the program

for i in $(seq 1 $LOOP_COUNT)
do

    if [ "$style" == "A" ] # Same as Default:  letters, numbers, NO SYMBOLS
    then 
        PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1)

    elif [ "$style" == "S" ]  # SYMBOLS subset, Letters, Numbers; Begin/end with letter.
    then
        FIRST_CHAR=$(LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c 1)
        MIDDLE=$(LC_ALL=C tr -dc 'A-Za-z0-9!@+*=#$%&' </dev/random | head -c $(($LENGTH1-2)))
        LAST_CHAR=$(LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c 1)
        PASSWORD="${FIRST_CHAR}${MIDDLE}${LAST_CHAR}"

    elif [ "$style" == "H" ]  #  HYPHENS every 4th character, Letters, Numbers
    then
        PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1 | fold -w4 | paste -sd-)

    elif [ "$style" == "L" ]  # Letters only  A-Z a-z
    then
        PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c $LENGTH1 )

    elif [ "$style" == "U" ]  # Uppercase Letters only A-Z
    then
        PASSWORD=$(LC_ALL=C tr -dc 'A-Z' </dev/random | head -c $LENGTH1 )    

    elif [ "$style" == "C" ]  # Comprehensive.  All Printable ASCII characters
    then
        FIRST_CHAR=$(LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c 1)
        MIDDLE=$(LC_ALL=C tr -dc '[:print:]' </dev/random | head -c $(($LENGTH1-2)))
        LAST_CHAR=$(LC_ALL=C tr -dc 'A-Za-z' </dev/random | head -c 1)
        PASSWORD="${FIRST_CHAR}${MIDDLE}${LAST_CHAR}"

    else  # DEFAULT  Letters, Numbers, NO SYMBOLS (same as "A")
        PASSWORD=$(LC_ALL=C tr -dc 'A-Za-z0-9' </dev/random | head -c $LENGTH1 )
    fi
    
    # Check if AUTO is true
    if $AUTO; then
        # If AUTO is true, print the password without the prefix and quotation marks
        echo $PASSWORD
    else
        # If AUTO is false, print the password with the prefix and quotation marks
        echo "Password $i: \"$PASSWORD\""
    fi
done


#  CHANGELOG
# 2024-04-14: - Deprecated cleanup of clipboard and terminal. Now focuses on password generation.
#             - Changed S and C styles to use first/last letter restriction.
#             - Loop to generate and print 5 passwords.
#             - Print password within added quotation marks.
#             - Added AUTO mode for automated operation.
# 2023-11-22: Major update. Now, everything runs silently. Hidden password  
#             and copy/paste functionality.   
# 2023-10-27: Cleaned up documentation.  Added "C" Comprehensive style.
# 2022-08-08: as this comes from the luks manpage, I'm switching to /dev/random
#             (and no longer using /dev/urandom).
#             and adding cases "S" and "U" to the style choices.





#
