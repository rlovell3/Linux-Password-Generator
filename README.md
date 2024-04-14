# Linux Password Generator

## Default usage

```bash
    ./password_gen.sh
```

  The default password length is 36 characters and the default style includes A-Z, a-z, 0-9.  
  Both of those defaults are easy to tweak using the optional flags.  
  
## Optional flags

#### Use the optional -h flag for help.

```bash
./password_gen.sh -h
./password_gen.sh --help
```

#### Use the optional -l flag to set the password Length

Minimum password length: 8  
Maximum password length: 100  
```bash
    ./password_gen.sh -l20   #Sets password length to 20 characters.  
    ./password_gen.sh -l50   #Sets password length to 50 characters.  
```

#### Use the optional -s flag to modify the Style

```
    ./password_gen.sh     (Default.  Letters A-za-z numbers 0-9 No symbols)
    ./password_gen.sh -sS (Symbols subset!@+*=#$%&, Letters and Numbers).
    ./password_gen.sh -sH (Hyphens every 4 characters, Letters and Numbers)
    ./password_gen.sh -sL (Letters only)
    ./password_gen.sh -sU (UPPERCASE LETTERS ONLY)
    ./password_gen.sh -sC (Comprehensive:  all printable ASCII characters)
```
Any style that includes symbols will begin and end with a letter.  

White space doesn't matter. These are equivalent:  
```
    "./password_gen.sh -s H"  ==  "./password_gen.sh -sH"
```

## Combine Flags

Use both the -l flag and the -s flag to tailor your password.  
  Create password of length 40 with Style S:  
```bash
    ./password_gen.sh -l40 -sS
```

  Create password of length 30 with hyphens  
```bash
    ./password_gen.sh -l30 -sH
```
  Create password of length 50 using UPPERCASE LETTERS ONLY:  
```bash
    ./password_gen.sh -l50 -sU
```

## Installation:
- Copy the `password_gen.sh` script to your machine.  
- Chmod u+x the script so that it is executable.  
- Store the script in a directory on your path so you can use it from anywhere.  

## Clipboard and Terminal Cleanup

Be sure to clear your clipboard and terminal buffers after generating passwords.  

### Changelog

2024-04-14:  
- Deprecated cleanup of clipboard and terminal. Now focuses on password generation.  
- Changed S and C styles to use first/last letter restriction.  
- Loop to generate and print 5 passwords.  
- Print password within added quotation marks.  
- Added AUTO mode for automated operation.  

2023-11-22: Adopted auto-clipboard functionality and cleanup.  
2023-10-27:  
- Updated README.  
- Documented script.  
- Added COMPREHENSIVE style to script.  

2023-09-15: Tweaked README.  Still learning markup formatting rules...  
2023-06-30:Changed H flag to K.  Tweaked notes throughout.  
2023-06-10:added -h help flag, and updated this readme.  
2022-08-16:Using 'random" instead of "urandom"  
2022-08-06 all files adding signature to commit  
