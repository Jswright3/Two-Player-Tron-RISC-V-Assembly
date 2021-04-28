# Two-Player-Tron-RISC-V-Assembly
A Two player Tron like game written in RISC-V Assembly Code.  I compiled and ran using RARS Assembler.

---------------INSTRUCTIONS AND NOTES FOR USE IN RARS ASSEMBLER------------------

The Red Player is controlled using standard WASD controls

Blue player is controlled using IJKL controls.

Upon Crashing into any border, opposing player, or self will
cause the game to stop.

Run Conditions:

Bitmap Display and MMIO need to be open and connected
Bitmap Display should be set to 256x256

Run speed should be set to max.

Speed can be controlled in code through variable found in "wait"
label (Has note in code)

NOTE: The current speed is optimized for my computer and may not be
appropriate on other systems.
