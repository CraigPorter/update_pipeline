package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Experiment::MateFilename;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Mate Filename' );

sub check_format
{
    my ($self) = @_;
    my $pass = 0;

    # cell does not contain string
    if($self->cell_format eq 'string')
    {
        $self->type('ok');
        $self->description('Valid file name');
        $self->message('"'.$self->cell_contents.'" is a valid file name');
        $self->user_action('No action required');
        $pass = 1;          
    }
    elsif($self->cell_format eq 'undefined' || $self->cell_format eq 'empty')
    {
        # no file supplied (single-ended)
        $self->type('ok');
        $self->description('Valid file name');
        $self->message('Lane is single ended');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'pathname') 
    {
        # full path supplied
        $self->type('error');
        $self->description('Invalid file name');
        $self->message('Full path name supplied');
        $self->user_action('Remove path from name');
    }
    elsif($self->cell_format eq 'blank') 
    {
        # no file supplied
        $self->type('error');
        $self->description('Invalid file name');
        $self->message('Mate file name is whitespace.');
        $self->user_action('Supply valid file name');
    }
    else
    {
        # other error
        $self->type('error');
        $self->description('Invalid study title');
        $self->message('"'.$self->cell_contents.'" is not a valid file name');
        $self->user_action('Supply valid file name');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;