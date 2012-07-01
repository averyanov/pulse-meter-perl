#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use PulseMeter::Sensor::Timelined::HashedCounter;

my $s = PulseMeter::Sensor::Timelined::HashedCounter->new("foo");
my $r = Redis->new;
$r->flushdb;

$s->event({foo => 1, bar => 2});
$s->event({foo => 10, bar => 20});

my $key = $s->current_raw_data_key;
is_deeply(
    {$r->hgetall($key)},
    {foo => 11, bar => 22},
    "it saves multiple events count to interval"
);

done_testing();
