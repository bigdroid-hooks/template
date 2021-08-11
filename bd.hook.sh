#           Variables - BigDroid Internals
#           - Only for advanced scripting -
#           ###############################

#   SRC_DIR             % The 'src' dir is the mountpoint of the project operating-system IMAGE.
#   
#   HOOK_DIR            % This variable points to the root-dir
#                       % of a bigdroid hook which is being run.
#   
#   MOUNT_DIR           % The parent dir which holds other child mountpoint dirs.
#                       % Followed by: system, secondary_ramdisk, initial_ramdisk and install_ramdisk.
#                       % Use `SYSTEM_MOUNT_DIR`, `SECONDARY_RAMDISK_MOUNT_DIR`
#                       % `INITIAL_RAMDISK_MOUNT_DIR`, `INSTALL_RAMDISK_MOUNT_DIR` variables for path.
#   
#   TMP_DIR             % You can use this dir for storing temporary files.
#                       % It's equivalent '/tmp' dir but for bigdroid hooks.
#
#   SECONDARY_RAMDISK   % This is either true or false aka a bolean.
#                       % Depends on whether the project operating-system has a ramdisk.img
#
#   SYSTEM_IMAGE        % This points to the project system image (system.sfs or system.img) file.
#
#   @@ Tip: Also all the varaibles defined in the project `Bigdroid.meta` can be used.



#           General Functions - BigDroid Utils
#              - For easy hooks scripting -
#           ##################################
#
#   gclone              % Copy(rsync) files preserving all their attrs with progress indicator.
#                       % Example: `gclone "$HOOK_DIR/myfile.so" "$SYSTEM_DIR/lib64"`
#   
#   wipedir             % Easily wipe/empty a dir(childs) without removing it's parent.
#                       % Example: `wipedir "$INSTALL_RAMDISK_MOUNT_DIR/grub"`
#   
#   @@ Protip: Take a look at 'src/utils.sh'
#
#
#
#
#             libgearlock - GearLock utils
#     - Some native gearlock vars and functions -
#           ###############################
#
#   %% Simply take a look at 'https://github.com/bigdroid/bigdroid/blob/main/src/libgearlock.sh' to know
#   %% which gearlock variables and functions are available for use.



#               An example hook script
#           - To give you some quick idea -
#           ###############################

## Okay so here we go for the example...

# At first I wanna wipe up 'system/lib/hw'
wipedir "$SYSTEM_DIR/lib/hw";

# Now I want to merge my own hw files there from my HOOK_BASE (hooks/example_hook).
gclone "$HOOK_DIR/myhw/" "$SYSTEM_DIR/lib/hw";
# TIP: Now you might be thingking why don't we just do `rm -r "$SYSTEM_DIR/lib/hw"`
#      and then do `gclone "$HOOK_BASE/myhw" "$SYSTEM_DIR/lib/hw"` ?
#      
#      Well, as you see, with `wipedir` we are preserving the dir with
#      it's permissions and other file attriutes, while that's not the
#      case if you directly use `rm`. For that case you need to re-set
#      the correct file attrs for the dir, thus requiring you to know
#      the correct attrs to apply.

# Okay now lets print a message on the terminal to let the user know that our hook was applied properly just for extra awesomeness, lol.
geco "Yay, my awesome $CODENAME is hooked into your system!"


# More things you do .........
