#!perl

use warnings;
use strict;
use lib 't/tlib';
use Test::More;
use MockedRedis;
use Net::PulseMeter::Sensor::Base;
use Net::PulseMeter::Sensor::Timelined::Median;

my $r = MockedRedis->new;
Net::PulseMeter::Sensor::Base->redis($r);
my $s = Net::PulseMeter::Sensor::Timelined::Median->new("foo");
$r->flushdb;

$s->event(1);
$s->event(2);

my $key = $s->current_raw_data_key;
my $data = {$r->zrange($key, 0, -1, "WITHSCORES")};
my @values = values(%$data);
is_deeply(
    [sort(@values)],
    [1, 2],
    "it saves values as scores in ordered set"
);

done_testing();
