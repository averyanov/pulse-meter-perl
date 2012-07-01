#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Timelined::UniqCounter;

my $s = Net::PulseMeter::Sensor::Timelined::UniqCounter->new("foo");
my $r = Redis->new;
$r->flushdb;

$s->event("foo");
$s->event("bar");
$s->event("foo");

my $key = $s->current_raw_data_key;
ok(
    $r->scard($key) == 2,
    "it counts uniq values"
);

done_testing();
