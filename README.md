# wtf
How do I use this again??

Create your own "help" files on a per-directory basis.

# Quick Start
Clone this repo and then run
```
./install.sh
```
Which will create a symlink to your home directory and will update your .bashrc for you.

Then just go to some directory and
```
mkwtf
```
Your editor of choice will open and you can write your notes. Then you can view your notes by being in the same directory (or a child directory) and asking
```
wtf
```

If `mkwtf` opens a spooky editor, that means your `EDITOR` environment variable isn't set properly. Find and fix (or add) this line in your ~/.bash_profile:
```
export EDITOR=subl  # This will make you edit using sublime text
```
