# Linux Password Generator


## Default usage:

```
    ./password_gen.sh
```
  The default password length is 36 characters and the default style includes Letters A-Z a-z and numbers 0-9.  
  Both of those defaults are easy to tweak using the optional flags.   
  

## Optional flags:
#### Use the optional -h flag for help.
```
$ ./password_gen.sh -h
```
#### Use the optional -l flag to set the password length.
```
    $  ./password_gen.sh -l20   #Sets password length to 20 characters.  
    $  ./password_gen.sh -l50   #Sets password length to 50 characters.  
```
#### Use the optional -s flag to modify the character-set used to create the password:
```
    $  ./password_gen.sh -sA (same as default.  Letters A-za-z numbers 0-9 No symbols)
    $  ./password_gen.sh -sS (Symbols subset!@+*=#$%&, Letters and Numbers).
    $  ./password_gen.sh -sH (Hyphens every 4 characters, Letters and Numbers)
    $  ./password_gen.sh -sL (Letters only)
    $  ./password_gen.sh -sU (UPPERCASE LETTERS ONLY)
    $  ./password_gen.sh -sC (Comprehensive:  all printable ASCII characters)
```
White space doesn't matter. These are equivalent:  
```
    $  ./password_gen.sh -s H   or ./password_gen.sh -sH
```
## Combine Flags:
Use both the -l flag and the -s flag to tailor your password.  
  Create password of length 40 with Style: Symbols (includes letters and numbers):
```
    $  ./password_gen.sh -l40 -sS
```
  Create password of length 30 with hyphens
```
    $  ./password_gen.sh -l30 -sH
```
  Create password of length 50 using UPPERCASE LETTERS ONLY:
```
    $  ./password_gen.sh -l50 -sU
```

## Installation:
- Copy the `password_gen.sh` script to your machine.  
- Chmod u+x the script so that it is executable.  
- Store the script in a directory on your path so you can use it from anywhere.  


## Extra notes about the Linux clipboard:
In Linux, when you copy a string, it will stay in the clipboard buffer until you copy something new. So... after you copy/paste one of these strong passwords, make sure you copy something (anything) else.  Even a single letter of something will work.  Depending on how you performed the **copy**, there may be additional copies stored in a shell variable as well.  You need a routine that cleans up all possible copies of your password.

I have my own personal "password generation" routine.  It includes an alias mapped to the script for quick use, and then, another alias that strings a few commands together to handle cleanup after I've stored my new password.  

## Tools for the cleanup:  
I use two Linux command line tools:  **xsel** and **xclip**
```
  sudo apt install xsel xclip
```


Run this command to eliminate all the copies sitting around:  
```
xsel -bc && uptime | xclip && clear
```

### Make an alias for cleanup  
I created the shell alias "clipclr" to handle my clean-up action:
 add this to your .bashrc or .zshrc configuration file):   
```
alias clipclr="xsel -bc && uptime | xclip && clear"
```
## Storing passwords
Linux has an excellent command line tool for generating and storing passwords.  You should check it out.  Installation:  
```sudo apt install passwd```

I never adapted to using it, and I was already using GPG, so my routine involves storing all my sensitive notes and passwords in a single directory as basic text files that I then encrypt with gpg.  After the file is encrypted, I secure-delete the unencrypted text file using **srm**.  

GPG is its own nightmare, but if you are this deep into security, you absolutely must dig into it.  Signed code pushed to Github requires that you have a GPG (or PGP) key, so dig in there and learn about GPG keys for other purposes.  I've even gone so far as to generate and store GPG keys on Yubikeys, but that it for another day....  

## The whole enchilada:
If you are curious about my storage/encryption/deletion routine, here it is:  
1. In terminal, create a password, or several.
2. Copy/paste the password into a text file. 
3. clipclr to clean up any residual copies.
4. **gpg** --encrypt the text file where password was stored. 
5. **srm** the unencrypted text file.
6. Backup the entire GPG directory onto another drive.

For the record, I stopped using internal hard drives for anything other than storing the OS and configurations.  I do all my development work and data storage on external drives. If speed is an issue, I will temporarily move to an internal nvme drive, but then back to an external drive once I'm done.  My backup routine includes backing up the internal drives to an external one so that I always have all my configurations, and backing up my external drive to a second external drive so that I always have backups of everything.  You think I've had a computer or two crash on me?

### SRM
Use **srm** to "secure remove" files on your drives.  Obviously, nothing can remove your stuff if it is part of a RAID system or on an SSD and various external platforms.  But you should try anyway. The **srm* command is in a package named **secure-delete**:  
```
sudo apt install secure-delete
man srm
srm file-to-delete
```
### Third-Party Password Managers
Seriously, if you were a big-time hacker, password managers would be a primary target for you.  Forever. I avoid all third-party password manager thingies.  Sorry.  I know a lot of people need them, but if you are this deep into this document, you don't need them, and should not waste your time on them.  

### Changelog
2023-10-27: Updated README.  Documented script. Cleaned up order, and added COMPREHENSIVE style to script.  
2023-09-15: Tweaked README.  Still learning markup formatting rules...  
2023-06-30:Changed H flag to K.  Tweaked notes throughout.  
2023-06-10:added -h help flag, and updated this readme.  
2022-08-16:Using 'random" instead of "urandom"  
2022-08-06 all files adding signature to commit  
