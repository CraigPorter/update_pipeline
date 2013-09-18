package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SangerContact;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Sanger Contact');

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
        # valid contact
        $self->type('ok');
        $self->description('Valid sanger contact');
        $self->message('"'.$self->cell_contents.'" is a valid sanger contact');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no contact
        $self->type('warning');
        $self->description('Invalid sanger contact');
        $self->message('No sanger contact supplied');
        $self->user_action('Supply valid sanger contact');
    }
    else
    {
        # expected string but got number or date
        $self->type('warning');
        $self->description('Invalid sanger contact');
        $self->message('"'.$self->cell_contents.'" is not a valid sanger contact');
        $self->user_action('Supply valid sanger contact');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;