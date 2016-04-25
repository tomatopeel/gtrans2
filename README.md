# Description 

gtrans2.pl is an irssi script written in Perl to leverage the Google Translate v2 API. It requires a legitimate Google Translate v2 API key which implements usage-based pricing. For a free translator irssi script, please see https://github.com/thomasodot/btrans

# Usage

```
mv path/to/gtrans2.pl ~/.irssi/scripts/gtrans2.pl

/run gtrans2

/gt2 -k [API key] -s [source lang] -t [target lang]

```

If executed in status window, will affect the default source/target langs, else will affect the channel source/target lang and switch whether enabled on the given channel.
