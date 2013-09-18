package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::LibraryName;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Library Name');

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'string' || $self->cell_format eq 'integer')
    {
        # valid library name
        $self->type('ok');
        $self->description('Valid sample name');
        $self->message('"'.$self->cell_contents.'" is a valid sample name');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no name supplied
        $self->type('error');
        $self->description('Invalid library name');
        $self->message('No library name supplied');
        $self->user_action('Supply valid library name');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid library name');
        $self->message('"'.$self->cell_contents.'" is not a valid library name');
        $self->user_action('Supply valid library name');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;