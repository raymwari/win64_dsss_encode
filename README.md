# win64_dsss_encode
A direct sequence spread spectrum steganography inspired implementation (deterministic encoding & recovery)

## Resources:
https://youtu.be/-1mxYWvfVWQ?si=ePddoL3WGzPw7eEy

## Prerequisites:
https://www.nasm.us  <br>
https://www.godevtool.com

## Error codes (check stderr):
https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-

## Usage:
Encodes text stored in `embed.txt` into an audio file `in.mp3` and outputs a file `out.mp3`.

## About the pseudo random noise generator:
Uses a `seed of 0x2000` on a `spread factor 15`. Your welcome to test fit different constant values in the generator and see if you can get an even better spread. Maybe try an even higher spread factor.

## Important:
Code is not format locked, considering it's just a generic layer over raw bits, and this means it may be used on a variety of file types including `.wav`, `.mp4`, `.jpg` (not recommended) and more. This however means that it assumes the cover is raw and uncompressed data eg `.wav`, and is therefore not compression resistant if otherwise. In theory, if you ran the encoder through a `.wav` file, then compressed to `.mp3`, you should get your data back by decompressing the `.mp3` and running the resulting `.wav` through the decoder... 

## Next steps:
Decoding the encoding.
