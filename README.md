# win64_dsss_encode
A direct sequence spread spectrum steganography inspired implementation ... (deterministic encoding & recovery)

## Resources:
https://youtu.be/-1mxYWvfVWQ?si=ePddoL3WGzPw7eEy

## Prerequisites:
https://www.nasm.us  <br>
https://www.godevtool.com

## Error codes (check stderr):
https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-

## Usage:
Encodes text stored in `embed.txt` into an audio file `fire_treasure.mp3` and outputs a file `out.mp3`. View `config.cfg` ...

## About the pseudo random noise generator:
Uses a seed of `0x2000` and a spread factor `15` on a modulus equal to the size of the target cover (max : `5242880` bytes) to prevent the data overflowing ...

## Important:
Code is not format locked, considering it's just a generic layer over raw bits. This means it may be used on a variety of file types. <br>
For persistence, cover bytes are meant to be __raw__ and __uncompressed__ eg, `.wav` from which further processing like compression and encryption may follow ... 

## Next steps:
Decoding the encoding ... <br>
https://github.com/raymwari/win64_dsss_decode
