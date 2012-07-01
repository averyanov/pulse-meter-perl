#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use PulseMeter::Sensor::Timelined::Min;

my $s = PulseMeter::Sensor::Timelined::Min->new("foo");
my $r = Redis->new;
$r->flushdb;

$s->event(1);
$s->event(2);
$s->event(1);

my $key = $s->current_raw_data_key;
ok(
    [$r->zrange($key, 0, -1, "WITHSCORES")]->[1] == 1,
    "it saves min to interval"
);

done_testing();
