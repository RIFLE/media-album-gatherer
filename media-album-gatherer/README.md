Media album gatherer
==========================
By RIFLE
--------------------------

What can this script do?
----------------

This script is able to gather an album into a specified directory from one which <br />
is somewhat unclean. Assume keeping half of a thousand of tracks in a single folder <br />
with no structure. If your audiofiles' metadata is marked with an appropriate album, <br />
you are able to gather 'em with this script. <br />


Dependencies
----------------

`mediainfo` package

Install with:

    sudo snap install mediainfo


V1.0 instruction
----------------

Put the script into the source folder with mediafiles and execute it.

Next, provide it with:<br />
    
    * path to destination folder which either exists or will be created after confirmation
    * media file extension, e.g.: mp3, flac, alac.
    * media file album (full or its substring)

It will prompt you with everything mentioned above.


Quick notes
---------------

Script may struggle to do its job if copying from another device to the current because of
either no permission on execution at the external device or other inappropriate rights configuration.
