#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Indicator;

my $s = Net::PulseMeter::Sensor::Indicator->new("foo");
my $r = Redis->new;
    
subtest 'describe .event' => sub {
    $s->redis->flushdb;
    $s->event(11);
    ok(
        $r->get($s->value_key) == 11,
        "it saves value"
    );
};

done_testing();
