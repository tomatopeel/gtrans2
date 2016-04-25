# gtrans2

### Description 

gtrans2.pl is an irssi script written in Perl to leverage the Google Translate v2 API. It requires a legitimate Google Translate v2 API key which implements usage-based pricing. If not wanting to pay Google any more dollars, please see similar script leveraging the Bing Translate API, whose use is free up to 2M chars per day at time of writing: https://github.com/thomasodot/btrans

### Usage

```
/gt2 -k [API key] -s [source lang] -t [target lang]

```

If executed in status window, will affect the default source/target langs, else will affect the channel source/target lang and switch whether enabled on the given channel.
