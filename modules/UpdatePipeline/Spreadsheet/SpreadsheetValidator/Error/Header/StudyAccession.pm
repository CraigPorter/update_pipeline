package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::StudyAccession;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Study Accession');

# note: think about moving this to default for each error type
sub _build__allowed_formats
{
    my ($self) = @_;
    my @allowed = ('string','integer','empty');
    return \@allowed;
}

sub check_format
{
    my ($self) = @_;
    my $pass = 0;
    
    if($self->cell_format eq 'string' || $self->cell_format eq 'integer' || $self->cell_format eq 'empty')
    {
        # valid study accession
        $self->type('ok');
        $self->description('Valid study accession');
        $self->message('"'.$self->cell_contents.'" is a valid study accession');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank') 
    {
        # whitespace supplied
        $self->type('warning');
        $self->description('Invalid study accession');
        $self->message('Supply name is whitespace.');
        $self->user_action('Supply valid study accession or empty cell');
    }
    else
    {
        # error 
        $self->type('error');
        $self->description('Invalid study accession');
        $self->message('"'.$self->cell_contents.'" is not a valid study accession');
        $self->user_action('Supply valid study accession or empty cell');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;