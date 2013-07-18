#!/usr/bin/perl
package TestPackage;
=pod
A simple class for pkgger
  my $pkg = TestPackage->new('name')
	    TestPackage->new()
        new TestPackage('pkgname')
  
  $pkg->get_pkgfile
  $pkg->set_pkgfile
  $pkg->msg
  $pkg->debug
  $pkg->warn
  $pkg->error	
=cut

use Logger;
use TestCase;

# used to record the package name and number
my %all_pkg = ();

sub new {
    my ( $class, $name, $log ) = @_;
	#
	if( exists $all_pkg{$name} ){
	    $all_pkg{$name} += 1;
	}else{
	    $all_pkg{$name} = 1;
	}
	# check is logfile has been setuped
	unless ($log->isa("Logger")){
	    $log = Logger->new("pkg_". $name . "_" . $all_pkg{$name});
	}
    my $self = bless {}, $class;
    $self->{'pkgname'} = $name;
	$self->{'pkgnum'} = $all_pkg{$name};
	$self->{'log'} = $log;
    return $self;
}

sub get_pkgname {
    my $self = shift;
    return $self->{'pkgname'};
}

sub get_testcases {

}

sub add_testcase {

}

sub remove_testcase {

}

sub shift_testcase {

}

sub run {

}

1;