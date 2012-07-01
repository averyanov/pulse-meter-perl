#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::UniqCounter;

my $s = Net::PulseMeter::Sensor::UniqCounter->new("foo");
my $r = Redis->new;
    
subtest 'describe .event' => sub {
    $s->redis->flushdb;
    $s->event($_) for (1, 1, 2, 2, 2, 3);
    
    ok(
        $r->scard($s->value_key) == 3,
        "it counts uniq values"
    );
};

done_testing();
