TAudioIO provides a drop component for doing modifying Audio I/O on the fly.
Two sound components TAudioIn, and TAudioOut are provided.

The components were built under D3, but should work under D2.

Files
    TAudioIO.pas                  Defines the components
    TAudioIO.hlp                  Help file for the components

In addition, the following files are provided for reading different
format wave files as 16 bit PCM.  These are NOT used in the component,
but in one demo

    UAFDLL.DLL		          Read in wav and au files
    UAFDEFS.PAS                   Definitions for UAFDLL

Demostration programs
    TAudioSineDemo                Synthesizes a pure tone in real time

    TAudioFileOutDemo		  Plays a sound file, slowing changing 
                                  the channel from left to right.

    TAudioInputDemo		  Just computes the min and max of the
                                  incomming signal


TAudioIO provides context sensitive help for the audio components for
Delphi Version 3.

To install, copy TAudioIO.Hlp to the Delphi 3.0 help directory.
This is usually c:\Program files\Borland\Delphi 3\Help
Then Edit Delphi3.CFG and include the line

   :Link TAudioIO.hlp

Now you must make Delphi 3 recompile the help files, you can do this
by changing the date of DELPHI3.CNT.  If you have touch just

   Touch DELPHI3.CNT 

Or just edit and save this file.

Now F1 should work on the components.

----------------------------------------------------------------------------

C++ Builder v1.0
modified by: Dean Bowers  Zsystems Software
Homepage http://www.fortunecity.com/meltingpot/barnsbury/215/index.htm

I have a free Subliminal Perception Program and a few components at this 
site!

I take no credit for this excellent component. John Mertus did all the 
work and deserves all credit. 

I know very little about programming but very few components are 
available for C++ Builder Relative to Delphi. I modified the 
source code to work with C++ Builder v1.0 because 
I have more time than money. Hope this is useful and John doesn't mind my 
modifications to work with C++ Builder.

Copy all files in the CB1.ZIP file to your C++ Builder Library
Directory.

Use Component--Install--Browse--AudioIO.pas to install the component into 
the library, always backup your library files with C++ Builder 1.0 before
installing new components due to bugs in the VCL.