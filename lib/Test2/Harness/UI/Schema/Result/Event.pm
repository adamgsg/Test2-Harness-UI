package Test2::Harness::UI::Schema::Result::Event;
use strict;
use warnings;

use parent qw/DBIx::Class::Core/;

__PACKAGE__->table('events');
__PACKAGE__->add_columns(qw/event_ui_id job_ui_id stamp event_id stream_id/);
__PACKAGE__->set_primary_key('event_ui_id');

__PACKAGE__->belongs_to(job => 'Test2::Harness::UI::Schema::Result::Job', 'job_ui_id');

__PACKAGE__->has_many(facets => 'Test2::Harness::UI::Schema::Result::Facets', 'event_ui_id');

sub run { shift->job->run }
sub user { shift->job->run->user }

1;
