#!/usr/bin/perl
use warnings;
use strict;
use feature ':5.10';

use WWW::Google::Translate;
use Getopt::Std;

my $wgt = WWW::Google::Translate->new(
	{
		key				=>	'none',
		default_source	=>	'en',
		default_target	=>	'de',
	}
);

sub main {
	my $oref = {};
	getopts('k:t:', $oref);
	set_api_key($oref->{'k'});
	translate($oref->{'t'});
}

sub set_api_key {
	my ($api_key) = @_;
	$wgt->{'key'} = $api_key;
}

sub translate {
	my $in = $_[0];
	my $t = $wgt->translate( { q => $in } );

	for my $translation (@{ $t->{data}->{translations} }) {
		say $translation->{translatedText};
	}
}

main();
