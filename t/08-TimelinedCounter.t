#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Timelined::Counter;

my $s = Net::PulseMeter::Sensor::Timelined::Counter->new("foo");
my $r = Redis->new;
$r->flushdb;

$s->event(1);
$s->event(2);

my $key = $s->current_raw_data_key;
ok(
    $r->get($key) == 3,
    "it saves events count to interval"
);

done_testing();
