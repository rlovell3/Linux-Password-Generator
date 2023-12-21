# Linux Password Generator

## Default usage

```bash
    ./password_gen.sh
```

  The default password length is 36 characters and the default style includes Letters A-Z a-z and numbers 0-9.  
  Both of those defaults are easy to tweak using the optional flags.  
  
## Optional flags  

#### Use the optional -h flag for help.

```bash
./password_gen.sh -h
```

#### Use the optional -l flag to set the password length.
```bash
    ./password_gen.sh -l20   #Sets password length to 20 characters.  
    ./password_gen.sh -l50   #Sets password length to 50 characters.  
```

#### Use the optional -s flag to modify the character-set used to create the password:
```
    ./password_gen.sh -sA (same as default.  Letters A-za-z numbers 0-9 No symbols)
    ./password_gen.sh -sS (Symbols subset!@+*=#$%&, Letters and Numbers).
    ./password_gen.sh -sH (Hyphens every 4 characters, Letters and Numbers)
    ./password_gen.sh -sL (Letters only)
    ./password_gen.sh -sU (UPPERCASE LETTERS ONLY)
    ./password_gen.sh -sC (Comprehensive:  all printable ASCII characters)
```

White space doesn't matter. These are equivalent:  
```
    "./password_gen.sh -s H"   is the same as this:  "./password_gen.sh -sH"
```

## Combine Flags:
Use both the -l flag and the -s flag to tailor your password.  
  Create password of length 40 with Style: Symbols (includes letters and numbers):
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
- Install xclip and xsel as described below.

## Extra notes about the Linux clipboard:
In Linux, when you copy a string, it will stay in the clipboard buffer until you copy something new. This script copies the password to your clipboard for 40 seconds. Afterward, it clears the clipboard and pastes the uptime of your current boot into the clipboard simply to have something to overwrite it with, covering up all traces of your password.  

## Tools for the cleanup:  
I use two Linux command line tools to help with cleanup and copy/pasting the hidden password:  **xsel** and **xclip**
```
  sudo apt install xsel xclip
```
This command below eliminates all copies of your password that may be sitting around in both the clipboard and any shell variable:  
```
xsel -bc && uptime | xclip && clear
```

## Storing passwords
Linux has an excellent command line tool for generating and storing passwords.  You should check it out.  Installation:  
```sudo apt install passwd```

I never adapted to using it, and I was already using GPG, so my routine involves storing all my sensitive notes and passwords in a single directory as basic text files that I then encrypt with gpg.  After the file is encrypted, I secure-delete the unencrypted text file using **srm**.  

GPG is its own bundle of joy, but if you are this deep into security, you absolutely must dig into it.  Signed code pushed to Github requires that you have a GPG (or PGP) key, so dig in there and learn about GPG keys for other purposes.  I've even gone so far as to generate and store GPG keys on Yubikeys, but that it for another day....  

## The whole enchilada:
If you are curious about my storage/encryption/deletion routine, here it is:  
1. In terminal, I create a password.  
2. Copy/paste the password into a text file in my gpg directory.  
3. Paste into whatever service I'm engaging with.  
4. **gpg** --encrypt the text file where password was stored.  
5. **srm** the unencrypted text file.
6. Backup the entire GPG directory onto another drive.

For the record, I stopped using internal hard drives for anything other than storing the OS and configurations.  I do all my development work and data storage on external drives. If speed is an issue, I will temporarily move to an internal nvme drive, but then back to an external drive once I'm done.  My backup routine includes backing up the internal drives to an external one so that I always have all my configurations, and backing up my external drive to a second external drive so that I always have backups of everything.  You think I've had a computer or two crash on me?  And yes, I'm moving toward using NixOS given my mode of operation.

### A note about Secure Removal: SRM
Use **srm** to "secure remove" files on your drives.  Obviously, nothing can remove your stuff if it is part of a RAID system or on an SSD and various external platforms.  But you should try anyway. The **srm* command is in a package named **secure-delete**:  
```
sudo apt install secure-delete
man srm
srm file-to-delete
```
### Third-Party Password Managers
Password managers are a primary target for industrial-strength hacking teams. I avoid all third-party password manager thingies.  Sorry.  I know a lot of people need them, but if you are this deep into this document, you don't need them, and should not waste your time on them.  

### Changelog
2023-11-22: Adopted auto-clipboard functionality and cleanup.  
2023-10-27: Updated README.  Documented script. Cleaned up order, and added COMPREHENSIVE style to script.  
2023-09-15: Tweaked README.  Still learning markup formatting rules...  
2023-06-30:Changed H flag to K.  Tweaked notes throughout.  
2023-06-10:added -h help flag, and updated this readme.  
2022-08-16:Using 'random" instead of "urandom"  
2022-08-06 all files adding signature to commit  
