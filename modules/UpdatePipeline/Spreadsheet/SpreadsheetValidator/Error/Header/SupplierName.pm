package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SupplierName;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Supplier Name');

# note: think about moving this to default for each error type
sub _build__allowed_formats
{
    my ($self) = @_;
    my @allowed = ('string');
    return \@allowed;
}

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'string')
    {
        # valid name
        $self->type('ok');
        $self->description('Valid supplier name');
        $self->message('"'.$self->cell_contents.'" is a valid supplier name');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no name supplied
        $self->type('warning');
        $self->description('Invalid supplier name');
        $self->message('No supplier name supplied');
        $self->user_action('Supply valid supplier name');
    }
    else
    {
        # expected string but got number or date
        $self->type('warning');
        $self->description('Invalid supplier name');
        $self->message('"'.$self->cell_contents.'" is not a valid supplier name');
        $self->user_action('Supply valid supplier name');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;