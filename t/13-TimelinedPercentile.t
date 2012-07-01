#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Timelined::Percentile;

my $s = Net::PulseMeter::Sensor::Timelined::Percentile->new("foo");
my $r = Redis->new;
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
