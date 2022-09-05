<h1 align="center"><code>Volume</code></h1>
<p align="center">Simple Volume controller</p>

## About
Volume is a dead simple volume control utility inspired from xbacklight.

## Installation
Its just a perl script
download it, make it executable and put somewhere in your $PATH

## Manually
with wget
``` bash
wget https://raw.githubusercontent.com/anhsirk0/volume/master/volume.pl -O volume
```
### or
with curl
``` bash
curl https://raw.githubusercontent.com/anhsirk0/volume/master/volume.pl --output volume
```
making it executable
```bash
chmod +x volume
```
copying it to $PATH (~/.local/bin/ , this step is optional)
```bash
cp volume ~/.local/bin/
```

## Usage
```text
usage: volume [-get] [-inc/-dec/-set PERCENT] [-mute]

    -get, --get 		Get current volume
    -mute, --mute 		Toggle mute
    -set, --set=INT 		 Set current volume
    -inc, --inc=INT 		 Increase current volume
    -dec, --dec=INT 		 Decrease current volume
    -h, --help 		     	 show this help message
```
