#!/usr/bin/perl
use warnings;
use strict;

use Irssi;
use WWW::Google::Translate;
use Data::Dumper;

use vars qw/$VERSION %IRSSI/;

$VERSION = "0.20";
%IRSSI = (
    authors     => 'Thomas O\'Dot',
    contact     => 'https://github.com/thomasodot',
    name        => 'gtrans2',
    description => 'On-the-fly translations with Google Translate v2 API',
    license     => 'public domain',
    changed     => '25/04/2016',
    url         => 'https://github.com/thomasodot'
);

my $wgt = WWW::Google::Translate->new(
	{
		key				=>	'none',
		default_source	=>	'en',
		default_target	=>	'de',
	}
);

my $chans = {};

sub entry_point {

	my ($arguments, $server, $channel) = @_;
	my @args = Irssi::command_parse_options('gt2', $arguments);
	my $opts = $args[0];

	# set api key if given
	if (exists $opts->{k}) {
		$wgt->{key} = $opts->{k};
	}

	# enable for given channel if any
	my $cname;
	if ($channel) {
		$cname = $channel->{name};
		$chans->{$cname}{enabled} = !$chans->{$cname}{enabled};
		$chans->{$cname}{window} = Irssi::active_win();
	}

	# set source lang if given
	if (exists $opts->{s}) {
		if ($cname) {
			$chans->{$cname}{source} = $opts->{s};
		} else {
			$wgt->{default_source} = $opts->{s};
		}
	}

	# set target lang
	if (exists $opts->{t}) {
		if ($channel) {
			$chans->{$cname}{target} = $opts->{t};
		} else {
			$wgt->{default_target} = $opts->{t};
		}
	}

}

sub sig_message_public {
	my ($server, $msg, $nick, $nick_addr, $target) = @_;

	if (	exists $chans->{$target} &&
			$chans->{$target}{enabled} &&
			$wgt->{key} ne 'none') {

		my $win = $chans->{$target}{window};
		my $translated = translate($msg, $target);
		$win->print("< $nick> $translated");
	}
}

sub set_api_key {
	my ($api_key) = @_;
	$wgt->{'key'} = $api_key;
}

sub translate {
	my ($in, $cname) = @_;
	my $t = $wgt->translate(
		{
			q => $in,
			source => $chans->{$cname}{source},
			target => $chans->{$cname}{target},
		} 
	);
	my $result = '';

	for my $translation (@{ $t->{data}->{translations} }) {
		$result = $result . $translation->{translatedText};
	}
	return $result;
}

Irssi::command_bind('gt2', 'entry_point');
Irssi::command_set_options('gt2', '-k -s -t');
Irssi::signal_add('message public', 'sig_message_public');
