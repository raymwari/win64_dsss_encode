# win64_dsss_encode
A direct sequence spread spectrum steganography  demonstration on an audio file in win64 assembler (encode).

# Resources:
https://youtu.be/-1mxYWvfVWQ?si=ePddoL3WGzPw7eEy

# Prerequisites:
https://www.nasm.us  <br>
https://www.godevtool.com

# More
## Error codes (check stderr):
https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-

## Usage
Encodes text stored in `embed.txt` into an audio file `in.mp3` and outputs a file `out.mp3`.

## About the pseudo random noise generator:
Uses a `seed of 0x2000` on a `spread factor 5`. Your welcome to test fit different constant values in the generator and see if you can get an even better spread or/and persistence across different compression mechanisms. Maybe try an even higher spread factor.

## Important:
Code is not format locked, maybe be used on a variety of file types including `.wav`, `.mp4`, `.jpg` (not recommended) and more

## Next steps:
Investigate github's wierd alignment on `ecodes.asm`. <br>
Decoding the encoding.
