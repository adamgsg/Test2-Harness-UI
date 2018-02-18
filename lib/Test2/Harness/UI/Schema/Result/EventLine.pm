use utf8;
package Test2::Harness::UI::Schema::Result::EventLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Test2::Harness::UI::Schema::Result::EventLine

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::InflateColumn::Serializer>

=item * L<DBIx::Class::InflateColumn::Serializer::JSON>

=item * L<DBIx::Class::Tree::AdjacencyList>

=item * L<DBIx::Class::UUIDColumns>

=back

=cut

__PACKAGE__->load_components(
  "InflateColumn::DateTime",
  "InflateColumn::Serializer",
  "InflateColumn::Serializer::JSON",
  "Tree::AdjacencyList",
  "UUIDColumns",
);

=head1 TABLE: C<event_lines>

=cut

__PACKAGE__->table("event_lines");

=head1 ACCESSORS

=head2 event_line_id

  data_type: 'uuid'
  default_value: uuid_generate_v4()
  is_nullable: 0
  size: 16

=head2 event_id

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=head2 tag

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=head2 facet

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 content

  data_type: 'text'
  is_nullable: 1

=head2 content_json

  data_type: 'jsonb'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "event_line_id",
  {
    data_type => "uuid",
    default_value => \"uuid_generate_v4()",
    is_nullable => 0,
    size => 16,
  },
  "event_id",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
  "tag",
  { data_type => "varchar", is_nullable => 0, size => 8 },
  "facet",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "content",
  { data_type => "text", is_nullable => 1 },
  "content_json",
  { data_type => "jsonb", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</event_line_id>

=back

=cut

__PACKAGE__->set_primary_key("event_line_id");

=head1 RELATIONS

=head2 event

Type: belongs_to

Related object: L<Test2::Harness::UI::Schema::Result::Event>

=cut

__PACKAGE__->belongs_to(
  "event",
  "Test2::Harness::UI::Schema::Result::Event",
  { event_id => "event_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07048 @ 2018-02-11 19:33:16
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Al+Op3n3ItRMuMx00EL7iw

__PACKAGE__->inflate_column(
    content_json => {
        inflate => DBIx::Class::InflateColumn::Serializer::JSON->get_unfreezer('content_json', {}),
        deflate => DBIx::Class::InflateColumn::Serializer::JSON->get_freezer('content_json', {}),
    },
);

sub verify_access {
    my $self = shift;
    my ($type, $user) = @_;

    my $event = $self->event;

    return $event->verify_access($type, $user);
}

sub TO_JSON {
    my $self = shift;
    my %cols = $self->get_columns;

    # Inflate
    $cols{content_json} = $self->content_json;

    return \%cols;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
