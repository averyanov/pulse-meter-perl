#!perl

use warnings;
use strict;
use lib 't/tlib';
use Test::More;
use MockedRedis;
use Net::PulseMeter::Sensor::Base;
use Net::PulseMeter::Sensor::Timelined::UniqCounter;

my $r = MockedRedis->new;
Net::PulseMeter::Sensor::Base->redis($r);
my $s = Net::PulseMeter::Sensor::Timelined::UniqCounter->new("foo");
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
