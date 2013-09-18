package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyName;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Study Name');

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
        # valid study title
        $self->type('ok');
        $self->description('Valid study title');
        $self->message('"'.$self->cell_contents.'" is a valid study name');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no title supplied
        $self->type('error');
        $self->description('Invalid study title');
        $self->message('No study name supplied');
        $self->user_action('Supply valid study name');
    }
    else
    {
        # expected string but got number or date
        $self->type('error');
        $self->description('Invalid study title');
        $self->message('"'.$self->cell_contents.'" is not a valid study name');
        $self->user_action('Supply valid study name');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;