#!/usr/bin/perl
use strict;
use JSON::XS;
use Encode;
my $knobsyncts=`cat knobsyncts.txt|tr -d "\r\n"`;
my $HEXLATE6=$ARGV[0];
my $HEXLONE6=$ARGV[1];
my $LEVEL=$ARGV[2];
binmode(STDOUT, ":utf8");
my %request;
my $request=\%request;
$request->{params}{newLevelUpMsgId}=$LEVEL*1;
$request->{params}{energyGlobGuids}=[];
$request->{params}{knobSyncTimestamp}=$knobsyncts*1;
$request->{params}{playerLocation}="$HEXLATE6,$HEXLONE6";
my $json_string    = encode_json($request);
print $json_string;
close(FILE);
