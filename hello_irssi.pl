#!/usr/bin/env perl
use warnings;
use strict;

use Irssi;

use vars qw/$VERSION %IRSSI/;

$VERSION = "0.1";

%IRSSI = (
    authors     => 'Patrice Clement',
    contact     => 'monsieurp@gentoo.org',
    name              => 'my_aliases',
    description => 'All my beloved aliases in Perl format now!',
    license     => 'BSD',
    changed     => '23/04/2016',
    url         => 'http://perdu.com'
);

sub cmd_hello {
    # data   - contains parameters - (scrapped away here)
    # server - the active server in window
    # witem  - the active window item (eg. channel, query)
    #          or undef if the window is empty
    my ($data, $server, $witem) = @_;

    # Check for server connection.
    if (!$server || !$server->{connected}) {
        Irssi::print('You must be connected to a server!');
        return;
    }

    # Is the window empty?
    if ($witem) {
        # No. Ok, are we talking in a channel or a query?
        if ($witem->{type} =~ /(CHANNEL|QUERY)/) {
            # Format the IRC message.
            my $insult = 'Hello from irssi!';
            my $msg = sprintf('MSG %s %s', $witem->{name}, $insult);
            # Send it!
            $witem->command($msg);
            # Done.
        }
    }
}

# Bind function a command:
# /my_hello will call cmd_hello().
Irssi::command_bind('my_hello', 'cmd_hello');
