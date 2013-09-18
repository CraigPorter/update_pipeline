package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::Size;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Size');

# note: think about moving this to default for each error type
sub _build__allowed_formats
{
    my ($self) = @_;
    my @allowed = ('integer');
    return \@allowed;
}

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'integer' || $self->cell_format eq 'number' )
    {
        # valid size
        $self->type('ok');
        $self->description('Valid size');
        $self->message('"'.$self->cell_contents.'" is a valid size');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'empty') 
    {
        # empty
        $self->type('warning');
        $self->description('Invalid size');
        $self->message('No size in Gg supplied - expected integer');
        $self->user_action('Supply valid size (integer)');
    }
    else
    {
        # not integer or empty
        $self->type('error');
        $self->description('Invalid size');
        $self->message('"'.$self->cell_contents.'" is not a valid size');
        $self->user_action('Supply valid size (integer)');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;