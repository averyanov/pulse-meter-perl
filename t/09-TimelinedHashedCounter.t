#!perl

use warnings;
use strict;
use lib 't/tlib';
use Test::More;
use MockedRedis;
use Net::PulseMeter::Sensor::Base;
use Net::PulseMeter::Sensor::Timelined::HashedCounter;

my $r = MockedRedis->new;
Net::PulseMeter::Sensor::Base->redis($r);
my $s = Net::PulseMeter::Sensor::Timelined::HashedCounter->new("foo");
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
