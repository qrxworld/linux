# Linux Setup
This repository contains all of my personal data and is used as context for my QRx metaverse 

## Setup
- Run setup for your OS: ./projects/$OS/setup.sh
- To override or change API keys, create a ~/.ENV with the following

### Environment variables
```sh
#!/bin/bash
export OS='arch|mint|termux'
export API_OPENROUTER='sk-v1-12345'
```

### Firefox
- Go to about:config
- Aceppt the warning about changing settings
- Search for layout.css.devPixelsPerPx 
-- By default it is -1 (off)
-- .5 shrinks it by 50%, 1.5 zooms it by 50%

## Files
./packages.csv - Contains a list of packages to install across all platforms that can

## Audio Configuration

To configure external audio, try the following:

```sh
# List your sinks
pactl list sinks

# Set the default sink to HDMI ID #
pactl set-default-sink
```
