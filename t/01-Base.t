#!perl

use warnings;
use strict;
use Test::More;
use Redis;
use Net::PulseMeter::Sensor::Base;

subtest 'describe .name' => sub {
    my $base = Net::PulseMeter::Sensor::Base->new("foo");
    ok(
        $base->name eq "foo",
        "it returns sensor name"
    );
};

subtest 'describe .redis' => sub {
    my $base = Net::PulseMeter::Sensor::Base->new("foo",
        redis => {
            host => '127.0.0.1'
        }
    );
    ok(
        ref($base->redis) eq 'Redis',
        "it returns redis instance"
    );

    ok(
        $base->redis->{server} eq '127.0.0.1:6379',
        "it uses connection options from constructor"
    );
};


done_testing();
