package Net::PulseMeter::Sensor::Timelined::Counter;
use strict;
use warnings 'all';

use base qw/Net::PulseMeter::Sensor::Timeline/;

sub aggregate_event {
    my ($self, $key, $value) = @_;
    $self->r->incrby($key, $value);
}

1;
