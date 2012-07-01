#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use PulseMeter::Sensor::Timelined::Average;

my $s = PulseMeter::Sensor::Timelined::Average->new("foo");
my $r = Redis->new;
$r->flushdb;

$s->event(1);
$s->event(2);

my $key = $s->current_raw_data_key;
ok(
    $r->hget($key, "sum") == 3,
    "it saves events sum to interval"
);
ok(
    $r->hget($key, "count") == 2,
    "it saves events count to interval"
);


done_testing();
