#!/usr/bin/perl
use warnings;
use strict;

use Irssi;
use WWW::Google::Translate;

use vars qw/$VERSION %IRSSI/;

$VERSION = "0.10";
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

sub entry_point {

}

sub set_api_key {
	my ($api_key) = @_;
	$wgt->{'key'} = $api_key;
}

sub translate {
	my $in = $_[0];
	my $t = $wgt->translate( { q => $in } );

	for my $translation (@{ $t->{data}->{translations} }) {
		print $translation->{translatedText};
	}
}

Irssi::command_bind('gt2', 'entry_point');
Irssi::command_parse_options('gt2', '-k -c');
