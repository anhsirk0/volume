#!/usr/bin/env perl

# Simple xbacklight like utility for volume control on pulseaudio
# dependencies: `pactl` and `amixer`
# https://github.com/anhsirk0/volume

use strict;
use Getopt::Long;

my $get;
my $set;
my $inc;
my $dec;
my $mute;
my $help;
my $new_volume;

sub print_help {
    my $help_text = qq{usage: volume [-get] [-inc/-dec/-set PERCENT] \n
    -get, --get \t\t Get current volume
    -mute, --mute \t\t Toggle mute
    -set, --set=INT \t\t Set current volume
    -inc, --inc=INT \t\t Increase current volume
    -dec, --dec=INT \t\t Decrease current volume
    -h, --help \t\t\t show this help message\n};
    print $help_text;
}

sub get_current_volume {
    my $amixer = `amixer get Master`;
    unless ($amixer) {
	print "amixer is not installed\n";
	exit
    }
    my ($volume) = $amixer =~ /\[([0-9]+)%\]/;
    return  int($volume);
}

sub main {
    GetOptions (
        "help|h" => \$help,
        "set=i" => \$set,
        "inc=i" => \$inc,
        "dec=i" => \$dec,
        "mute" => \$mute,
        "get" => \$get,
        ) or die("Error in command line arguments\n");

    if ($mute) {
	system('pactl set-sink-mute @DEFAULT_SINK@ toggle');
	exit;
    }

    my $volume = get_current_volume();
    if ($get) {
	print $volume . "\n";
	exit;
    }

    if ($inc || $inc eq 0) {
	$new_volume = $volume + $inc;
    } elsif ($dec || $dec eq 0) {
	$new_volume = $volume - $dec;
    } elsif ($set || $set eq 0) {
	$new_volume = $set;
    }

    if ($new_volume) {
	if ($new_volume < 0) { $new_volume = 0; } # min volume 0
	if ($new_volume > 400) { $new_volume = 400; } # max volume 400
	if ($new_volume == $volume) { exit; }
	my $sink = '@DEFAULT_SINK@';
	system("pactl set-sink-volume $sink $new_volume%");
	exit;
    } else {
	print_help();
	exit
    }
}

main();
