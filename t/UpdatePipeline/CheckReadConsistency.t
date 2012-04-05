#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most tests => 12;
    use_ok('UpdatePipeline::CheckReadConsistency');
    use UpdatePipeline::VRTrack::LaneMetaData;
    use UpdatePipeline::Validate;
    use VRTrack::VRTrack;
    use UpdatePipeline::VRTrack::Project;
    use UpdatePipeline::VRTrack::Sample;
    use UpdatePipeline::VRTrack::Library;
    use UpdatePipeline::VRTrack::Lane;
    use UpdatePipeline::VRTrack::File;
    use UpdatePipeline::VRTrack::LaneMetaData;
    use UpdatePipeline::VRTrack::Study;
    use UpdatePipeline::Exceptions;
}

#create a vrtrack object
my $vrtrack = VRTrack::VRTrack->new({database => "vrtrack_test",host => "localhost",port => 3306,user => "root",password => undef});

#make sure that there is no leftover test data in the test database
delete_test_data($vrtrack);

VRTrack::Species->create($vrtrack, 'SomeBacteria' );
my $vproject = UpdatePipeline::VRTrack::Project->new(name => 'My project', external_id => 1234, _vrtrack => $vrtrack)->vr_project();
my $vstudy = UpdatePipeline::VRTrack::Study->new(accession => 'EFG456',_vr_project => $vproject)->vr_study();
$vproject->update;
my $vr_sample = UpdatePipeline::VRTrack::Sample->new(name => 'My name',common_name => 'SomeBacteria',accession => "ABC123", _vrtrack => $vrtrack,_vr_project => $vproject)->vr_sample();
my $vr_library = UpdatePipeline::VRTrack::Library->new(name => 'My library name', external_id  => 123,fragment_size_from => 123,fragment_size_to => 999, _vrtrack => $vrtrack,_vr_sample  => $vr_sample)->vr_library();
my $vr_lane = UpdatePipeline::VRTrack::Lane->new(name  => '1234_5#6', total_reads => 100000 ,_vrtrack => $vrtrack,_vr_library => $vr_library)->vr_lane();


my $lane_metadata = UpdatePipeline::VRTrack::LaneMetaData->new(name => '1234_5#6',_vrtrack => $vrtrack)->lane_attributes;
my @studies = ('EFG456');
my $validator = UpdatePipeline::Validate->new(study_names => \@studies, _vrtrack => $vrtrack);



#######################################################
#Core tests for UpdatePipeline::CheckReadConsistency.pm 
#######################################################
my $consistency_evaluator = UpdatePipeline::CheckReadConsistency->new(  _vrtrack => $vrtrack
                                                                      , environment => 'test'
                                                                     );
isa_ok( $consistency_evaluator, 'UpdatePipeline::CheckReadConsistency' );
can_ok( $consistency_evaluator, 'read_counts_are_consistent' );
can_ok( $consistency_evaluator, '_database_name' );
can_ok( $consistency_evaluator, '_config_settings' );
can_ok( $consistency_evaluator, '_full_path_by_lane_name' );
can_ok( $consistency_evaluator, '_full_path_by_lane_name' );
can_ok( $consistency_evaluator, '_fastq_file_names_by_lane_name' );
ok( $consistency_evaluator->_database_name eq 'vrtrack_test', 'Database name is correct.' );

#the directory root is set in the "config.yml". This root is bound 
#to a database name. See "config.yml" for details
ok( $consistency_evaluator->_fastq_root_path eq 't/data/', 'Root directory for the vrtrack fastq files could be traced via config.yml.' );


#set the _lane_name explicitly (for test purposes only)
my $vr_file = UpdatePipeline::VRTrack::File->new(   name => '1234_5#6_1.fastq.gz'
                                                  , md5 => 'abc1231343432432432'
                                                  , _vrtrack => $vrtrack
                                                  , _vr_lane => $vr_lane
                                                )->vr_file();

my $vr_file2 = UpdatePipeline::VRTrack::File->new(  name => '1234_5#6_2.fastq.gz'
                                                  , md5 => 'abc1231343432432433'
                                                  , _vrtrack => $vrtrack
                                                  , _vr_lane => $vr_lane
                                                )->vr_file();

my $fastq_file_names = $consistency_evaluator->_fastq_file_names_by_lane_name('1234_5#6');                               
is_deeply([sort @$fastq_file_names], [ '1234_5#6_1.fastq.gz', '1234_5#6_2.fastq.gz'], 'Test file (*.gz) names have been traced via the class methods.');

ok($consistency_evaluator->read_counts_are_consistent( { lane_name => '1234_5#6', irods_read_count => 20 } ) == 1, 'Read numbers are consistent...');

delete_test_data($vrtrack);
sub delete_test_data
{
  my $vrtrack = shift;
  $vrtrack->{_dbh}->do('delete from project where name="My project"');
  $vrtrack->{_dbh}->do('delete from sample where name in ("My name")');
  $vrtrack->{_dbh}->do('delete from individual where name in ("My name")');
  $vrtrack->{_dbh}->do('delete from species where name="SomeBacteria"');
  $vrtrack->{_dbh}->do('delete from library where name in ("My library name")');
  $vrtrack->{_dbh}->do('delete from seq_centre where name in ("SC")');
  $vrtrack->{_dbh}->do('delete from seq_tech where name in ("SLX")');
  $vrtrack->{_dbh}->do('delete from lane where name in ("1234_5#6","9876_5#4")');
  $vrtrack->{_dbh}->do('delete from file where name in ("1234_5#6_1.fastq.gz","1234_5#6_1.fastq.gz")');
  $vrtrack->{_dbh}->do('delete from file where lane_id in (8000)');
  $vrtrack->{_dbh}->do('delete from study where acc in ("EFG456")');
}
