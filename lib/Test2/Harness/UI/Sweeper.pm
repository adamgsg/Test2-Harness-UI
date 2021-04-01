package Test2::Harness::UI::Sweeper;
use strict;
use warnings;

our $VERSION = '0.000055';

use Test2::Harness::UI::Util::HashBase qw{
    <config
    <interval
};

sub sweep {
    my $self = shift;

    my $db_type = $self->config->guess_db_driver;

    my $interval;
    if ($db_type eq 'PostgreSQL') {
        $interval = "< NOW() - INTERVAL '$self->{+INTERVAL}'";
    }
    elsif ($db_type =~ m/mysql/i) {
        $interval = "< NOW() - INTERVAL $self->{+INTERVAL}";
    }
    else {
        die "Not sure how to format interval for '$db_type'";
    }

    my $runs = $self->config->schema->resultset('Run')->search(
        {
            pinned => 'false',
            added => \$interval,
        },
    );

    while (my $run = $runs->next()) {
        my $jobs = $run->jobs;

        while (my $job = $jobs->next()) {
            $job->coverages->delete;
            $job->events->delete;
            $job->delete;
        }

        $run->delete;
    }

    return;
}

1;
