package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common;

use Moose;
use Scalar::Util qw(looks_like_number);

extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error';

has 'cell_contents'    => ( is => 'ro', isa => 'Maybe[Str]', required => 1);
has '_allowed_formats' => ( is => 'ro', isa => 'ArrayRef',   lazy_build => 1 );

sub cell_format
{
    my ($self) = @_;

    my $status = '';
    if(! defined $self->cell_contents)
    { 
        $status = "undefined"; 
    }
    elsif($self->cell_contents eq '' )
    { 
        $status = "empty"; 
    }
    elsif($self->cell_contents =~ m/^\s+$/ )
    { 
        $status = "blank"; 
    }
    elsif( looks_like_number $self->cell_contents )
    { 
        $status = "number";
        $status = "integer" if $self->cell_contents =~ m/^\d+$/;
        $status = "zero"    if $self->cell_contents == 0;
    }
    elsif( $self->cell_contents =~ m/^\d{2}\.\d{2}\.\d{4}$/ )
    {
        $status = "date"; 
    }
    elsif( $self->cell_contents =~ m/\// )
    {
        $status = "pathname"; 
    }
    else
    {
        $status = "string";
    }

    return $status;
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;