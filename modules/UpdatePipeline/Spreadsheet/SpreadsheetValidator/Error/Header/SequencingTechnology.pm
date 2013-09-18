package UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Header::SequencingTechnology;

use Moose;
extends 'UpdatePipeline::Spreadsheet::SpreadsheetValidator::Error::Common';

# defaults 
has 'location' => ( is => 'ro', isa => 'Str', default => 'Sequencing Technology');

# note: think about moving this to default for each error type
sub _build__allowed_formats
{
    my ($self) = @_;
    my @allowed = ('string','integer');
    return \@allowed;
}

sub check_format
{
    my ($self) = @_;
    my $pass = 0;

    if($self->cell_contents =~ m/^illumina|454|slx$/i)
    {
        # valid sequencing tech
        $self->type('ok');
        $self->description('Valid sequencing technology');
        $self->message('"'.$self->cell_contents.'" is a valid sequencing technology');
        $self->user_action('No action required');
        $pass = 1;
    }
    elsif($self->cell_format eq 'blank' || $self->cell_format eq 'empty') 
    {
        # no title supplied
        $self->type('error');
        $self->description('Invalid sequencing technology');
        $self->message('No sequencing technology supplied');
        $self->user_action('Supply valid sequencing technology (illumina, 454 or slx)');
    }
    else
    {
        # unknown seq tech
        $self->type('error');
        $self->description('Invalid sequencing technology');
        $self->message('"'.$self->cell_contents.'" is not a valid sequencing technology');
        $self->user_action('Supply valid sequencing technology (illumina, 454 or slx)');        
    }
    
    return $pass;    
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;